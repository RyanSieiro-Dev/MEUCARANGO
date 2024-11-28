package servlets;

import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/EnviarAvaliacao")
public class EnviarAvaliacaoServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtém a sessão e o ID do usuário logado
        HttpSession session = request.getSession();
        Integer idUsuario = (Integer) session.getAttribute("user_id");

        // Redireciona se o usuário não estiver logado
        if (idUsuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Obtém a avaliação do formulário
        String avaliacao = request.getParameter("avaliacao");

        
        try (Connection conn = CriarConexao.getConexao()) {
            String sql = "INSERT INTO avaliacoes (id_usuario, avaliacao) VALUES (?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            stmt.setString(2, avaliacao);
            stmt.executeUpdate();

            
            response.sendRedirect("index.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("erro.jsp");
        }
    }
}
