<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cadastro de Despesas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    <style>
        body {
            background-color: #f9f9f9;
        }
        .form-container {
            max-width: 500px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-title {
            font-size: 24px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 30px;
        }
        .form-control {
            margin-bottom: 15px;
            border-radius: 8px;
            padding: 15px;
            font-size: 16px;
        }
        .btn-cadastrar {
            background-color: #1e6ef7;
            color: white;
            font-weight: bold;
            width: 100%;
            border-radius: 8px;
            padding: 12px;
        }
    </style>
</head>
<body>
<%@include file="header.jsp"%>

<div class="form-container">
    <div class="form-title">Cadastrar Despesa</div>
    <form action="despesa" method="post">
        <input type="text" name="nome" placeholder="Nome" class="form-control" required>
        <input type="text" name="valor" placeholder="Valor" class="form-control" required>
        <input type="text" name="quantidade" placeholder="Quantidade" class="form-control">

        <button type="submit" class="btn btn-cadastrar">Cadastrar</button>
    </form>
</div>

<%@include file="footer.jsp" %>
<script src="resources/js/bootstrap.bundle.js"></script>
</body>
</html>
