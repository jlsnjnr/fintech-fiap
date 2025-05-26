<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
        <div class="container">
            <div class="row align-items-center">
                <div class="col">
                    <h1>Olá, <span id="nomeUsuario"></span></h1>
                    <p class="mb-0">R$ ${saldoTotal}</p>
                    <span class="text-muted">Saldo atual</span>
                </div>
                <div class="col-auto d-flex align-items-center">
                    <button id="logoutButton" class="btn btn-outline-secondary btn-sm me-2">Sair</button>
                    <i class="ph ph-bell"></i>
                    <img src="https://avatars.githubusercontent.com/u/70169714?v=4" alt="Profile Picture" class="profile-photo rounded-circle">
                </div>
            </div>

            <div class="row buttons-row">
                <div class="col-12 col-md-4 col-lg-3">
                    <a href="${pageContext.request.contextPath}/transacoes?action=new" class="btn btn-register w-100 d-flex flex-column align-items-center">
                        <i class="ph ph-paper-plane-tilt mb-2"></i>
                        Cadastrar Transação
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="card-section">
        <div class="container">
            <div class="row g-3">
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Entradas</h5>
                            <p class="card-text">R$ ${totalEntradas}</p>
                            <i class="ph ph-arrow-circle-up card-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Saídas</h5>
                            <p class="card-text">R$ ${totalSaidas}</p>
                            <i class="ph ph-arrow-circle-down card-icon"></i>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card total-card">
                        <div class="card-body">
                            <h5 class="card-title">Total</h5>
                            <p class="card-text">R$ ${saldoTotal}</p>
                            <i class="ph ph-currency-dollar card-icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="main-content">
        <div class="container">
            <div class="list-section">
                <div class="row list-header">
                    <div class="col-1">ID</div>
                    <div class="col-2">Tipo</div>
                    <div class="col-4">Descrição</div>
                    <div class="col-2">Valor</div>
                    <div class="col-3">Data</div>
                </div>
                <div class="list-items">

                    <c:if test="${empty listaTransacoes}">
                        <div class="row list-item">
                            <div class="col-12 text-center">Nenhuma transação encontrada.</div>
                        </div>
                    </c:if>
                    <c:forEach var="transacao" items="${listaTransacoes}">
                        <div class="row list-item">
                             <div class="col-1">${transacao.id}</div>
                            <div class="col-2">${transacao.tipo}</div>
                            <div class="col-4">${transacao.descricao}</div>
                            <div class="col-2 <c:if test='${transacao.tipo == "divida"}'>text-danger</c:if><c:if test='${transacao.tipo == "ganho"}'>text-success</c:if>">R$ <fmt:formatNumber value="${transacao.valor}" pattern="#,##0.00"/></div>
                             <div class="col-3"><fmt:formatDate value="${transacao.utilDate}" pattern="dd/MM/yyyy"/></div>
                        </div>
                    </c:forEach>
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

        document.getElementById('logoutButton').addEventListener('click', async function() {
            try {
                const response = await fetch('${pageContext.request.contextPath}/logout', {
                    method: 'POST'
                });

                if (response.ok) {
                    // Remover cookie (opcional, backend deve invalidar)
                    document.cookie = 'jwt=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
                    // Redirecionar
                    window.location.href = '${pageContext.request.contextPath}/index.jsp';
                } else {
                    const error = await response.text();
                    alert('Erro ao fazer logout: ' + error);
                }
            } catch (error) {
                console.error('Erro durante o logout:', error);
                alert('Erro ao fazer logout');
            }
        });
    </script>
</body>
</html>