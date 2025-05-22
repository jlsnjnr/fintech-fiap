<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registro - CONTRO.LY</title>
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
                <span class="fs-6 text fw-lighter">Crie sua conta.</span>
            </div>

            <form id="registerForm">
                <div class="mb-3">
                    <label for="nome" class="form-label visually-hidden">Nome</label>
                    <input type="text" class="form-control" id="nome" name="nome" placeholder="Seu nome completo" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label visually-hidden">Email</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="Seu email" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label visually-hidden">Senha</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="senha" placeholder="Sua senha" required>
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="ph ph-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="confirmPassword" class="form-label visually-hidden">Confirmar Senha</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="confirmPassword" placeholder="Confirme sua senha" required>
                        <button class="btn btn-outline-secondary" type="button" id="toggleConfirmPassword">
                            <i class="ph ph-eye"></i>
                        </button>
                    </div>
                </div>

                <div class="d-grid mb-3">
                    <button type="submit" class="btn btn-primary">Criar Conta</button>
                </div>

                <div class="text-center">
                    <p class="mb-2">Já tem uma conta?</p>
                    <a class="text-create-new-account" href="index.jsp">Faça login</a>
                </div>
            </form>
        </div>
    </div>

    <script src="resources/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle password visibility
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('password');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.querySelector('i').classList.toggle('ph-eye');
            this.querySelector('i').classList.toggle('ph-eye-slash');
        });

        document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
            const passwordInput = document.getElementById('confirmPassword');
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            this.querySelector('i').classList.toggle('ph-eye');
            this.querySelector('i').classList.toggle('ph-eye-slash');
        });

        // Form submission
        document.getElementById('registerForm').addEventListener('submit', async function(event) {
            event.preventDefault();

            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            if (password !== confirmPassword) {
                alert('As senhas não coincidem!');
                return;
            }

            const formData = new FormData(this);
            const data = Object.fromEntries(formData.entries());

            try {
                const response = await fetch('usuario/cadastrar', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: new URLSearchParams(data)
                });

                if (response.ok) {
                    alert('Conta criada com sucesso!');
                    window.location.href = 'index.jsp';
                } else {
                    const error = await response.text();
                    alert(error || 'Erro ao criar conta');
                }
            } catch (error) {
                alert('Erro ao processar a requisição');
                console.error('Error:', error);
            }
        });
    </script>
</body>
</html> 