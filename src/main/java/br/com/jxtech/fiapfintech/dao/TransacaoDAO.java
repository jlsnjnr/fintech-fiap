package br.com.jxtech.fiapfintech.dao;

import br.com.jxtech.fiapfintech.model.Transacao;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TransacaoDAO {
    private Connection connection;

    public TransacaoDAO() {
        this.connection = ConnectionManager.getInstance().getConnection();
    }

    public void inserir(Transacao transacao) throws SQLException {
        String sql = "INSERT INTO transacoes (tipo, descricao, valor, data, id_usuario) VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = this.connection.prepareStatement(sql)) {
            stmt.setString(1, transacao.getTipo());
            stmt.setString(2, transacao.getDescricao());
            stmt.setDouble(3, transacao.getValor());
            stmt.setDate(4, java.sql.Date.valueOf(transacao.getData()));
            stmt.setInt(5, transacao.getIdUsuario());
            stmt.executeUpdate();
        }
    }

    public List<Transacao> listarTransacoes(int idUsuario) throws SQLException {
        List<Transacao> transacoes = new ArrayList<>();
        String sql = "SELECT id, tipo, descricao, valor, data, id_usuario FROM transacoes WHERE id_usuario = ? ORDER BY data DESC";
        
        try (PreparedStatement stmt = this.connection.prepareStatement(sql)) {
            stmt.setInt(1, idUsuario);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                transacoes.add(new Transacao(
                    rs.getInt("id"),
                    rs.getString("tipo"),
                    rs.getString("descricao"),
                    rs.getDouble("valor"),
                    rs.getDate("data"),
                    rs.getInt("id_usuario")
                ));
            }
        }
        return transacoes;
    }

    public List<Transacao> listarTransacoesFiltradas(int idUsuario, String tipo, LocalDate dataInicio, LocalDate dataFim) throws SQLException {
        List<Transacao> transacoes = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT id, tipo, descricao, valor, data, id_usuario FROM transacoes WHERE id_usuario = ? AND 1=1");
        List<Object> parameters = new ArrayList<>();

        if (tipo != null && !tipo.isEmpty()) {
            sql.append(" AND tipo = ?");
            parameters.add(tipo);
        }

        if (dataInicio != null) {
            sql.append(" AND data >= ?");
            parameters.add(java.sql.Date.valueOf(dataInicio));
        }

        if (dataFim != null) {
            sql.append(" AND data <= ?");
            parameters.add(java.sql.Date.valueOf(dataFim));
        }
        
        sql.append(" ORDER BY data DESC");

        try (PreparedStatement stmt = this.connection.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            stmt.setInt(paramIndex++, idUsuario);

            for (Object param : parameters) {
                stmt.setObject(paramIndex++, param);
            }
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                transacoes.add(new Transacao(
                    rs.getInt("id"),
                    rs.getString("tipo"),
                    rs.getString("descricao"),
                    rs.getDouble("valor"),
                    rs.getDate("data"),
                    rs.getInt("id_usuario")
                ));
            }
        }
        return transacoes;
    }

    public double calcularTotalEntradas(int idUsuario) throws SQLException {
        double total = 0.0;
        String sql = "SELECT COALESCE(SUM(valor), 0.0) AS total FROM transacoes WHERE tipo = 'ganho' AND id_usuario = ?";
        
        try (PreparedStatement stmt = this.connection.prepareStatement(sql)) {

            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }
        }
        return total;
    }

    public double calcularTotalSaidas(int idUsuario) throws SQLException {
        double total = 0.0;
        String sql = "SELECT COALESCE(SUM(valor), 0.0) AS total FROM transacoes WHERE (tipo = 'dívida' OR tipo = 'despesa') AND id_usuario = ?";
        
        try (PreparedStatement stmt = this.connection.prepareStatement(sql)) {

            stmt.setInt(1, idUsuario);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getDouble("total");
            }
        }
        return total;
    }

    public double calcularSaldoTotal(int idUsuario) throws SQLException {
        double totalEntradas = calcularTotalEntradas(idUsuario);
        double totalSaidas = calcularTotalSaidas(idUsuario);
        return totalEntradas - totalSaidas;
    }

    public void closeConnection() {
        try {
            if (this.connection != null && !this.connection.isClosed()) {
                this.connection.close();
            }
        } catch (SQLException e) {
            System.err.println("Erro ao fechar a conexão da DAO: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
