package servlets;

import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class CarrinhoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCarrinho = Integer.parseInt(request.getParameter("idCarrinho"));
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = CriarConexao.getConexao();
            String sql = "DELETE FROM carrinho WHERE id_carrinho = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCarrinho);
            pstmt.executeUpdate();
            response.sendRedirect("carrinho.jsp"); // Redireciona para o carrinho após remoção
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
