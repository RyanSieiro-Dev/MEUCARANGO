<%@page import="java.sql.PreparedStatement"%>
<%@page import="br.com.conexao.CriarConexao"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.math.BigDecimal"%>

<%
String nomeSessao = (String) session.getAttribute("nomeSessao");
String emailSessao = (String) session.getAttribute("emailSessao");
%>

<link rel="stylesheet" href="css/admin_veiculos.css" />

<h1> Área Do Administrador </h1>

<h2>Veículos cadastrados:</h2>


<table width="700px" border="1" cellspacing="0">
    <tr>
        <td><strong>ID Veículo</strong></td>
        <td><strong>Nome</strong></td>
        <td><strong>Marca</strong></td>
        <td><strong>Modelo</strong></td>
        <td><strong>Ano</strong></td>
        <td><strong>Preço</strong></td>
        <td><strong>Status</strong></td>
        <td><strong>Editar</strong></td>
        <td><strong>Excluir</strong></td>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = CriarConexao.getConexao();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM veiculo"); 
            while (rs.next()) {
                int idVeiculo = rs.getInt("ID_Veiculo"); 
                String nome = rs.getString("Nome");
                String marca = rs.getString("Marca"); 
                String modelo = rs.getString("Modelo"); 
                int ano = rs.getInt("Ano"); 
                BigDecimal preco = rs.getBigDecimal("Preço"); 
                String status = rs.getString("Status"); 

    %>
    <tr> 
        <td><%= idVeiculo %></td>
        <td><%= nome %></td>
        <td><%= marca %></td>
        <td><%= modelo %></td>
        <td><%= ano %></td>
        <td><%= preco %></td>
        <td><%= status %></td>
        <td><a href="admin_veiculos.jsp?id=<%= idVeiculo %>&nome=<%= nome %>&marca=<%= marca %>&modelo=<%= modelo %>&ano=<%= ano %>&preco=<%= preco %>&status=<%= status %>">Editar</a></td>
        <td><a href="admin_veiculos.jsp?action=delete&id=<%= idVeiculo %>" onclick="return confirm('Tem certeza que deseja excluir este veículo?');">Excluir</a></td>
    </tr>
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
</table>
<br>
<h2> Atualizar um Carro: </h2>
<form action="admin_veiculos.jsp" method="post">
    <table> 
        <tr> 
            <td><strong>ID Veículo</strong></td>
            <td><strong>Nome</strong></td>
            <td><strong>Marca</strong></td>
            <td><strong>Modelo</strong></td>
            <td><strong>Ano</strong></td>
            <td><strong>Preço</strong></td>
            <td><strong>Status</strong></td>
        </tr>
        <tr>
            <td><input type="text" name="id" size="1" value="<%=request.getParameter("id")%>" readonly></td>
            <td><input type="text" name="nome" size="35" value="<%=request.getParameter("nome")%>"></td>
            <td><input type="text" name="marca" size="35" value="<%=request.getParameter("marca")%>"></td>
            <td><input type="text" name="modelo" size="35" value="<%=request.getParameter("modelo")%>"></td>
            <td><input type="text" name="ano" size="4" value="<%=request.getParameter("ano")%>"></td>
            <td><input type="text" name="preco" size="10" value="<%=request.getParameter("preco")%>"></td>
            <td><input type="text" name="status" size="15" value="<%=request.getParameter("status")%>"></td>
        </tr>
    </table>
    <input type="hidden" name="ac" value="atualizar">
    <input type="submit" value="Atualizar">
</form>

        <br>
<h2>Cadastrar novo Carro:</h2>
<form action="admin_veiculos.jsp" method="post">
    
    <table>
        <tr> 
            <td><strong>Nome</strong></td>
            <td><strong>Marca</strong></td>
            <td><strong>Modelo</strong></td>
            <td><strong>Ano</strong></td>
            <td><strong>Preço</strong></td>
            <td><strong>Foto</strong></td>
            <td><strong>Status</strong></td>
            <td><strong>Administrador</strong></td>
        </tr>
        <tr>
            <td><input type="text" name="nome" size="35" placeholder="Nome do veículo" required></td>
            <td><input type="text" name="marca" size="35" placeholder="Marca do veículo" required></td>
            <td><input type="text" name="modelo" size="35" placeholder="Modelo do veículo" required></td>
            <td><input type="text" name="ano" size="4" placeholder="Ano" required></td>
            <td><input type="text" name="preco" size="10" placeholder="Preço" required></td>
            <td><input type="text" name="foto" size="35" placeholder="URL da Foto"></td>
            <td>
                <select name="status" required>
                    <option value="Disponível">Disponível</option>
                    <option value="Vendido">Vendido</option>
                    <option value="Reservado">Reservado</option>
                </select>
            </td>
            <td><input type="text" name="id_administrador" size="10" placeholder="ID do Administrador" required></td>
        </tr>
    </table>
    <input type="hidden" name="ac" value="inserir">
    <input type="submit" value="Criar">
</form>

<br><br>

<form action="index.jsp" method="get">
    <input type="submit" value="Ir para a Página Principal">
</form>

<form action="agenda_avaliacao.jsp" method="get">
    <input type="submit" value="Ir para a Página de Agenda/Avaliações">
</form>
        
<form action="admin_compras.jsp" method="get">
    <input type="submit" value="Ir para a Página de Compras">
</form>

<!-- Formulário para ir para a página de veículos -->
<form action="logado.jsp" method="get">
    <input type="submit" value="Ir para a Página de Usuários">
</form>

<%
if ("atualizar".equals(request.getParameter("ac"))) {
    PreparedStatement pstmt = null;

    try {
        conn = CriarConexao.getConexao();
        String sql = "UPDATE veiculo SET Nome = ?, Marca = ?, Modelo = ?, Ano = ?, Preço = ?, Status = ? WHERE ID_Veiculo = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("nome")); // Nome do veículo
        pstmt.setString(2, request.getParameter("marca")); // Marca do veículo
        pstmt.setString(3, request.getParameter("modelo")); // Modelo do veículo
        pstmt.setInt(4, Integer.parseInt(request.getParameter("ano"))); // Ano do veículo
        pstmt.setBigDecimal(5, new BigDecimal(request.getParameter("preco"))); // Preço do veículo
        pstmt.setString(6, request.getParameter("status")); // Status do veículo
        pstmt.setInt(7, Integer.parseInt(request.getParameter("id"))); // ID do veículo
        
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Veículo atualizado com sucesso.");
        } else {
            System.out.println("Nenhum veículo encontrado com esse ID.");
        }
        
        response.sendRedirect("admin_veiculos.jsp"); 
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
}
%>


<%
if ("inserir".equals(request.getParameter("ac"))) {
    PreparedStatement pstmt = null;

    try {
        conn = CriarConexao.getConexao();
        String sql = "INSERT INTO veiculo (Nome, Marca, Modelo, Ano, Preço, Foto, Status, id_administrador) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("nome")); // Nome do veículo
        pstmt.setString(2, request.getParameter("marca")); // Marca do veículo
        pstmt.setString(3, request.getParameter("modelo")); // Modelo do veículo
        pstmt.setInt(4, Integer.parseInt(request.getParameter("ano"))); // Ano do veículo
        pstmt.setBigDecimal(5, new BigDecimal(request.getParameter("preco"))); // Preço do veículo
        pstmt.setString(6, request.getParameter("foto")); // URL ou caminho da foto do veículo
        pstmt.setString(7, request.getParameter("status")); // Status do veículo (Disponível, Vendido, Reservado)
        pstmt.setInt(8, Integer.parseInt(request.getParameter("id_administrador"))); // ID do administrador associado

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Veículo inserido com sucesso.");
        } else {
            System.out.println("Falha ao inserir o veículo.");
        }
        
        response.sendRedirect("admin_veiculos.jsp"); 
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
}
%>



<%
if ("delete".equals(request.getParameter("action"))) {
    PreparedStatement pstmt = null;

    try {
        conn = CriarConexao.getConexao();
        String sql = "DELETE FROM veiculo WHERE ID_Veiculo = ?"; 
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
        
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Veículo excluído com sucesso.");
            
            
            request.getSession().setAttribute("email", emailSessao);
            request.getSession().setAttribute("nome", nomeSessao);
            
            response.sendRedirect("admin_veiculos.jsp"); 
        } else {
            System.out.println("Nenhum veículo encontrado com esse ID.");
            response.sendRedirect("admin_veiculos.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
}
%>

