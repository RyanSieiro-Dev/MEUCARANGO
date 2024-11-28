package br.com.login;

import br.com.conexao.CriarConexao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import br.com.criptografia.PasswordEncryption; 
import java.security.NoSuchAlgorithmException;

public class LoginControllers extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nomeBuscado = "";
        String emailBuscado = "";
        String senhaBuscada = "";
        boolean isAdmin = false;  
        int idCliente = 0;  
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String adminCheck = request.getParameter("adminCheck"); 

        String sql = "SELECT * FROM tb_login WHERE email = ?";

        try {
            
            con = CriarConexao.getConexao();
            stmt = con.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();

            if (rs.next()) {
                nomeBuscado = rs.getString("nome");
                emailBuscado = rs.getString("email");
                senhaBuscada = rs.getString("senha");
                idCliente = rs.getInt("id"); 

                
                isAdmin = rs.getBoolean("is_admin");  
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        
        if (emailBuscado.equals(email)) {
            try {
                
                String senhaCriptografada = PasswordEncryption.encryptPassword(senha);

                
                if (senhaBuscada.equals(senhaCriptografada)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("nomeSessao", nomeBuscado);
                    session.setAttribute("emailSessao", emailBuscado);
                    session.setAttribute("user_id", idCliente); 
                    session.setAttribute("is_admin", isAdmin); 

                   
                    if (adminCheck != null && adminCheck.equals("on")) { 
                        if (isAdmin) {
                           
                            request.getRequestDispatcher("logado.jsp").forward(request, response);
                        } else {
                            // Se não for administrador, mostra uma mensagem de erro
                            request.setAttribute("errorMessage", "Você não tem permissão de administrador.");
                            request.getRequestDispatcher("errodeusuario.jsp").forward(request, response);
                        }
                    } else {
                        // Se não for administrador, redireciona para a página de usuário comum
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "Email ou senha inválidos.");
                    request.getRequestDispatcher("errodeusuario.jsp").forward(request, response);
                }
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Erro ao criptografar a senha.");
                request.getRequestDispatcher("errodeusuario.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("errorMessage", "Email ou senha inválidos.");
            request.getRequestDispatcher("errodeusuario.jsp").forward(request, response);
        }
    }
}
