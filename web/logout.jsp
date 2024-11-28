<%@page language="java" contentType="text/html; charset=ISO-8859-1" 
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="Javascript">
            var timer = 2 ;
            function countdown() {
                if (timer > 0) {
                    timer -= 1;
                    setTimeout("countdown()", 3000);
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
                max-width: 500px;
            }

            
            .fade-in {
                opacity: 1;
            }

            
            h4 {
                font-size: 24px;
                margin-bottom: 20px;
            }

           
            p {
                font-size: 18px;
                line-height: 1.5;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Cadastro</title>
    </head>
    <body>
        <div class="container">
            <%     
                out.println("<h4>Usuário deslogado com sucesso! </h4>");
                out.println("<p>Você será redirecionado para a página principal em breve.</p>");
            %>
        </div>
    </body>
</html>
