package servlets;

import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Date;

    
   @WebServlet("/AgendarTestDriveServlet")
public class AgendarTestDriveServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String dataTestDrive = request.getParameter("dataTestDrive");
        int idVeiculo = Integer.parseInt(request.getParameter("idVeiculo"));
        int idUsuario = (int) request.getSession().getAttribute("user_id");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = CriarConexao.getConexao();
            String sql = "INSERT INTO AgendaTestDrive (id_usuario, id_veiculo, data_test_drive) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idUsuario);  // ID do usuário
            pstmt.setInt(2, idVeiculo);  // ID do veículo
            pstmt.setDate(3, Date.valueOf(dataTestDrive));  // Data do test-drive
            pstmt.executeUpdate();

            // Redireciona para a página de catálogo com sucesso
            response.sendRedirect("carrinho.jsp?msg=Test-Drive agendado com sucesso!");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp?msg=Erro ao agendar o Test-Drive: " + e.getMessage());
          } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
}
