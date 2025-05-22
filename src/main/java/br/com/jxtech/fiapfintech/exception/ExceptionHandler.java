package br.com.jxtech.fiapfintech.exception;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/error")
public class ExceptionHandler extends HttpServlet {
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        String servletName = (String) request.getAttribute("jakarta.servlet.error.servlet_name");
        String requestUri = (String) request.getAttribute("jakarta.servlet.error.request_uri");

        if (throwable != null) {
            if (throwable instanceof SQLException) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                    "Erro no banco de dados: " + throwable.getMessage());
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                    "Erro interno do servidor: " + throwable.getMessage());
            }
        } else if (statusCode != null) {
            response.sendError(statusCode);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Erro desconhecido");
        }
    }
} 