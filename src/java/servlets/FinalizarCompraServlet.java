package servlets;

import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;




public class FinalizarCompraServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // A sessão do usuário já deve ter sido validada antes, então simplesmente recuperamos o ID
        HttpSession session = request.getSession();
        Integer idCliente = (Integer) session.getAttribute("user_id");
        
        // Se o ID do cliente não estiver na sessão, redireciona para login
        if (idCliente == null) {
            response.sendRedirect("login.jsp?msg=Por favor, faça login antes de finalizar a compra.");
            return;
        }

        // Recupera o total do carrinho da requisição
        String totalCarrinhoStr = request.getParameter("totalCarrinho");
        BigDecimal totalCarrinho = null;

        // Valida o parâmetro de total do carrinho
        try {
            if (totalCarrinhoStr != null && !totalCarrinhoStr.isEmpty()) {
                totalCarrinho = new BigDecimal(totalCarrinhoStr);
            } else {
                // Se o total for inválido, redireciona com uma mensagem de erro
                response.sendRedirect("carrinho.jsp?msg=Erro: Total de compra inválido.");
                return;
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("carrinho.jsp?msg=Erro: Formato de valor inválido.");
            return;
        }

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = CriarConexao.getConexao();

            // Registra a compra na tabela de compras
            String sql = "INSERT INTO compras (id_cliente, total_compra, data_compra) VALUES (?, ?, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCliente);
            pstmt.setBigDecimal(2, totalCarrinho);
            pstmt.executeUpdate();

            // Limpar o carrinho após a compra
            sql = "DELETE FROM carrinho WHERE id_cliente = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCliente);
            pstmt.executeUpdate();

            // Redirecionar o usuário para a página de confirmação
            response.sendRedirect("compraFinalizada.jsp?msg=Compra realizada com sucesso!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("carrinho.jsp?msg=Erro ao finalizar compra. Tente novamente.");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
