package br.com.jxtech.fiapfintech.controller;

import br.com.jxtech.fiapfintech.dao.TransacaoDAO;
import br.com.jxtech.fiapfintech.model.Transacao;
import br.com.jxtech.fiapfintech.util.JwtUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;

@WebServlet("/transacoes")
public class TransacaoController extends HttpServlet {

    private TransacaoDAO transacaoDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        transacaoDAO = new TransacaoDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        Integer idUsuario = getUserIdFromCookie(request);
        if (idUsuario == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        if (action == null || action.equals("list")) {
            try {
                List<Transacao> listaTransacoes = transacaoDAO.listarTransacoes(idUsuario);
                List<Transacao> transacoesParaJsp = new ArrayList<>();
                for (Transacao t : listaTransacoes) {
                    java.util.Date dataUtil = Date.from(t.getData().atStartOfDay(ZoneId.systemDefault()).toInstant());
                    java.sql.Date dataSql = java.sql.Date.valueOf(t.getData());
                    Transacao tForJsp = new Transacao(
                        t.getId(), t.getTipo(), t.getDescricao(), t.getValor(),
                        dataSql,
                        t.getIdUsuario()
                    );
                    transacoesParaJsp.add(tForJsp);
                }

                request.setAttribute("listaTransacoes", transacoesParaJsp);

                double totalEntradas = transacaoDAO.calcularTotalEntradas(idUsuario);
                double totalSaidas = transacaoDAO.calcularTotalSaidas(idUsuario);
                double saldoTotal = transacaoDAO.calcularSaldoTotal(idUsuario);

                request.setAttribute("totalEntradas", String.format("%.2f", totalEntradas));
                request.setAttribute("totalSaidas", String.format("%.2f", totalSaidas));
                request.setAttribute("saldoTotal", String.format("%.2f", saldoTotal));

                request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            } catch (SQLException e) {
                request.setAttribute("erro", "Erro ao carregar dados: " + e.getMessage());
                e.printStackTrace();
                request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            }
        } else if (action.equals("new")) {
            mostrarFormCadastro(request, response);
        } else if (action.equals("filter")) {
            try {
                String tipo = request.getParameter("filterTipo");
                String dataInicioStr = request.getParameter("filterDataInicio");
                String dataFimStr = request.getParameter("filterDataFim");

                LocalDate dataInicio = null;
                if (dataInicioStr != null && !dataInicioStr.isEmpty()) {
                    dataInicio = LocalDate.parse(dataInicioStr);
                }

                LocalDate dataFim = null;
                if (dataFimStr != null && !dataFimStr.isEmpty()) {
                    dataFim = LocalDate.parse(dataFimStr);
                }

                List<Transacao> listaTransacoes = transacaoDAO.listarTransacoesFiltradas(idUsuario, tipo, dataInicio, dataFim);
                List<Transacao> transacoesParaJsp = new ArrayList<>();
                for (Transacao t : listaTransacoes) {
                    java.sql.Date dataSql = java.sql.Date.valueOf(t.getData());
                    Transacao tForJsp = new Transacao(
                        t.getId(), t.getTipo(), t.getDescricao(), t.getValor(),
                        dataSql,
                        t.getIdUsuario()
                    );
                    transacoesParaJsp.add(tForJsp);
                }
                request.setAttribute("listaTransacoes", transacoesParaJsp);

                double totalEntradas = transacaoDAO.calcularTotalEntradas(idUsuario);
                double totalSaidas = transacaoDAO.calcularTotalSaidas(idUsuario);
                double saldoTotal = transacaoDAO.calcularSaldoTotal(idUsuario);

                request.setAttribute("totalEntradas", String.format("%.2f", totalEntradas));
                request.setAttribute("totalSaidas", String.format("%.2f", totalSaidas));
                request.setAttribute("saldoTotal", String.format("%.2f", saldoTotal));

                request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
            } catch (SQLException | DateTimeParseException e) {
                request.setAttribute("erro", "Erro ao aplicar filtro: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/transacoes");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/transacoes");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null && action.equals("insert")) {
            inserirTransacao(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/transacoes");
        }
    }

    private void mostrarFormCadastro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/cadastroTransacao.jsp").forward(request, response);
    }

    private void inserirTransacao(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer idUsuario = getUserIdFromCookie(request);
            if (idUsuario == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Usuário não autenticado.");
                return;
            }

            String tipo = request.getParameter("tipo");
            String descricao = request.getParameter("descricao");

            if (!isValidTipo(tipo)) {
                request.setAttribute("erro", "Tipo inválido. Use 'ganho', 'dívida' ou 'despesa'.");
                mostrarFormCadastro(request, response);
                return;
            }

            double valor;
            try {
                valor = Double.parseDouble(request.getParameter("valor"));
                if (valor <= 0) {
                    request.setAttribute("erro", "O valor deve ser maior que zero.");
                    mostrarFormCadastro(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                request.setAttribute("erro", "Valor inválido. Por favor, insira um número válido.");
                mostrarFormCadastro(request, response);
                return;
            }

            String dataStr = request.getParameter("data");
            LocalDate data;
            try {
                data = LocalDate.parse(dataStr);
                if (data.isAfter(LocalDate.now())) {
                    request.setAttribute("erro", "A data não pode ser futura.");
                    mostrarFormCadastro(request, response);
                    return;
                }
            } catch (DateTimeParseException e) {
                request.setAttribute("erro", "Data inválida. Use o formato AAAA-MM-DD.");
                mostrarFormCadastro(request, response);
                return;
            }

            if (descricao == null || descricao.trim().isEmpty()) {
                request.setAttribute("erro", "A descrição é obrigatória.");
                mostrarFormCadastro(request, response);
                return;
            }

            Transacao novaTransacao = new Transacao();
            novaTransacao.setTipo(tipo);
            novaTransacao.setDescricao(descricao.trim());
            novaTransacao.setValor(valor);
            novaTransacao.setData(data);
            novaTransacao.setIdUsuario(idUsuario);

            transacaoDAO.inserir(novaTransacao);

            response.sendRedirect(request.getContextPath() + "/transacoes");

        } catch (SQLException e) {
            request.setAttribute("erro", "Erro ao cadastrar transação no banco de dados: " + e.getMessage());
            e.printStackTrace();
            mostrarFormCadastro(request, response);
        } catch (Exception e) {
            request.setAttribute("erro", "Ocorreu um erro inesperado: " + e.getMessage());
            e.printStackTrace();
            mostrarFormCadastro(request, response);
        }
    }

    private boolean isValidTipo(String tipo) {
        return tipo != null && (tipo.equals("ganho") || tipo.equals("dívida") || tipo.equals("despesa"));
    }

    private Integer getUserIdFromCookie(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwt".equals(cookie.getName())) {
                    try {
                        Long userIdLong = JwtUtil.getUserIdFromToken(cookie.getValue());
                        if (userIdLong != null) {
                            return userIdLong.intValue();
                        } else {
                            System.err.println("Token JWT válido, mas ID do usuário ausente ou null.");
                            return null;
                        }
                    } catch (ExpiredJwtException | UnsupportedJwtException | MalformedJwtException | SignatureException | IllegalArgumentException e) {
                        System.err.println("Erro ao processar token JWT: " + e.getMessage());
                        return null;
                    }
                }
            }
        }
        return null;
    }
} 