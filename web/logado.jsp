<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="br.com.conexao.CriarConexao" %>
<%@ page import="br.com.criptografia.PasswordEncryption" %> <!-- Classe de criptografia -->

<%
String nomeSessao = (String) session.getAttribute("nomeSessao");
String emailSessao = (String) session.getAttribute("emailSessao");
%>

<link rel="stylesheet" href="css/admin.css" />

<h1>Área Do Administrador</h1>

<br>

<h2>Usuários cadastrados:</h2>


<table width="700px" border="1" cellspacing="0">
    <tr>
        <td><strong>Id</strong></td>
        <td><strong>Nome</strong></td>
        <td><strong>Email</strong></td>
        <td><strong>Senha (hash)</strong></td>
        <td><strong>Editar</strong></td>
        <td><strong>Excluir</strong></td>
    </tr>
    <% 
       
        Integer loggedInUserId = (Integer) session.getAttribute("user_id");

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = CriarConexao.getConexao();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM tb_login");
            while (rs.next()) {
                int id = rs.getInt("id");
                String nome = rs.getString("nome");
                String emails = rs.getString("email");
                String senha = rs.getString("senha");
    %>
    <tr> 
        <td><%= id %></td>
        <td><%= nome %></td>
        <td><%= emails %></td>
        <td><%= senha %></td> 
        <td><a href="logado.jsp?id=<%= id %>&nome=<%= nome %>&email=<%= emails %>&senha=<%= senha %>">Editar</a></td>
        <td>
            <a href="logado.jsp?action=delete&id=<%= id %>" 
               onclick="return confirmExclusion(<%= id %>, <%= loggedInUserId %>);">
               Excluir
            </a>
        </td>
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


<script>
    function confirmExclusion(userId, loggedInUserId) {
        if (userId === loggedInUserId) {
            alert("Você não pode se excluir.");
            return false;
        }
        return confirm("Tem certeza que deseja excluir este usuário?");
    }
</script>

<br>
<h2>Atualizar Usuário:</h2>
<form action="logado.jsp" method="post">
    <table> 
        <tr> 
            <td><strong>Id</strong></td>
            <td><strong>Nome</strong></td>
            <td><strong>Email</strong></td>
            <td><strong>Senha</strong></td>
        </tr>
        <tr>
            <td><input type="text" name="id" size="1" value="<%=request.getParameter("id")%>" readonly></td>
            <td><input type="text" name="nome" size="35" value="<%=request.getParameter("nome")%>"></td>
            <td><input type="text" name="email" size="35" value="<%=request.getParameter("email")%>"></td>
            <td><input type="password" name="senha" size="10" value="<%=request.getParameter("senha")%>"></td>
        </tr>
    </table> 
    <input type="hidden" name="ac" value="atualizar">
    <input type="submit" value="Atualizar">
</form>

        <br>
<h2>Cadastrar Novo Usuário:</h2>
<form action="logado.jsp" method="post">
    <table>
        <tr>
            <td><strong>Nome</strong></td>
            <td><strong>Email</strong></td>
            <td><strong>Senha</strong> (máximo 8 caracteres)</td>
            <td><strong>Administrador</strong></td>
        </tr>
        <tr>
            <td><input type="text" name="nome" size="35" placeholder="Nome do usuário" required></td>
            <td><input type="email" name="email" size="35" placeholder="Email do usuário" required></td>
            <td><input type="password" name="senha" size="10" maxlength="8" placeholder="Senha" required></td>
            <td>
                <select name="is_admin" required>
                    <option value="0">Não</option>
                    <option value="1">Sim</option>
                </select>
            </td>
        </tr>
    </table>
    <input type="hidden" name="ac" value="inserir">
    <input type="submit" value="Cadastrar">
</form>


<br><br>
<form>
    
    <a href="login.jsp">Sair</a>
    <br><br>
</form>


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
<form action="admin_veiculos.jsp" method="get">
    <input type="submit" value="Ir para a Página de veiculos">
</form>



<%
String action = request.getParameter("ac");
PreparedStatement pstmt = null;

try {
    conn = CriarConexao.getConexao();

    if ("inserir".equals(action)) {
        String sql = "INSERT INTO tb_login (nome, email, senha, is_admin) VALUES (?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        int isAdmin = Integer.parseInt(request.getParameter("is_admin"));


        String senhaCriptografada = PasswordEncryption.encryptPassword(senha);

        pstmt.setString(1, nome);
        pstmt.setString(2, email);
        pstmt.setString(3, senhaCriptografada);
        pstmt.setInt(4, isAdmin);

        pstmt.executeUpdate();
        response.sendRedirect("logado.jsp"); 
    } else if ("atualizar".equals(action)) {
        String sql = "UPDATE tb_login SET nome = ?, email = ?, senha = ? WHERE id = ?";
        pstmt = conn.prepareStatement(sql);

        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        
        String senhaCriptografada = PasswordEncryption.encryptPassword(senha);

        pstmt.setString(1, nome);
        pstmt.setString(2, email);
        pstmt.setString(3, senhaCriptografada);
        pstmt.setInt(4, Integer.parseInt(request.getParameter("id")));

        pstmt.executeUpdate();
        response.sendRedirect("logado.jsp"); 
        
        
} else if ("delete".equals(request.getParameter("action"))) {
        int userId = Integer.parseInt(request.getParameter("id"));

        
        if (userId == 1) {
            out.println("<script>");
            out.println("alert('Você não pode excluir o usuário ou administrador com id = 1, efetuar a exclusão no banco de dados.');");
            out.println("window.location.href = 'logado.jsp';");
            out.println("</script>");
            return;
        }

        
        if (loggedInUserId != 1) {
            String sqlAdminCheck = "SELECT is_admin FROM tb_login WHERE id = ?";
            pstmt = conn.prepareStatement(sqlAdminCheck);
            pstmt.setInt(1, loggedInUserId);
            ResultSet rsAdmin = pstmt.executeQuery();

            if (rsAdmin.next()) {
                int isAdminLoggedIn = rsAdmin.getInt("is_admin");
                
                if (isAdminLoggedIn == 1) {
                    pstmt = conn.prepareStatement("SELECT is_admin FROM tb_login WHERE id = ?");
                    pstmt.setInt(1, userId);
                    rsAdmin = pstmt.executeQuery();

                    if (rsAdmin.next() && rsAdmin.getInt("is_admin") == 1) {
                        out.println("<script>");
                        out.println("alert('Apenas o Admin com id = 1 pode excluir outros administradores.');");
                        out.println("window.location.href = 'logado.jsp';");
                        out.println("</script>");
                        return;
                    }
                }
            }
        }

        
        String sqlAdminCheck = "DELETE FROM administrador WHERE email = (SELECT email FROM tb_login WHERE id = ?)";
        
        String sqlDeleteUser = "DELETE FROM tb_login WHERE id = ?";

        try {
            conn.setAutoCommit(false); 

            
            pstmt = conn.prepareStatement(sqlAdminCheck);
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();

           
            pstmt = conn.prepareStatement(sqlDeleteUser);
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();

            conn.commit(); 
        } catch (Exception e) {
            conn.rollback(); 
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erro ao excluir usuário.");
        } finally {
            conn.setAutoCommit(true); 
            if (pstmt != null) pstmt.close();
        }

        response.sendRedirect("logado.jsp");
    }
} catch (Exception e) {
    e.printStackTrace();
} finally {
    if (pstmt != null) {
        try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
    }
    if (conn != null) {
        try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }
}
%>