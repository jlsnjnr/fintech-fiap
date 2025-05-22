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
        <h1 class="h5 mb-0">Olá, Júnior</h1>
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
    </div>

    <div class="row mb-4 w-50">
      <div class="col text-center">
        <button class="btn btn-primary w-100 d-flex flex-column align-items-center">
          <i class="ph ph-paper-plane-tilt"></i>
          Cadastrar
        </button>
      </div>
      <div class="col text-center">
        <button class="btn btn-light w-100 d-flex flex-column align-items-center">
          <i class="ph ph-money"></i>
          Todas
        </button>
      </div>
      <div class="col text-center">
        <button class="btn btn-light w-100 d-flex flex-column align-items-center">
          <i class="ph ph-thumbs-down"></i>
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
      <div class="row mb-2">
        <div class="col"><small class="text-muted">Nome</small></div>
        <div class="col"><small class="text-muted">Tipo</small></div>
        <div class="col"><small class="text-muted">Categoria</small></div>
        <div class="col"><small class="text-muted">Transação</small></div>
        <div class="col"><small class="text-muted">Valor</small></div>
      </div>

      <div class="row g-2 list-item mb-2">
        <div class="col">
          <div>
            <p class="mb-0">Pagamento Aluguel</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Saída</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Moradia</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Boleto</p>
          </div>
        </div>

        <div class="col">
          <div>
            <p class="mb-0 text-danger">R$ 1400,00</p>
          </div>
        </div>
      </div>

      <div class="row g-2 mb-2">
        <div class="col">
          <div>
            <p class="mb-0">Salário Mensal</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Entrada</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Trabalho</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Transferência</p>
          </div>
        </div>

        <div class="col">
          <div>
            <p class="mb-0 text-success">R$ 3000,00</p>
          </div>
        </div>
      </div>

      <div class="row g-2 mb-2">
        <div class="col">
          <div>
            <p class="mb-0">Compra Supermercado</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Saída</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Alimentação</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Cartão de Crédito</p>
          </div>
        </div>

        <div class="col">
          <div>
            <p class="mb-0 text-danger">R$ 350,00</p>
          </div>
        </div>
      </div>

      <div class="row g-2 mb-2">
        <div class="col">
          <div>
            <p class="mb-0">Investimento Tesouro Direto</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Saída</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Investimento</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Transferência</p>
          </div>
        </div>

        <div class="col">
          <div>
            <p class="mb-0 text-danger">R$ 500,00</p>
          </div>
        </div>
      </div>

      <div class="row g-2 mb-2">
        <div class="col">
          <div>
            <p class="mb-0">Freelance Pagamento</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Entrada</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Trabalho Extra</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Pix</p>
          </div>
        </div>

        <div class="col">
          <div>
            <p class="mb-0 text-success">R$ 800,00</p>
          </div>
        </div>
      </div>

      <div class="row g-2 mb-2">
        <div class="col">
          <div>
            <p class="mb-0">Conta de Luz</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Saída</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Contas Fixas</p>
          </div>
        </div>
        <div class="col">
          <div>
            <p class="mb-0">Boleto</p>
          </div>
        </div>

        <div class="col">
          <div>
            <p class="mb-0 text-danger">R$ 150,00</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
<script src="resources/js/bootstrap.bundle.min.js"></script>
</body>
</html>