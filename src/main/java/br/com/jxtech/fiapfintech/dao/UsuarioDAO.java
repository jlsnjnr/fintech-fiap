package br.com.jxtech.fiapfintech.dao;

import br.com.jxtech.fiapfintech.model.UsuarioModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO {
    private Connection connection;

    public UsuarioDAO() {
        this.connection = ConnectionManager.getInstance().getConnection();
    }

    public void cadastrar(UsuarioModel usuario) throws SQLException {
        String sql = "INSERT INTO T_USUARIOS (id_usuario, nome, email, senha) VALUES (seq_usuario.NEXTVAL, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getSenha());
            stmt.executeUpdate();
        }
    }

    public UsuarioModel buscarPorEmail(String email) throws SQLException {
        String sql = "SELECT * FROM T_USUARIOS WHERE email = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return new UsuarioModel(
                    rs.getLong("id_usuario"),
                    rs.getString("nome"),
                    rs.getString("email"),
                    rs.getString("senha"),
                    rs.getDate("data_criacao"),
                    rs.getDate("ultimo_login")
                );
            }
        }
        return null;
    }

    public void atualizarUltimoLogin(Long idUsuario) throws SQLException {
        String sql = "UPDATE T_USUARIOS SET ultimo_login = SYSDATE WHERE id_usuario = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setLong(1, idUsuario);
            stmt.executeUpdate();
        }
    }

    public List<UsuarioModel> listarTodos() throws SQLException {
        List<UsuarioModel> usuarios = new ArrayList<>();
        String sql = "SELECT * FROM T_USUARIOS";
        
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                usuarios.add(new UsuarioModel(
                    rs.getLong("id_usuario"),
                    rs.getString("nome"),
                    rs.getString("email"),
                    rs.getString("senha"),
                    rs.getDate("data_criacao"),
                    rs.getDate("ultimo_login")
                ));
            }
        }
        return usuarios;
    }
} 