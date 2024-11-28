<%@page language="java" contentType="text/html; charset=ISO-8859-1" 
        pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/estiloformulario.css" />
    <script type="text/javascript">
        function validarLogin() {
            if (document.formLogin.nome.value === "") {
                alert("Campo Usuário Não Informado");
                return false;
            }
            if (document.formLogin.email.value === "") {
                alert("Campo Email Não Informado");
                return false;
            }
            if (document.formLogin.senha.value === "") {
                alert("Campo Senha Não Informado");
                return false;
            }

            document.formLogin.submit();
        }
        
        function EfeitoFading() {
            const container = document.querySelector('.container');
            container.style.transition = "opacity 0.5s ease";
            container.style.opacity = 0;
            setTimeout(function() {
                window.location.href = 'cadastro.jsp';
            }, 750);
        }

        window.onload = function() {
            document.querySelector('.container').classList.add('fade-in');
        };
    </script>
    <style>
        .container {
            opacity: 0;
            transition: opacity 0.6s ease-in; 
        }
        .fade-in {
            opacity: 1;
        }
    </style>
    <title>Acessar</title>
</head>
<body>
    <div class="container">
        <div class="content">
            <div id="login">
                <h1>Login</h1>
                <form name="formLogin" action="Login" method="post">
                    <p>
                        <label for="nome">Seu nome:</label>
                        <input id="nome" name="nome" required="required" type="text" placeholder="nome" />
                    </p>
                    <p>
                        <label for="email">Seu E-mail:</label>
                        <input id="email" name="email" required="required" type="email" placeholder="contato@projecaoceilandia.com" />
                    </p>
                    <p>
                        <label for="senha">Sua senha:</label>
                        <input id="senha" name="senha" required="required" maxlength="8" type="password" placeholder="ex. 1234" />
                    </p>
                    <p>
                        <input type="submit" value="Entrar" onclick="return validarLogin()"/>
                    </p>
                    <p>
                        <input type="checkbox" name="manterlogado" id="manterlogado" value=""/>
                        <label for="manterlogado"> Manter-me logado</label>
                    </p>
                    <p>
                        <input type="checkbox" id="adminCheck" name="adminCheck">
                        <label for="adminCheck">Sou Administrador</label>
                    </p>
                    <p class="Login">
                       Ainda não tem conta?
                       <a href="javascript:void(0);" onclick="EfeitoFading()">Cadastre-se</a>
                    </p>
                </form>
            </div>  
        </div>
    </div>
</body>
</html>
