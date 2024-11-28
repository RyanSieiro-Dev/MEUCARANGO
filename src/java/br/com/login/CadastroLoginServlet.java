package br.com.login;

import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import br.com.criptografia.PasswordEncryption; 
import java.security.NoSuchAlgorithmException;

public class CadastroLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public CadastroLoginServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        Connection con = null;

        try {
            con = CriarConexao.getConexao();

            
            if (isEmailExist(con, email)) {
               
                request.setAttribute("errorMessage", "Email já cadastrado, tente novamente.");
                request.getRequestDispatcher("cadastro.jsp").forward(request, response); 
                return; 
            }

            
            String senhaCriptografada = PasswordEncryption.encryptPassword(senha);

            
            Usuario u = new Usuario();
            u.setNome(nome);
            u.setEmail(email);
            u.setSenha(senhaCriptografada); 

            
            UsuarioDao dao = new UsuarioDao(con);
            dao.adicionar(u);

         
            request.getSession().setAttribute("nome", u.getNome());
            request.getSession().setAttribute("email", u.getEmail());

            
            request.getRequestDispatcher("cadastrado.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erro ao conectar com o banco de dados: " + e.getMessage());
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            response.getWriter().println("Erro ao criptografar a senha: " + e.getMessage());
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private boolean isEmailExist(Connection con, String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM tb_login WHERE email = ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, email);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; 
                }
            }
        }
        return false; 
    }
}
