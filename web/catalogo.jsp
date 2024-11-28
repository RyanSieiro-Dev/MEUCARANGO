<%@ page import="java.util.ArrayList" %>
<%@ page import="servlets.Veiculo" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="br.com.conexao.CriarConexao" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.math.BigDecimal" %>

<html>
<head>
    <title>Catálogo de Veículos</title>
    
    <link rel="stylesheet" href="css/catalogo.css" />
    
    <script src="javascript/carrinho.js"></script>
<%
    
    String nomeSessao = (String) session.getAttribute("nomeSessao");
    String emailSessao = (String) session.getAttribute("emailSessao");
   
    boolean usuarioLogado = (nomeSessao != null);
    
    String modelFilter = request.getParameter("model");
    String brandFilter = request.getParameter("brand");
    String priceFilter = request.getParameter("price");
%>

<script>
    
    document.getElementById("filterButton").addEventListener("click", function () {
        const model = document.getElementById("modelFilter").value;
        const brand = document.getElementById("brandFilter").value;
        const price = document.getElementById("priceFilter").value;

        // Cria uma URL com os parâmetros de busca
        const params = new URLSearchParams({
            model: model,
            brand: brand,
            price: price
        });

       
        window.location.href = "catalogo.jsp?" + params.toString();
    });

function adicionarCarrinho(idVeiculo) {
    
    var usuarioLogado = <%= usuarioLogado ? "true" : "false" %>;

    if (!usuarioLogado) {
        alert("Você precisa estar logado para adicionar itens ao carrinho. Por favor, faça login.");
        window.location.href = "login.jsp"; 
        return;
    }

    
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "AdicionarCarrinhoServlet"; 

  
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "idVeiculo";
    input.value = idVeiculo;

    form.appendChild(input);
    document.body.appendChild(form);
    form.submit(); 
}
</script>


    <style>
        
section .card-item {
    min-height: 350px;
    background: var(--gray);
    border-radius: 8px;
    display: flex;
    align-items: stretch;
    flex-direction: column;
    justify-content: space-evenly;
}


        
        * {
            margin: 0px;
            padding: 0px;
            box-sizing: border-box;
            outline: none;
            font-family: "Roboto", sans-serif;
        }
        
        .container {
            width: 700px;
            margin: 0 auto;
        }
        .vehicle {
            border: 1px solid #ccc;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        
        
#addToCartButton {
    background-color: #4CAF50; 
    color: white;
    padding: 12px 25px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.2s;
    text-transform: uppercase;
    margin-top: 20px;
}


#addToCartButton:hover {
    background-color: #388E3C; 
    transform: scale(1.05); 
}


#addToCartButton:active {
    background-color: #2C6B2F; 
    transform: scale(1); 
}


        .header {
            font-weight: bold;
            display: flex;
            justify-content: space-between;
            background-color: #f4f4f4;
            padding: 10px;
            border-radius: 5px;
        }
        .row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            align-items: center;
        }
        .vehicle img {
            max-width: 100px; 
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <header>
        <div class="content">
            <nav>
                <%
                if (nomeSessao != null && emailSessao != null) {
                %>
   <div class="boas-vindas">
    <h1>Usuário: <%= nomeSessao %></h1>
    
</div>
                <%
                }
                %>
                <a href="index.jsp">
                    <p class="brand">Meu<strong>carango</strong></p>
                </a>

                <ul>
                    <li><a href="catalogo.jsp">Catálogo</a></li>
                    <li><a href="index.jsp">Sobre</a></li>
                    <li><a href="index.jsp">Especificações</a></li>
<li>
    <% 
    if (nomeSessao != null && emailSessao != null) { 
    %>
       
        <a href="carrinho.jsp" class="cart-icon">
            <i class="fas fa-shopping-cart"></i> Carrinho
        </a>
    <% 
    } else { 
    %>
        
        <a href="login.jsp" class="cart-icon" onclick="alert('Por favor, faça login para acessar o carrinho.')">
            <i class="fas fa-shopping-cart"></i> Carrinho
        </a>
    <% 
    } 
    %>
</li> 
                   <li><a href="gerenciar_parecer.jsp">Pareceres de veículos</a></li>
<li>
    <% 
    if (nomeSessao != null && emailSessao != null) { 
    %>
        <button onclick="alert('Você já está logado como <%= nomeSessao %>.');">Login</button>
    <% 
    } else { 
    %>
        <a href="login.jsp">
            <button>Login</button>
        </a>
    <% 
    } 
    %>
</li>
                </ul>
            </nav>
        </div>
    </header>

    <section class="catalog" id="catalog">
        <div class="content">
            <div class="title-wrapper-catalog">
                <p>Encontre o que você procura</p>
                <h3>Catálogo</h3>
            </div>
        </div>
        


        <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = CriarConexao.getConexao();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM veiculo");
            while (rs.next()) {
                String nome = rs.getString("Nome");
                String marca = rs.getString("Marca");
                String modelo = rs.getString("Modelo");
                int ano = rs.getInt("Ano");
                BigDecimal preco = rs.getBigDecimal("Preço");
                String status = rs.getString("Status");
                String foto = rs.getString("Foto");
        %>

        <div class="card-wrapper" id="carCardContainer">
            <div class="card-item">
                <img src="<%= foto %>" alt="<%= nome %>" />
                <div class="card-content">
                    <h3><%= nome %></h3>
                    <p class="price">R$ <%= preco.setScale(2, BigDecimal.ROUND_HALF_UP).toString().replace(".", ",") %></p> <!-- Exibe o preço -->
                    <button type="button" class="want-button" data-car-model="<%= nome %>" data-car-id="<%= rs.getInt("ID_Veiculo") %>">Eu quero esse!</button>
                </div>
            </div>

            <div id="carModal" class="modal">
                <div class="modal-content">
                    <span class="close">&times;</span>
                    <h2 id="carTitle">Título do Carro</h2>
                    <br> 
                    <p id="carDescription">Descrição do Carro</p>
                    <ul id="carSpecs"></ul>
                    <br>
                   <button id="addToCartButton" 
        onclick="adicionarCarrinho('<%= rs.getInt("ID_Veiculo") %>')">Adicionar ao Carrinho</button>
                </div>
            </div>
        </div>

        <%
            } 
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
        %>

        </div> 
    </section>
    
</body>
</html>
