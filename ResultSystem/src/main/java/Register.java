

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/Register")
public class Register extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String contact = request.getParameter("number");
        String course = request.getParameter("course");
        String sem = request.getParameter("semester");
        String university = request.getParameter("university");
        String password = request.getParameter("password");
        String confirm_password = request.getParameter("confirm_pass");

        if (confirm_password.equals(password)) {
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3307/marks", "root", "root");

                String get_sql = "SELECT * FROM registration_form WHERE email = ?";
                pst = con.prepareStatement(get_sql);
                pst.setString(1, email);
                rs = pst.executeQuery();

                if (!rs.next()) {
                    String sql = "INSERT INTO registration_form(full_name, email, contact, course, university, password) VALUES (?,?,?,?,?,?)";
                    pst = con.prepareStatement(sql);
                    pst.setString(1, name);
                    pst.setString(2, email);
                    pst.setString(3, contact);
                    pst.setString(4, course);
                    pst.setString(5, university);
                    pst.setString(6, password);

                    int rows = pst.executeUpdate();

                    if (rows > 0) {
                        response.sendRedirect("Login.jsp?registered=true");
                    } else {
                        response.sendRedirect("Register.jsp?error=3");  
                    }
                } else {
                    response.sendRedirect("Register.jsp?error=2");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("Register.jsp?error=3"); 
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } else {
            response.sendRedirect("Register.jsp?error=1");  
        }
    }
}
