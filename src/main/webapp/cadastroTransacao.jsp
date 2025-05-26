<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastrar Transação - Fintech</title>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/global/custom.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2>Cadastrar Transação</h2>
        
        <%-- Display error message if present --%>
        <c:if test="${not empty erro}">
            <div class="alert alert-danger" role="alert">
                ${erro}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/transacoes" method="post">
            <input type="hidden" name="action" value="insert">
            
            <div class="mb-3">
                <label for="tipo" class="form-label">Tipo</label>
                <select class="form-select" id="tipo" name="tipo" required>
                    <option value="">Selecione o tipo</option>
                    <option value="ganho">Ganho</option>
                    <option value="dívida">Dívida</option>
                    <option value="despesa">Despesa</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="descricao" class="form-label">Descrição</label>
                <input type="text" class="form-control" id="descricao" name="descricao" required>
            </div>
            
            <div class="mb-3">
                <label for="valor" class="form-label">Valor</label>
                <input type="number" step="0.01" min="0" class="form-control" id="valor" name="valor" required>
            </div>
            
            <div class="mb-3">
                <label for="data" class="form-label">Data</label>
                <input type="date" class="form-control" id="data" name="data" required>
            </div>
            
            <button type="submit" class="btn btn-primary">Salvar Transação</button>
            <a href="${pageContext.request.contextPath}/transacoes" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
    
    <script src="resources/js/bootstrap.bundle.min.js"></script>
</body>
</html> 