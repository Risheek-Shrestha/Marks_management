

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
@WebServlet("/Login")
public class Login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String ADMIN_EMAIL = "risheekshrestha0508@gmail.com";
    private static final String ADMIN_PASS = "risheek@0508";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (ADMIN_EMAIL.equals(email) && ADMIN_PASS.equals(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("email", email);
            session.setAttribute("role", "admin");
            response.sendRedirect("Teacher_dashboard.jsp");
            return; 
        }

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/marks", "root", "root")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String sql = "select * from registration_form where email=? and password=?";
            try (PreparedStatement pst = con.prepareStatement(sql)) {
                pst.setString(1, email);
                pst.setString(2, password);

                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        String full_name = rs.getString("full_name");

                        HttpSession session = request.getSession();
                        session.setAttribute("full_name", full_name);
                        session.setAttribute("email", email);
                        session.setAttribute("role", "student");

                        response.sendRedirect("Student_dashboard.jsp");
                    } else {
                        response.sendRedirect("Login.jsp?error=1");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Login.jsp?error=2");
        }
    }
}
