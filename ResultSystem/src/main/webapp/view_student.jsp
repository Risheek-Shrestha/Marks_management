<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
String teacherEmail = (String) session.getAttribute("email");
if (teacherEmail == null) {
	response.sendRedirect("Login.jsp?error=1");
	return;
}

String selectedSemester = request.getParameter("semester");
if (selectedSemester == null || selectedSemester.isEmpty()) {
	selectedSemester = "1";
}

String studentIdParam = request.getParameter("id");
int studentId = 0;
try {
	studentId = Integer.parseInt(studentIdParam);
} catch (Exception e) {
	response.getWriter().println("Invalid student ID");
	return;
}

String studentName = "";
String studentEmail = "";
String course = "";
String university = "";
String subject1 = "", subject2 = "", subject3 = "", subject4 = "", subject5 = "", subject6 = "";
int subject1_marks = 0, subject2_marks = 0, subject3_marks = 0, subject4_marks = 0, subject5_marks = 0,
		subject6_marks = 0;

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/marks", "root", "root");

	PreparedStatement ps1 = conn
	.prepareStatement("SELECT id, full_name, email, course, university FROM registration_form WHERE id = ?");
	ps1.setInt(1, studentId);
	ResultSet rs = ps1.executeQuery();
	if (rs.next()) {
		studentId = rs.getInt("id");
		studentEmail = rs.getString("email");
		university = rs.getString("university");
		studentName = rs.getString("full_name");
		course = rs.getString("course");
	}
	rs.close();
	ps1.close();

	if ("aku".equalsIgnoreCase(university)) {
		if ("1".equals(selectedSemester) && "bba".equalsIgnoreCase(course)) {
	subject1 = "Principle and Practice of Management";
	subject2 = "Microeconomics";
	subject3 = "Macroeconomics";
	subject4 = "Information Technology in Management I";
	subject5 = "Communicative English";
	subject6 = "Marketing Management I";
		} else if ("2".equals(selectedSemester) && "bba".equalsIgnoreCase(course)) {
	subject1 = "Business Organisation and Environment";
	subject2 = "Financial Management I";
	subject3 = "Human Resource Management I";
	subject4 = "Business Maths and Stats I";
	subject5 = "Information Technology in Management II";
	subject6 = "Business English";
		} else if ("3".equals(selectedSemester) && "bba".equalsIgnoreCase(course)) {
	subject1 = "Marketing Management II";
	subject2 = "Financial Management II";
	subject3 = "Human Resource Management II";
	subject4 = "Business Maths and Stats II";
	subject5 = "Corporate Communication";
	subject6 = "Business Taxation";
		} else if ("4".equals(selectedSemester) && "bba".equalsIgnoreCase(course)) {
	subject1 = "Strategic Management";
	subject2 = "Production and Operation Management";
	subject3 = "Operation Research and Logistics";
	subject4 = "Project and Event Management";
	subject5 = "Social and Marketing Research";
	subject6 = "Entrepreneurship Development Programme";
		} else if ("5".equals(selectedSemester) && "bba".equalsIgnoreCase(course)) {
	subject1 = "Retail Management";
	subject2 = "Indian Financial System";
	subject3 = "Security Analysis and Portfolio Management";
	subject4 = "E-Commerce";
	subject5 = "";
	subject6 = "";
		} else if ("6".equals(selectedSemester) && "bba".equalsIgnoreCase(course)) {
	subject1 = "Services Marketing";
	subject2 = "International Finance";
	subject3 = "Risk Management";
	subject4 = "Business Law and Industrial Relations";
	subject5 = "";
	subject6 = "";
		} else if ("1".equals(selectedSemester) && "bca".equalsIgnoreCase(course)) {
	subject1 = "Communicative English";
	subject2 = "Basic Mathematics";
	subject3 = "Information Technology & Application";
	subject4 = "Principles of Management and Organisation";
	subject5 = "Python Programming";
	subject6 = "";
		} else if ("2".equals(selectedSemester) && "bca".equalsIgnoreCase(course)) {
	subject1 = "Business English";
	subject2 = "Numerical Techniques";
	subject3 = "System Analysis and Design";
	subject4 = "Problem solving technique and Programming in C";
	subject5 = "Operating System & Unix";
	subject6 = "";
		} else if ("3".equals(selectedSemester) && "bca".equalsIgnoreCase(course)) {
	subject1 = "Object Oriented Programming using C++";
	subject2 = "Internet and Web Designing";
	subject3 = "Java Programming";
	subject4 = "Software Engineering";
	subject5 = "";
	subject6 = "";
		} else if ("4".equals(selectedSemester) && "bca".equalsIgnoreCase(course)) {
	subject1 = "Relational Database Management System";
	subject2 = "Digital Electronics Computer System Architecture & Organisation";
	subject3 = "File & Data Structure";
	subject4 = "Introduction to Statistics";
	subject5 = "";
	subject6 = "";
		} else if ("5".equals(selectedSemester) && "bca".equalsIgnoreCase(course)) {
	subject1 = "Windows Programming using VB.net";
	subject2 = "Graphics and Multimedia";
	subject3 = "Computer Network Data Communication & Client Server Technology";
	subject4 = "Business Accounting & ERP";
	subject5 = "";
	subject6 = "";
		} else if ("6".equals(selectedSemester) && "bca".equalsIgnoreCase(course)) {
	subject1 = "Web Technology";
	subject2 = "E-commerce";
	subject3 = "";
	subject4 = "";
	subject5 = "";
	subject6 = "";
		}
	}

	PreparedStatement ps2 = conn.prepareStatement(
	"SELECT subject1_marks, subject2_marks, subject3_marks, subject4_marks, subject5_marks, subject6_marks "
			+ "FROM student_marks WHERE student_id = ? AND semester = ?");
	ps2.setInt(1, studentId);
	ps2.setString(2, selectedSemester);
	ResultSet rs2 = ps2.executeQuery();
	if (rs2.next()) {
		subject1_marks = rs2.getInt("subject1_marks");
		subject2_marks = rs2.getInt("subject2_marks");
		subject3_marks = rs2.getInt("subject3_marks");
		subject4_marks = rs2.getInt("subject4_marks");
		subject5_marks = rs2.getInt("subject5_marks");
		subject6_marks = rs2.getInt("subject6_marks");
	}
	rs2.close();
	ps2.close();

	conn.close();

} catch (Exception e) {
	e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>View Student | Teacher Dashboard</title>
<style>

body {
    margin: 0;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #f0f4f8, #e8f0f8);
    color: #333;
    font-size: 18px;
}

header {
    background-color: #023047;
    color: #fff;
    padding: 20px 20px;
    text-align: center;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    position: relative;
}

header h1 {
    margin: 0;
    font-size: 28px;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.logout-button {
    background-color: transparent;
    color: #ffffff;
    border: 2px solid #ffffff;
    padding: 10px 20px;
    border-radius: 25px;
    cursor: pointer;
    position: absolute;
    top: 20px;
    right: 20px;
    font-size: 15px;
    font-weight: 500;
    transition: all 0.3s ease;
}

.logout-button:hover {
    background-color: #ffffff;
    color: #023047;
}

main {
	max-width: 960px;
	margin: 50px auto;
	background: #fff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
}

.section {
	margin-bottom: 40px;
}

h2 {
	font-size: 26px;
	color: #023047;
	margin-bottom: 25px;
	text-align: center;
	position: relative;
}

h2::after {
	content: "";
	display: block;
	width: 80px;
	height: 4px;
	background-color: #0077b6;
	margin: 8px auto 0;
	border-radius: 2px;
}

.info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
	font-size: 16px;
}

.info-item {
	background-color: #e6f2fb;
	padding: 16px 20px;
	border-left: 5px solid #0077b6;
	border-radius: 6px;
}

.info-item strong {
	display: block;
	color: #005075;
	margin-bottom: 6px;
}

.marks-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 20px;
}

.mark-card {
	background: #f9fcfe;
	border: 1px solid #cce4f6;
	border-radius: 8px;
	padding: 18px 20px;
	text-align: center;
}

.mark-card h3 {
	font-size: 16px;
	margin-bottom: 10px;
	color: #0077b6;
}

.mark-card .score {
	font-size: 20px;
	font-weight: bold;
	color: #023047;
}
.back-link {
    display: inline-block;
    margin-top: 20px;
    text-decoration: none;
    color: #007bff;
    font-weight: 500;
    transition: color 0.3s ease;
    display: block;
    text-align: center;
}

.back-link:hover {
    text-decoration: underline;
    color: #0056b3;
}

footer {
    background-color: #023047;
    color: white;
    text-align: center;
    padding: 18px 0;
    font-size: 15px;
    margin-top: auto;
}

@media ( max-width : 768px) {
	.info-grid, .marks-grid {
		grid-template-columns: 1fr;
	}
	main {
		padding: 25px 20px;
	}
}

.semester-form {
	text-align: center;
	margin-bottom: 30px;
}

select {
	padding: 8px 12px;
	font-size: 16px;
	border-radius: 6px;
	border: 1px solid #0077b6;
}

button.submit-btn {
	padding: 8px 16px;
	font-size: 16px;
	background-color: #0077b6;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	margin-left: 10px;
	transition: background-color 0.3s ease;
}

button.submit-btn:hover {
	background-color: #005f8a;
}
</style>
</head>
<body>
	
<!-- Header -->
<header>
    <h1>Teacher Dashboard</h1>
    <form action="Logout" method="post" style="display: inline;">
        <button type="submit" class="logout-button">Logout</button>
    </form>
</header>

	<main>
		<div class="section">
			<h2>
				Viewing:
				<%=studentName%>
			</h2>
			<div class="info-grid">
				<div class="info-item">
					<strong>Email:</strong>
					<%=studentEmail%>
				</div>
				<div class="info-item">
					<strong>Course:</strong>
					<%=course%>
				</div>
				<div class="info-item">
					<strong>Semester/Year:</strong>
					<form method="get" action="view_student.jsp"
						style="display: inline;">
						<input type="hidden" name="id" value="<%=studentId%>"> <select
							name="semester" id="semester" onchange="this.form.submit()"
							style="margin-top: 5px;">
							<%
							for (int i = 1; i <= 6; i++) {
							%>
							<option value="<%=i%>"
								<%=String.valueOf(i).equals(selectedSemester) ? "selected" : ""%>><%=i%></option>
							<%
							}
							%>
						</select>
					</form>
				</div>
				<div class="info-item">
					<strong>University:</strong>
					<%=university%>
				</div>
			</div>
		</div>

		<div class="section">
			<h2>Subject Marks</h2>
			<div class="marks-grid">
				<%
				if (subject1 != null && !subject1.trim().isEmpty()) {
				%>
				<div class="mark-card">
					<h3><%=subject1%></h3>
					<div class="score"><%=subject1_marks%></div>
				</div>
				<%
				}
				%>
				<%
				if (subject2 != null && !subject2.trim().isEmpty()) {
				%>
				<div class="mark-card">
					<h3><%=subject2%></h3>
					<div class="score"><%=subject2_marks%></div>
				</div>
				<%
				}
				%>
				<%
				if (subject3 != null && !subject3.trim().isEmpty()) {
				%>
				<div class="mark-card">
					<h3><%=subject3%></h3>
					<div class="score"><%=subject3_marks%></div>
				</div>
				<%
				}
				%>
				<%
				if (subject4 != null && !subject4.trim().isEmpty()) {
				%>
				<div class="mark-card">
					<h3><%=subject4%></h3>
					<div class="score"><%=subject4_marks%></div>
				</div>
				<%
				}
				%>
				<%
				if (subject5 != null && !subject5.trim().isEmpty()) {
				%>
				<div class="mark-card">
					<h3><%=subject5%></h3>
					<div class="score"><%=subject5_marks%></div>
				</div>
				<%
				}
				%>
				<%
				if (subject6 != null && !subject6.trim().isEmpty()) {
				%>
				<div class="mark-card">
					<h3><%=subject6%></h3>
					<div class="score"><%=subject6_marks%></div>
				</div>
				<%
				}
				%>
			</div>
		</div>
	<a href="Teacher_dashboard.jsp" class="back-link">← Back to Dashboard</a>
	</main>
	<footer>&copy; 2025 Student Marks Management System</footer>
</body>
</html>
