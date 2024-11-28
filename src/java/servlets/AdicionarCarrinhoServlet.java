package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AdicionarCarrinhoServlet")
public class AdicionarCarrinhoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idVeiculo = request.getParameter("idVeiculo");
        int idCliente = (Integer) request.getSession().getAttribute("user_id");
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            
            int idVeiculoInt = Integer.parseInt(idVeiculo);
            
            conn = CriarConexao.getConexao();
            String sql = "INSERT INTO carrinho (id_cliente, id_veiculo) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idCliente);
            pstmt.setInt(2, idVeiculoInt); 
            pstmt.executeUpdate();

            response.sendRedirect("carrinho.jsp"); 
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (pstmt != null) try {
                pstmt.close();
            } catch (java.sql.SQLException ex) {
                Logger.getLogger(AdicionarCarrinhoServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (conn != null) try {
                conn.close();
            } catch (java.sql.SQLException ex) {
                Logger.getLogger(AdicionarCarrinhoServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
