<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="br.com.conexao.CriarConexao" %>

<%
String nomeSessao = (String) session.getAttribute("nomeSessao");
String emailSessao = (String) session.getAttribute("emailSessao");
%>

<link rel="stylesheet" href="css/admin.css" />

<h1>Área Do Administrador</h1>

<br>
<h2>Compras Realizadas:</h2>

<table width="700px" border="1" cellspacing="0">
    <tr>
        <td><strong>Id</strong></td>
        <td><strong>Id do Usuário</strong></td>
        <td><strong>Data da Compra</strong></td>
        <td><strong>Valor Total</strong></td>
    </tr>
    <% 
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = CriarConexao.getConexao();
            String sql = "SELECT * FROM compras";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int idCompra = rs.getInt("id_compra");
                int idCliente = rs.getInt("id_cliente");
                String dataCompra = rs.getString("data_compra");
                double valorTotal = rs.getDouble("total_compra");
    %>
    <tr> 
        <td><%= idCompra %></td>
        <td><%= idCliente %></td>
        <td><%= dataCompra %></td>
        <td><%= valorTotal %></td>
    </tr>
    <% 
            } 
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    %>
</table>

<br><br>

<form action="index.jsp" method="get">
    <input type="submit" value="Ir para a Página Principal">
</form>

<form action="agenda_avaliacao.jsp" method="get">
    <input type="submit" value="Ir para a Página de Agenda/Avaliações">
</form>
        
<form action="logado.jsp" method="get">
    <input type="submit" value="Ir para a Página de Usuários">
</form>


<form action="admin_veiculos.jsp" method="get">
    <input type="submit" value="Ir para a Página de veiculos">
</form>

<%
String action = request.getParameter("action");

try {
    conn = CriarConexao.getConexao();

    if ("deleteCompra".equals(action)) {
        String sql = "DELETE FROM compras WHERE id_compra = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(request.getParameter("idCompra")));
        pstmt.executeUpdate();
        response.sendRedirect("admin_compras.jsp");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>
