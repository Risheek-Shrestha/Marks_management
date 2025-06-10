

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoadStudent")
public class LoadStudent extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String semester = request.getParameter("semester");
        int studentId = Integer.parseInt(request.getParameter("student_id"));

        // Default semester
        if (semester == null) semester = "1";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/marks", "root", "root");

            // Query to get student details including course and university
            ps = conn.prepareStatement("SELECT full_name, course, university FROM registration_form WHERE id = ?");
            ps.setInt(1, studentId);
            rs = ps.executeQuery();

            String course = null;
            String studentName = null;
            String university = null;

            if (rs.next()) {
                studentName = rs.getString("full_name");
                course = rs.getString("course");
                university = rs.getString("university");
            }
            rs.close();
            ps.close();

            // Now get marks for student
            ps = conn.prepareStatement("SELECT subject1_marks, subject2_marks, subject3_marks, subject4_marks, subject5_marks, subject6_marks FROM student_marks WHERE student_id = ?");
            ps.setInt(1, studentId);
            rs = ps.executeQuery();

            Integer s1 = null, s2 = null, s3 = null, s4 = null, s5 = null, s6 = null;
            if (rs.next()) {
                s1 = rs.getInt("subject1_marks");
                if (rs.wasNull()) s1 = null;
                s2 = rs.getInt("subject2_marks");
                if (rs.wasNull()) s2 = null;
                s3 = rs.getInt("subject3_marks");
                if (rs.wasNull()) s3 = null;
                s4 = rs.getInt("subject4_marks");
                if (rs.wasNull()) s4 = null;
                s5 = rs.getInt("subject5_marks");
                if (rs.wasNull()) s5 = null;
                s6 = rs.getInt("subject6_marks");
                if (rs.wasNull()) s6 = null;
            }

            HttpSession session = request.getSession();
            session.setAttribute("studentId", studentId);
            session.setAttribute("studentName", studentName);
            session.setAttribute("course", course);
            session.setAttribute("university", university);
            session.setAttribute("semester", semester);
            session.setAttribute("subject1_marks", s1);
            session.setAttribute("subject2_marks", s2);
            session.setAttribute("subject3_marks", s3);
            session.setAttribute("subject4_marks", s4);
            session.setAttribute("subject5_marks", s5);
            session.setAttribute("subject6_marks", s6);

            response.sendRedirect("student_dashboard.jsp?semester=" + semester);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
