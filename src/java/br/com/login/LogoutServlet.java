package br.com.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Invalida a sessão do usuário
        HttpSession session = request.getSession(false); // false: não cria nova sessão se não houver uma existente
        if (session != null) {
            session.invalidate(); // Invalida a sessão atual
        }
        
        // Redireciona para a página de login após o logout
        response.sendRedirect("logout.jsp");
    }
}
