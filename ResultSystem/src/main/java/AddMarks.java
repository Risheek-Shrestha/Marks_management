import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddMarks")
public class AddMarks extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static class Subjects {
        String s1, s2, s3, s4, s5, s6;
        Subjects(String s1, String s2, String s3, String s4, String s5, String s6) {
            this.s1 = s1; this.s2 = s2; this.s3 = s3; this.s4 = s4; this.s5 = s5; this.s6 = s6;
        }
    }

    private Subjects getSubjects(String course, String semester) {
    	if ("BCA".equalsIgnoreCase(course)) {
    	    if ("1".equals(semester)) {
    	        return new Subjects(
    	            "Communicative English",
    	            "Basic Mathematics",
    	            "Information Technology & Application",
    	            "Principles of Management and Organisation",
    	            "Python Programming",
    	            ""
    	        );
    	    } else if ("2".equals(semester)) {
    	        return new Subjects(
    	            "Business English",
    	            "Numerical Techniques",
    	            "System Analysis and Design",
    	            "Problem solving technique and Programming in C",
    	            "Operating System & Unix",
    	            ""
    	        );
    	    } else if ("3".equals(semester)) {
    	        return new Subjects(
    	            "Object Oriented Programming using C++",
    	            "Internet and Web Designing",
    	            "Java Programming",
    	            "Software Engineering",
    	            "",
    	            ""
    	        );
    	    } else if ("4".equals(semester)) {
    	        return new Subjects(
    	            "Relational Database Management System",
    	            "Digital Electronics Computer System Architecture & Organisation",
    	            "File & Data Structure",
    	            "Introduction to Statistics",
    	            "",
    	            ""
    	        );
    	    } else if ("5".equals(semester)) {
    	        return new Subjects(
    	            "Windows Programming using VB.net",
    	            "Graphics and Multimedia",
    	            "Computer Network Data Communication & Client Server Technology",
    	            "Business Accounting & ERP",
    	            "",
    	            ""
    	        );
    	    } else if ("6".equals(semester)) {
    	        return new Subjects(
    	            "Web Technology",
    	            "E-commerce",
    	            "",
    	            "",
    	            "",
    	            ""
    	        );
    	    }
    	} else if ("BBA".equalsIgnoreCase(course)) {
    	    if ("1".equals(semester)) {
    	        return new Subjects(
    	            "Principle and Practice of Management",
    	            "Microeconomics",
    	            "Macroeconomics",
    	            "Information Technology in Management I",
    	            "Communicative English",
    	            "Marketing Management I"
    	        );
    	    } else if ("2".equals(semester)) {
    	        return new Subjects(
    	            "Business Organisation and Environment",
    	            "Financial Management I",
    	            "Human Resource Management I",
    	            "Business Maths and Stats I",
    	            "Information Technology in Management II",
    	            "Business English"
    	        );
    	    } else if ("3".equals(semester)) {
    	        return new Subjects(
    	            "Marketing Management II",
    	            "Financial Management II",
    	            "Human Resource Management II",
    	            "Business Maths and Stats II",
    	            "Corporate Communication",
    	            "Business Taxation"
    	        );
    	    } else if ("4".equals(semester)) {
    	        return new Subjects(
    	            "Strategic Management",
    	            "Production and Operation Management",
    	            "Operation Research and Logistics",
    	            "Project and Event Management",
    	            "Social and Marketing Research",
    	            "Entrepreneurship Development Programme"
    	        );
    	    } else if ("5".equals(semester)) {
    	        return new Subjects(
    	            "Retail Management",
    	            "Indian Financial System",
    	            "Security Analysis and Portfolio Management",
    	            "E-Commerce",
    	            "",
    	            ""
    	        );
    	    } else if ("6".equals(semester)) {
    	        return new Subjects(
    	            "Services Marketing",
    	            "International Finance",
    	            "Risk Management",
    	            "Business Law and Industrial Relations",
    	            "",
    	            ""
    	        );
    	    }
    	}
    	// Add more courses if needed
    	return null;

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String message = null;
        String error = null;

        String studentIdStr = request.getParameter("student_id");
        String semester = request.getParameter("semester");

        if (studentIdStr == null || semester == null || studentIdStr.trim().isEmpty() || semester.trim().isEmpty()) {
            error = "Student ID and Semester are required.";
            forwardToJsp(request, response, error, message);
            return;
        }

        int studentId = 0;
        try {
            studentId = Integer.parseInt(studentIdStr);
        } catch (NumberFormatException e) {
            error = "Invalid Student ID.";
            forwardToJsp(request, response, error, message);
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/marks", "root", "root");

            // STEP 1: Fetch student info (course, university, name)
            PreparedStatement pstCourse = conn.prepareStatement("SELECT full_name, course, university FROM registration_form WHERE id = ?");
            pstCourse.setInt(1, studentId);
            ResultSet rs = pstCourse.executeQuery();

            if (!rs.next()) {
                error = "Student ID not found.";
                conn.close();
                forwardToJsp(request, response, error, message);
                return;
            }

            String studentName = rs.getString("full_name");
            String course = rs.getString("course");
            String university = rs.getString("university");

            rs.close();
            pstCourse.close();

            // STEP 2: Get hardcoded subjects based on course + semester
            Subjects subjects = getSubjects(course, semester);

            if (subjects == null) {
                error = "No subjects defined for Course: " + course + " Semester: " + semester;
                conn.close();
                forwardToJsp(request, response, error, message);
                return;
            }

            if ("load".equalsIgnoreCase(action)) {
                // Ensure student_marks row exists
                PreparedStatement checkMarksExist = conn.prepareStatement("SELECT * FROM student_marks WHERE student_id = ? AND semester = ?");
                checkMarksExist.setInt(1, studentId);
                checkMarksExist.setString(2, semester);
                ResultSet rsMarksExist = checkMarksExist.executeQuery();

                if (!rsMarksExist.next()) {
                    PreparedStatement insertDefault = conn.prepareStatement(
                            "INSERT INTO student_marks (student_id, semester, subject1_marks, subject2_marks, subject3_marks, subject4_marks, subject5_marks, subject6_marks) VALUES (?, ?, 0, 0, 0, 0, 0, 0)");
                    insertDefault.setInt(1, studentId);
                    insertDefault.setString(2, semester);
                    insertDefault.executeUpdate();
                    insertDefault.close();
                }
                rsMarksExist.close();
                checkMarksExist.close();

                // Now fetch current marks
                PreparedStatement pstMarks = conn.prepareStatement("SELECT subject1_marks, subject2_marks, subject3_marks, subject4_marks, subject5_marks, subject6_marks FROM student_marks WHERE student_id = ? AND semester = ?");
                pstMarks.setInt(1, studentId);
                pstMarks.setString(2, semester);
                ResultSet rsMarks = pstMarks.executeQuery();

                String marks1 = "", marks2 = "", marks3 = "", marks4 = "", marks5 = "", marks6 = "";

                if (rsMarks.next()) {
                    marks1 = rsMarks.getString("subject1_marks");
                    marks2 = rsMarks.getString("subject2_marks");
                    marks3 = rsMarks.getString("subject3_marks");
                    marks4 = rsMarks.getString("subject4_marks");
                    marks5 = rsMarks.getString("subject5_marks");
                    marks6 = rsMarks.getString("subject6_marks");
                }
                rsMarks.close();
                pstMarks.close();

                request.setAttribute("student_id", studentIdStr);
                request.setAttribute("semester", semester);
                request.setAttribute("student_name", studentName);
                request.setAttribute("student_course", course);
                request.setAttribute("student_university", university);

                request.setAttribute("subject1", subjects.s1);
                request.setAttribute("subject2", subjects.s2);
                request.setAttribute("subject3", subjects.s3);
                request.setAttribute("subject4", subjects.s4);
                request.setAttribute("subject5", subjects.s5);
                request.setAttribute("subject6", subjects.s6);

                request.setAttribute("marks1", marks1);
                request.setAttribute("marks2", marks2);
                request.setAttribute("marks3", marks3);
                request.setAttribute("marks4", marks4);
                request.setAttribute("marks5", marks5);
                request.setAttribute("marks6", marks6);

                conn.close();

                request.getRequestDispatcher("add_marks.jsp").forward(request, response);
                return;

            } else if ("save".equalsIgnoreCase(action)) {
                // Save updated marks
                String s1 = request.getParameter("subject1_marks");
                String s2 = request.getParameter("subject2_marks");
                String s3 = request.getParameter("subject3_marks");
                String s4 = request.getParameter("subject4_marks");
                String s5 = request.getParameter("subject5_marks");
                String s6 = request.getParameter("subject6_marks");

                PreparedStatement pstUpdate = conn.prepareStatement(
                        "UPDATE student_marks SET subject1_marks = ?, subject2_marks = ?, subject3_marks = ?, subject4_marks = ?, subject5_marks = ?, subject6_marks = ? WHERE student_id = ? AND semester = ?");
                pstUpdate.setString(1, s1 != null ? s1 : "0");
                pstUpdate.setString(2, s2 != null ? s2 : "0");
                pstUpdate.setString(3, s3 != null ? s3 : "0");
                pstUpdate.setString(4, s4 != null ? s4 : "0");
                pstUpdate.setString(5, s5 != null ? s5 : "0");
                pstUpdate.setString(6, s6 != null ? s6 : "0");
                pstUpdate.setInt(7, studentId);
                pstUpdate.setString(8, semester);

                int rows = pstUpdate.executeUpdate();
                pstUpdate.close();
                conn.close();

                if (rows > 0) {
                    message = "Marks updated successfully for Student ID " + studentId;
                } else {
                    error = "Failed to update marks. Make sure the record exists.";
                }
                request.setAttribute("message", message);
                request.setAttribute("error", error);

                request.getRequestDispatcher("add_marks.jsp").forward(request, response);
                return;

            } else {
                error = "Invalid action.";
                conn.close();
                forwardToJsp(request, response, error, message);
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "Error: " + e.getMessage();
            forwardToJsp(request, response, error, message);
        }
    }

    private void forwardToJsp(HttpServletRequest request, HttpServletResponse response, String error, String message) throws ServletException, IOException {
        if (error != null) request.setAttribute("error", error);
        if (message != null) request.setAttribute("message", message);
        request.getRequestDispatcher("add_marks.jsp").forward(request, response);
    }
}
