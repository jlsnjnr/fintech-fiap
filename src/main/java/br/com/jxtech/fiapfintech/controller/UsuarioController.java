package br.com.jxtech.fiapfintech.controller;

import br.com.jxtech.fiapfintech.dao.UsuarioDAO;
import br.com.jxtech.fiapfintech.model.UsuarioModel;
import br.com.jxtech.fiapfintech.util.JwtUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/usuario/*")
public class UsuarioController extends HttpServlet {
    private UsuarioDAO usuarioDAO;

    @Override
    public void init() throws ServletException {
        usuarioDAO = new UsuarioDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        try {
            if ("/cadastrar".equals(pathInfo)) {
                cadastrarUsuario(request, response);
            } else if ("/login".equals(pathInfo)) {
                realizarLogin(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro no banco de dados");
        }
    }

    private void cadastrarUsuario(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (nome == null || email == null || senha == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dados incompletos");
            return;
        }

        try {
            if (usuarioDAO.buscarPorEmail(email) != null) {
                response.sendError(HttpServletResponse.SC_CONFLICT, "Email já cadastrado");
                return;
            }

            String senhaHash = gerarHashSenha(senha);

            UsuarioModel usuario = new UsuarioModel();
            usuario.setNome(nome);
            usuario.setEmail(email);
            usuario.setSenha(senhaHash);

            usuarioDAO.cadastrar(usuario);
            response.setStatus(HttpServletResponse.SC_CREATED);
        } catch (SQLException e) {
            System.err.println("Erro ao cadastrar usuário: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Erro ao cadastrar usuário: " + e.getMessage());
        }
    }

    private void realizarLogin(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        StringBuilder buffer = new StringBuilder();
        String line;
        try (java.io.BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }
        }

        com.google.gson.Gson gson = new com.google.gson.Gson();
        LoginRequest loginRequest = gson.fromJson(buffer.toString(), LoginRequest.class);

        if (loginRequest == null || loginRequest.email == null || loginRequest.senha == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dados incompletos");
            return;
        }

        try {
            UsuarioModel usuario = usuarioDAO.buscarPorEmail(loginRequest.email);
            if (usuario == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuário não encontrado");
                return;
            }

            String senhaHash = gerarHashSenha(loginRequest.senha);
            if (!usuario.getSenha().equals(senhaHash)) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Senha incorreta");
                return;
            }

            usuarioDAO.atualizarUltimoLogin(usuario.getIdUsuario());

            String token = JwtUtil.generateToken(usuario.getEmail(), usuario.getIdUsuario());

            Cookie cookie = new Cookie("jwt", token);
            cookie.setHttpOnly(true);
            cookie.setPath("/");
            cookie.setMaxAge(86400);
            response.addCookie(cookie);

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            System.err.println("Erro ao realizar login: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Erro ao realizar login: " + e.getMessage());
        }
    }

    private String gerarHashSenha(String senha) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(senha.getBytes());
            StringBuilder hexString = new StringBuilder();
            
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Erro ao gerar hash da senha", e);
        }
    }

    private static class LoginRequest {
        String email;
        String senha;
    }
} 