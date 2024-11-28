<%@ page import="java.sql.*" %>
<%@ page import="br.com.conexao.CriarConexao" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.util.ArrayList" %>

<%
    
    String nomeSessao = (String) session.getAttribute("nomeSessao");
    String emailSessao = (String) session.getAttribute("emailSessao");
   
    boolean usuarioLogado = (nomeSessao != null);

    
    BigDecimal totalCarrinho = BigDecimal.ZERO; 
%>

<html>
<head>
    <title>Carrinho de Compras</title>
    <link rel="stylesheet" href="css/carrinho.css" />
    <style>
        
        .modal {
            display: none; 
            position: fixed;
            z-index: 1; 
            left: 0;
            top: 0;
            width: 100%; 
            height: 100%; 
            overflow: auto; 
            background-color: rgb(0,0,0); 
            background-color: rgba(0,0,0,0.4); 
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; 
            padding: 20px;
            border: 1px solid #888;
            width: 80%; 
        }
        
        

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        /* Estilo para a mensagem de sucesso */
        .mensagem-sucesso {
            background-color: #4CAF50; /* Verde */
            color: white;
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 18px;
            border-radius: 5px;
        }

    
    .finalizar-compra {
        background-color: #007bff;
        color: #fff;
        padding: 12px 20px;
        font-size: 16px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.2s;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        margin: 15px;
    }

    .finalizar-compra:hover {
        background-color: #0056b3; 
        transform: scale(1.05); 
    }

    .finalizar-compra:active {
        background-color: #003d80; 
        transform: scale(1); 
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
<br>

    <h2>Carrinho de Compras</h2>
    
<br>
   
    <%
        String mensagem = request.getParameter("msg");
        if (mensagem != null) {
    %>
        <div class="mensagem-sucesso">
            <p><%= mensagem %></p>
        </div>
    <%
        }
    %>

    <%
        int idCliente = (int) session.getAttribute("user_id"); 
        
        ArrayList<String[]> carrinhoItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = CriarConexao.getConexao();
            String sql = "SELECT v.Nome, v.Marca, v.Modelo, v.Preço, v.Foto, c.id_carrinho " +
                         "FROM carrinho c " +
                         "JOIN veiculo v ON c.id_veiculo = v.ID_Veiculo " +
                         "WHERE c.id_cliente = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCliente);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String nome = rs.getString("Nome");
                String marca = rs.getString("Marca");
                String modelo = rs.getString("Modelo");
                BigDecimal preco = rs.getBigDecimal("Preço");
                String foto = rs.getString("Foto");
                int idCarrinho = rs.getInt("id_carrinho");
                carrinhoItems.add(new String[]{nome, marca, modelo, preco.toString(), foto, String.valueOf(idCarrinho)});

                
                totalCarrinho = totalCarrinho.add(preco);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    %>

    <table>
        <tr>
            <th>Foto</th>
            <th>Nome</th>
            <th>Marca</th>
            <th>Modelo</th>
            <th>Preço</th>
            
        </tr>
        <%
        for (String[] item : carrinhoItems) {
        %>
        <tr>
            <td><img src="<%= item[4] %>" alt="<%= item[0] %>" style="width: 100px;"></td>
            <td><%= item[0] %></td>
            <td><%= item[1] %></td>
            <td><%= item[2] %></td>
            <td>R$ <%= item[3] %></td>
<td>
    <form action="CarrinhoServlet" method="post" style="display:inline;">
        <input type="hidden" name="idCarrinho" value="<%= item[5] %>">
        <input type="submit" value="Remover" class="remover">
    </form>
    <button onclick="abrirModal(<%= item[5] %>)" class="test-drive">Test Drive</button>
</td>
        </tr>
        <%
        }
        %>
    </table>

    <br><br><br>
    <h3>Total: R$ <%= totalCarrinho.setScale(2, BigDecimal.ROUND_HALF_UP).toString() %></h3>
    
    <br>

<%
    
    if (carrinhoItems.isEmpty()) {
        out.println("<p>O carrinho está vazio. Adicione itens ao carrinho antes de finalizar a compra.</p>");
    } else {
%>
<form action="FinalizarCompraServlet" method="post">
    <input type="hidden" name="totalCarrinho" value="<%= totalCarrinho %>">
    <input type="submit" value="Finalizar Compra" class="finalizar-compra">
</form>
<%
    }
%>
    <!-- Modal -->
    <div id="modalTestDrive" class="modal">
        <div class="modal-content">
            <span class="close" onclick="fecharModal()">&times;</span>
            <h2>Agendar Test-Drive</h2>
            <form id="formAgendar" action="AgendarTestDriveServlet" method="post">
                <input type="hidden" name="idVeiculo" id="idVeiculoModal" value=""/>
                <label for="dataTestDrive">Data do Test-Drive:</label>
                <input type="date" name="dataTestDrive" required>
                <br>
                <input type="submit" value="Confirmar">
                <button type="button" onclick="fecharModal()">Cancelar</button>
            </form>
        </div>
    </div>

    <script>
        function abrirModal(idVeiculo) {
            document.getElementById("idVeiculoModal").value = idVeiculo; 
            document.getElementById("modalTestDrive").style.display = "block"; 
        }

        function fecharModal() {
            document.getElementById("modalTestDrive").style.display = "none"; 
        }

       
        window.onclick = function(event) {
            const modal = document.getElementById("modalTestDrive");
            if (event.target === modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>
