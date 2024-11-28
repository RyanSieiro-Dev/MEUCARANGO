<%@page isErrorPage="true" %>
<%@page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="Javascript">
            var timer = 2;
            function countdown() {
                if (timer > 0) {
                    timer -= 1;
                    setTimeout("countdown()", 99999999);
                } else {
                    location.href = 'index.jsp';
                }
            }
            countdown();
            
            window.onload = function() {
                document.querySelector('.container').classList.add('fade-in');
            };
        </script>
        <style>
            
            body, html {
                margin: 0;
                padding: 0;
                height: 100%;
                font-family: 'Arial', sans-serif;
            }

            
            body {
                background-color: #f78b00;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
                color: white;
                text-align: center;
            }

            
            .container {
                opacity: 0;
                transition: opacity 0.6s ease-in;
                padding: 20px;
                border-radius: 10px;
                background-color: rgba(0, 0, 0, 0.7);
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 800px;
            }

            
            .fade-in {
                opacity: 1;
            }

           
            #cabecalho {
                margin-bottom: 20px;
                font-size: 28px;
            }

            
            #corpo {
                padding: 20px;
            }

            
            #corpo img {
                width: 150px;
                height: auto;
                margin-bottom: 20px;
            }

            
            #rodape {
                margin-top: 20px;
                font-size: 14px;
                color: #ccc;
            }

            
            a {
                color: #f78b00;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                text-decoration: underline;
            }

            
            h3 {
                font-size: 22px;
                margin-bottom: 20px;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Erro de Login</title>
    </head>
    <body>
        <div class="container">
            <div id="cabecalho">
                <h1>Erro de Login</h1>
            </div>
            <div id="corpo">
                <img src="https://compras.wiki.ufsc.br/images/5/56/Erro.png" alt="Erro" />
                <hr/>
                <h3> Email ou Senha incorretos ou talvez você não seja um administrador </h3>
                <p><a href="login.jsp">Tentar Novamente</a> | <a href="cadastro.jsp">Cadastre-se</a></p>
                <hr/>
            </div>
            <div id="rodape">
                <p>© 2024 Seu Site</p>
            </div>
        </div>
    </body>
</html>
