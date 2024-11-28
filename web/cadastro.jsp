
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/estiloformulario.css" />
    <title>CADASTRO DE LOGIN</title>
    <script type="text/javascript">
       
        function EfeitoFading() {
            const container = document.querySelector('.container');
            container.style.transition = "opacity 0.5s ease";
            container.style.opacity = 0;
            setTimeout(function() {
                window.location.href = 'login.jsp';
            }, 750);
        }

       
        function validarCadastro() {
            const form = document.forms['frmCadastrarLogin']; 
            
            if (form.nome.value === "") {
                alert("Campo Usuário Não Informado");
                return false;
            }
            if (form.email.value === "") {
                alert("Campo Email Não Informado");
                return false;
            }
            if (form.senha.value === "") {
                alert("Campo Senha Não Informado");
                return false;
            }
            
           
            return true; 
        }
                window.onload = function() {
            document.querySelector('.container').classList.add('fade-in');
        };
        
              
        function showErrorMessage(message) {
            alert(message);
        }
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
</head>
<body>
    <div class="container">
        <div class="content">
            <div id="cadastro">
                <h1>Cadastrar Login</h1>
                <form name="frmCadastrarLogin" action="CadastroLogin" method="post">
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
                        <input type="submit" value="Cadastrar" 
                               onclick="return validarCadastro()"/>
                    </p>
                    <p class="CadastroLoginServlet">
                        Já tem conta?
                        <a href="javascript:void(0);" onclick="EfeitoFading()">Ir para login</a>
                    </p>
                </form>
            </div>  
        </div>
    </div>
        <%
        
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
            out.println("<script>showErrorMessage('" + errorMessage + "');</script>");
        }
    %>
</body>
</html>
