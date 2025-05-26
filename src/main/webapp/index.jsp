<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="resources/global/login.css" rel="stylesheet">
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
    <div class="login-container">
        <div class="login-form">
            <div class="text-center mb-4">
                <h5 class="fs-1 text">🤑</h5>
                <h2 class="fs-3 text-login fw-bold">CONTRO.LY</h2>
                <span class="fs-6 text fw-lighter">Hora de se controlar.</span>
            </div>

            <form id="loginForm">
                <div class="mb-3">
                    <label for="email" class="form-label visually-hidden">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Seu email" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label visually-hidden">Senha</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="senha" placeholder="Senha" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="ph ph-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary">Entrar</button>
                </div>

                <div class="text-center">
                    <p class="mb-2">Ainda não tem conta?</p>
                    <a class="text-create-new-account" href="register.jsp">Crie aqui</a>
                </div>
            </form>
        </div>
    </div>

    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('loginForm').addEventListener('submit', async function(e) {
            e.preventDefault();

            const formData = new FormData(this);
            const data = {
                email: formData.get('email'),
                senha: formData.get('senha')
            };

            try {
                const response = await fetch('${pageContext.request.contextPath}/usuario/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                });

                if (response.ok) {
                    window.location.href = '${pageContext.request.contextPath}/dashboard';
                } else {
                    const error = await response.text();
                    alert(error);
                }
            } catch (error) {
                console.error('Erro:', error);
                alert('Erro ao fazer login');
            }
        });

        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.querySelector('i').classList.toggle('ph-eye');
            this.querySelector('i').classList.toggle('ph-eye-slash');
        });
    </script>
</body>
</html>