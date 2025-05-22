package br.com.jxtech.fiapfintech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionManager {
    private static ConnectionManager connectionManager;

    public static ConnectionManager getInstance() {
        if (connectionManager == null) {
            connectionManager = new ConnectionManager();
        }

        return connectionManager;
    }

    public Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Driver Oracle carregado com sucesso!");

            connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@oracle.fiap.com.br:1521:ORCL",
                    "RM559996",
                    "150702"
            );

            System.out.println("Conexão com o banco de dados estabelecida com sucesso!");

        } catch (ClassNotFoundException e) {
            System.err.println("Erro ao carregar o driver Oracle: " + e.getMessage());
            throw new RuntimeException("Driver Oracle não encontrado", e);
        } catch (SQLException e) {
            System.err.println("Erro ao conectar ao banco de dados: " + e.getMessage());
            throw new RuntimeException("Erro ao conectar ao banco de dados", e);
        }

        return connection;
    }
}
