package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AdminAreaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean isAdmin = (Boolean) session.getAttribute("is_admin");

        
        if (isAdmin != null && isAdmin) {
            
            response.sendRedirect("logado.jsp");
        } else {
            
            session.setAttribute("errorMsg", "Acesso negado! Você não tem permissão para acessar esta área.");
            response.sendRedirect("index.jsp");
        }
    }
}
