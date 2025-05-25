<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
  <title>Fintech</title>
  <link href="resources/css/bootstrap.min.css" rel="stylesheet">
  <link href="resources/global/custom.css" rel="stylesheet">
  <link
          rel="stylesheet"
          type="text/css"
          href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/regular/style.css"
  />
  <link
          rel="stylesheet"
          type="text/css"
          href="https://cdn.jsdelivr.net/npm/@phosphor-icons/web@2.1.1/src/fill/style.css"
  />
</head>
<body>
<div class="header-section">
  <div class="container py-3">
    <div class="row align-items-center mb-3">
      <div class="col">
        <h1 class="h5 mb-0">Olá, <span id="nomeUsuario"></span></h1>
        <p class="mb-0">R$ 20,00</p>
        <p class="text-muted">Saldo atual</p>
      </div>

      <div class="col-auto d-flex align-items-center">
        <i class="ph ph-bell"></i>
        <img
                src="https://avatars.githubusercontent.com/u/70169714?v=4"
                alt="Profile Picture"
                class="profile-photo rounded-circle bg-secondary"
        >
      </div>

      <div class="row mb-4 justify-content-center">
        <div class="col-12 col-md-4 col-lg-3 mb-3">
          <a href="cadastro-divida.jsp" class="btn btn-primary w-100 d-flex flex-column align-items-center py-3">
            <i class="ph ph-paper-plane-tilt mb-2" style="font-size: 1.5rem;"></i>
            Cadastrar dívida
          </a>
        </div>
        <div class="col-12 col-md-4 col-lg-3 mb-3">
          <button class="btn btn-light w-100 d-flex flex-column align-items-center py-3">
            <i class="ph ph-money mb-2" style="font-size: 1.5rem;"></i>
            Ganhos
          </button>
        </div>
        <div class="col-12 col-md-4 col-lg-3 mb-3">
          <button class="btn btn-light w-100 d-flex flex-column align-items-center py-3">
            <i class="ph ph-thumbs-down mb-2" style="font-size: 1.5rem;"></i>
            Dívidas
          </button>
        </div>
      </div>
    </div>
  </div>

<div class="row g-3 mb-4 card-content">
  <div class="col">
    <div class="card">
      <div class="card-body">
        <div class="d-flex justify-content-between">
          <h5 class="card-title">Entradas</h5>
          <i class="bi bi-arrow-up-circle"></i>
        </div>
        <p class="card-text">R$ 5.000</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card">
      <div class="card-body">
        <div class="d-flex justify-content-between">
          <h5 class="card-title">Saídas</h5>
          <i class="bi bi-arrow-down-circle"></i>
        </div>
        <p class="card-text">R$ 5.000</p>
      </div>
    </div>
  </div>
  <div class="col">
    <div class="card text-white bg-success">
      <div class="card-body">
        <div class="d-flex justify-content-between">
          <h5 class="card-title">Total</h5>
          <i class="bi bi-currency-dollar"></i>
        </div>
        <p class="card-text">R$ 5.000</p>
      </div>
    </div>
  </div>
</div>

<div class="main-content">
  <div class="container">
    <div class="list-section">
      <div class="row header">
        <div>Nome</div>
        <div>Tipo</div>
        <div>Categoria</div>
        <div>Transação</div>
        <div>Valor</div>
      </div>

      <div class="row list-item">
        <div>Pagamento Aluguel</div>
        <div>Saída</div>
        <div>Moradia</div>
        <div>Boleto</div>
        <div class="text-danger">R$ 1400,00</div>
      </div>

      <div class="row list-item">
        <div>Salário Mensal</div>
        <div>Entrada</div>
        <div>Trabalho</div>
        <div>Transferência</div>
        <div class="text-success">R$ 3000,00</div>
      </div>

      <div class="row list-item">
        <div>Compra Supermercado</div>
        <div>Saída</div>
        <div>Alimentação</div>
        <div>Cartão de Crédito</div>
        <div class="text-danger">R$ 350,00</div>
      </div>

      <div class="row list-item">
        <div>Investimento Tesouro Direto</div>
        <div>Saída</div>
        <div>Investimento</div>
        <div>Transferência</div>
        <div class="text-danger">R$ 500,00</div>
      </div>

      <div class="row list-item">
        <div>Freelance Pagamento</div>
        <div>Entrada</div>
        <div>Trabalho Extra</div>
        <div>Pix</div>
        <div class="text-success">R$ 800,00</div>
      </div>

      <div class="row list-item">
        <div>Conta de Luz</div>
        <div>Saída</div>
        <div>Contas Fixas</div>
        <div>Boleto</div>
        <div class="text-danger">R$ 150,00</div>
      </div>
    </div>
  </div>
</div>
<script src="resources/js/bootstrap.bundle.min.js"></script>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    const nome = localStorage.getItem('nomeUsuario');
    const nomeSpan = document.getElementById('nomeUsuario');

    if (nome && nomeSpan) {
      nomeSpan.innerText = nome;
    } else {
      nomeSpan.innerText = 'usuário';
    }
  });
</script>
</body>
</html>