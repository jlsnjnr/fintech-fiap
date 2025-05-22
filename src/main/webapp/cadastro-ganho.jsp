<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cadastro de Transações</title>
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
        .btn-toggle {
            width: 48%;
            font-weight: bold;
            color: white;
        }
        .btn-saida {
            background-color: #e52e4d;
        }
        .btn-entrada {
            background-color: #33cc95;
        }
        .btn-toggle:focus {
            outline: none;
            box-shadow: none;
        }
        .btn-cadastrar {
            background-color: #1e6ef7;
            color: white;
            font-weight: bold;
            width: 100%;
        }
    </style>
</head>
<body>
<%@include file="header.jsp"%>

<div class="form-container">
    <div class="form-title">Cadastrar</div>
    <form action="ganho" method="post">
        <div class="form-group">
            <input type="text" name="nome" placeholder="Nome" class="form-control" required>
        </div>

        <div class="form-group text-center">
            <div class="btn-group" role="group">
                <button type="button" class="btn btn-toggle btn-saida">Saída</button>
                <button type="button" class="btn btn-toggle btn-entrada">Entrada</button>
            </div>
        </div>

        <div class="form-group">
            <input type="text" name="categoria" placeholder="Categoria" class="form-control">
        </div>

        <div class="form-group">
            <input type="text" name="cartao" placeholder="Cartão" class="form-control">
        </div>

        <div class="form-group">
            <input type="text" name="tipo" placeholder="Tipo da transação (ex: pix)" class="form-control">
        </div>

        <div class="form-group">
            <input type="text" name="valor" placeholder="Valor" class="form-control" required>
        </div>

        <button type="submit" class="btn btn-cadastrar mt-3">Cadastrar</button>
    </form>
</div>

<%@include file="footer.jsp" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    // Marcar botão como selecionado e salvar em input escondido
    $(document).ready(function () {
        let tipo = '';

        $('.btn-saida').click(function () {
            tipo = 'saida';
            $(this).addClass('active');
            $('.btn-entrada').removeClass('active');
            ensureHiddenInput(tipo);
        });

        $('.btn-entrada').click(function () {
            tipo = 'entrada';
            $(this).addClass('active');
            $('.btn-saida').removeClass('active');
            ensureHiddenInput(tipo);
        });

        function ensureHiddenInput(value) {
            if ($('#tipo-hidden').length === 0) {
                $('<input>').attr({
                    type: 'hidden',
                    id: 'tipo-hidden',
                    name: 'tipoTransacao',
                    value: value
                }).appendTo('form');
            } else {
                $('#tipo-hidden').val(value);
            }
        }
    });
</script>
</body>
</html>
