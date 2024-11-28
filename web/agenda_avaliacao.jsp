<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="br.com.conexao.CriarConexao" %>

<%
String nomeSessao = (String) session.getAttribute("nomeSessao");
String emailSessao = (String) session.getAttribute("emailSessao");
%>


<link rel="stylesheet" href="css/admin.css" />

<h1>Área Do Administrador</h1>


<br>
<h2>Agendamentos de Test Drive:</h2>

<table width="700px" border="1" cellspacing="0">
    <tr>
        <td><strong>ID</strong></td>
        <td><strong>Usuário</strong></td>
        <td><strong>Veículo</strong></td>
        <td><strong>Data e Hora</strong></td>
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
            rs = stmt.executeQuery("SELECT a.id, u.nome AS usuario, v.modelo AS veiculo, a.data_test_drive FROM AgendaTestDrive a " +
                                   "INNER JOIN tb_login u ON a.id_usuario = u.id " +
                                   "INNER JOIN veiculo v ON a.id_veiculo = v.ID_Veiculo");
            while (rs.next()) {
                int id = rs.getInt("id");
                String usuario = rs.getString("usuario");
                String veiculo = rs.getString("veiculo");
                String dataHora = rs.getString("data_test_drive");
    %>
    <tr>
        <td><%= id %></td>
        <td><%= usuario %></td>
        <td><%= veiculo %></td>
        <td><%= dataHora %></td>
        <td><a href="agenda_avaliacao.jsp?id=<%= id %>&usuario=<%= usuario %>&veiculo=<%= veiculo %>&dataHora=<%= dataHora %>&action=edit">Editar</a></td>
        <td><a href="agenda_avaliacao.jsp?action=delete&id=<%= id %>" onclick="return confirm('Tem certeza que deseja excluir este agendamento?');">Excluir</a></td>
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
<h2>Cadastrar Novo Agendamento:</h2>
<form action="agenda_avaliacao.jsp" method="post">
    <table>
        <tr>
            <td><strong>Usuário</strong></td>
            <td><strong>Veículo</strong></td>
            <td><strong>Data e Hora</strong></td>
        </tr>
        <tr>
            <td>
                <select name="id_usuario" required>
                    <%
                        try {
                            conn = CriarConexao.getConexao();
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT id, nome FROM tb_login");
                            while (rs.next()) {
                                int idUsuario = rs.getInt("id");
                                String nomeUsuario = rs.getString("nome");
                    %>
                    <option value="<%= idUsuario %>"><%= nomeUsuario %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception e) {}
                            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                        }
                    %>
                </select>
            </td>
            <td>
                <select name="id_veiculo" required>
                    <%
                        try {
                            conn = CriarConexao.getConexao();
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT ID_Veiculo, Modelo FROM veiculo WHERE Status = 'Disponível'");
                            while (rs.next()) {
                                int idVeiculo = rs.getInt("ID_Veiculo");
                                String modelo = rs.getString("Modelo");
                    %>
                    <option value="<%= idVeiculo %>"><%= modelo %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (Exception e) {}
                            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                        }
                    %>
                </select>
            </td>
            <td><input type="datetime-local" name="data_test_drive" required></td>
        </tr>
    </table>
    <input type="hidden" name="ac" value="inserir">
    <input type="submit" value="Cadastrar">
</form>

<%
String action = request.getParameter("ac");
PreparedStatement pstmt = null;

try {
    conn = CriarConexao.getConexao();

    if ("inserir".equals(action)) {
        String sql = "INSERT INTO AgendaTestDrive (id_usuario, id_veiculo, data_test_drive) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        int idVeiculo = Integer.parseInt(request.getParameter("id_veiculo"));
        String dataTestDrive = request.getParameter("data_test_drive");

        pstmt.setInt(1, idUsuario);
        pstmt.setInt(2, idVeiculo);
        pstmt.setString(3, dataTestDrive);

        pstmt.executeUpdate();
        response.sendRedirect("agenda_avaliacao.jsp");
    } else if ("delete".equals(request.getParameter("action"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "DELETE FROM AgendaTestDrive WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
        response.sendRedirect("agenda_avaliacao.jsp");
    } else if ("edit".equals(request.getParameter("action"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        String usuario = request.getParameter("usuario");
        String veiculo = request.getParameter("veiculo");
        String dataHora = request.getParameter("dataHora");

        
        %>
        <br>
        <h2>Editar Agendamento:</h2>
        <form action="agenda_avaliacao.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <table>
                <tr>
                    <td><strong>Usuário</strong></td>
                    <td><strong>Veículo</strong></td>
                    <td><strong>Data e Hora</strong></td>
                </tr>
                <tr>
                    <td>
                        <select name="id_usuario" required>
                            <%
                                conn = CriarConexao.getConexao();
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT id, nome FROM tb_login");
                                while (rs.next()) {
                                    int idUsuario = rs.getInt("id");
                                    String nomeUsuario = rs.getString("nome");
                            %>
                            <option value="<%= idUsuario %>" <%= (usuario.equals(nomeUsuario) ? "selected" : "") %>><%= nomeUsuario %></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td>
                        <select name="id_veiculo" required>
                            <%
                                conn = CriarConexao.getConexao();
                                stmt = conn.createStatement();
                                rs = stmt.executeQuery("SELECT ID_Veiculo, Modelo FROM veiculo WHERE Status = 'Disponível'");
                                while (rs.next()) {
                                    int idVeiculo = rs.getInt("ID_Veiculo");
                                    String modelo = rs.getString("Modelo");
                            %>
                            <option value="<%= idVeiculo %>" <%= (veiculo.equals(modelo) ? "selected" : "") %>><%= modelo %></option>
                            <%
                                }
                            %>
                        </select>
                    </td>
                    <td><input type="datetime-local" name="data_test_drive" value="<%= dataHora %>" required></td>
                </tr>
            </table>
            <input type="hidden" name="ac" value="update">
            <input type="submit" value="Atualizar">
        </form>
        <%
    } else if ("update".equals(request.getParameter("ac"))) {
        int id = Integer.parseInt(request.getParameter("id"));
        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        int idVeiculo = Integer.parseInt(request.getParameter("id_veiculo"));
        String dataTestDrive = request.getParameter("data_test_drive");

        String sql = "UPDATE AgendaTestDrive SET id_usuario = ?, id_veiculo = ?, data_test_drive = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, idUsuario);
        pstmt.setInt(2, idVeiculo);
        pstmt.setString(3, dataTestDrive);
        pstmt.setInt(4, id);

        pstmt.executeUpdate();
        response.sendRedirect("agenda_avaliacao.jsp");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
    if (conn != null) try { conn.close(); } catch (Exception e) {}
}
%>

<br>
<h2>Avaliações:</h2>

<table width="700px" border="1" cellspacing="0">
    <tr>
        <td><strong>Id</strong></td>
        <td><strong>Id do Usuário</strong></td>
        <td><strong>Avaliação</strong></td>
        <td><strong>Data da Avaliação</strong></td>
    </tr>
    <% 
        try {
            conn = CriarConexao.getConexao();
            String sql = "SELECT * FROM avaliacoes";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                int idAvaliacao = rs.getInt("id");
                int idUsuario = rs.getInt("id_usuario");
                String avaliacao = rs.getString("avaliacao");
                String dataAvaliacao = rs.getString("data_avaliacao");
    %>
    <tr> 
        <td><%= idAvaliacao %></td>
        <td><%= idUsuario %></td>
        <td><%= avaliacao %></td>
        <td><%= dataAvaliacao %></td>
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

<form action="admin_compras.jsp" method="get">
    <input type="submit" value="Ir para a Página de Compras">
</form>

<form action="logado.jsp" method="get">
    <input type="submit" value="Ir para a Página de Usuários">
</form>

<form action="admin_veiculos.jsp" method="get">
    <input type="submit" value="Ir para a Página de Veículos">
</form>
