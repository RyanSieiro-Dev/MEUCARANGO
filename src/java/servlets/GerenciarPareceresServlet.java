package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/gerenciarPareceres")
public class GerenciarPareceresServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            
            String dbURL = "jdbc:mysql://localhost:3306/Login";
            String dbUsername = "root";
            String dbPassword = "";
            conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

           
            String sql = "SELECT v.ID_Veiculo, v.Nome, v.Marca, v.Modelo, v.Ano, v.Preço, v.Foto, v.Status " +
                         "FROM veiculo v " +
                         "LEFT JOIN administrador a ON v.id_administrador = a.ID_Administrador";

            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            List<Veiculo> veiculos = new ArrayList<>();
            while (rs.next()) {
                Veiculo veiculo = new Veiculo(
                    rs.getInt("ID_Veiculo"),
                    rs.getString("Nome"),
                    rs.getString("Marca"),
                    rs.getString("Modelo"),
                    rs.getInt("Ano"),
                    rs.getDouble("Preço"),
                    rs.getString("Foto"),
                    rs.getString("Status")
                    
                );
                veiculos.add(veiculo);
            }

            
            request.setAttribute("veiculos", veiculos);
            request.getRequestDispatcher("/gerenciarPareceres.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}