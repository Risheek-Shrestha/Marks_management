<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*,java.util.*"%>
<%
String teacherEmail = (String) session.getAttribute("email");
if (teacherEmail == null) {
	response.sendRedirect("Login.jsp");
	return;
}

List<Map<String, Object>> studentList = new ArrayList<>();
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3307/marks", "root", "root");

	PreparedStatement pst = conn.prepareStatement("SELECT id, full_name, email, contact FROM registration_form");
	ResultSet rs = pst.executeQuery();
	while (rs.next()) {
		Map<String, Object> student = new HashMap<>();
		student.put("id", rs.getInt("id"));
		student.put("name", rs.getString("full_name"));
		student.put("email", rs.getString("email"));
		student.put("contact", rs.getString("contact"));
		studentList.add(student);
	}
	rs.close();
	pst.close();
	conn.close();
} catch (Exception e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Teacher Dashboard | Marks Management System</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<style>
body {
	margin: 0;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	font-family: 'Poppins', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #f0f4f8, #e8f0f8);
	color: #333;
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
	padding: 8px 18px;
	border-radius: 25px;
	cursor: pointer;
	position: absolute;
	top: 20px;
	right: 20px;
	font-size: 14px;
	font-weight: 500;
	transition: all 0.3s ease;
}

.logout-button:hover {
	background-color: #ffffff;
	color: #023047;
}

main {
	flex: 1;
	display: flex;
	align-items: flex-start;
	justify-content: center;
	padding: 20px 10px;
	animation: fadeIn 0.8s ease;
}

@media ( min-height : 700px) {
	main {
		align-items: center;
	}
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.dashboard-card {
	width: 100%;
	max-width: 1100px;
	background-color: white;
	border-radius: 12px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.07);
	padding: 30px 35px;
	border-top: 6px solid #023047;
	transition: all 0.3s ease;
	margin-bottom: 20px;
}

.dashboard-card:hover {
	transform: translateY(-3px);
	box-shadow: 0 12px 24px rgba(0, 0, 0, 0.09);
}

.section-title {
	font-size: 25px;
	font-weight: 700;
	color: #023047;
	border-bottom: 3px solid #023047;
	padding-bottom: 8px;
	margin-bottom: 25px;
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 14px 16px;
	text-align: left;
	border: 1px solid #ddd;
}

th {
	background-color: #023047;
	color: #fff;
	font-size: 16px;
}

td {
	background-color: #fff;
	font-size: 15px;
	color: #555;
	transition: background-color 0.2s ease;
}

tr:hover td {
	background-color: #f9f9f9;
}

.action-btn {
	display: inline-block;
	padding: 8px 14px;
	background-color: #023047;
	color: white;
	border-radius: 50px;
	text-decoration: none;
	margin-right: 8px;
	font-size: 14px;
	font-weight: 500;
	transition: background-color 0.3s ease, transform 0.1s ease;
}

.action-btn:hover {
	background-color: #012a3a;
	transform: scale(1.03);
}

.action-btn.delete {
	background-color: #cc4b4b;
}

.action-btn.delete:hover {
	background-color: #a63a3a;
	transform: scale(1.03);
}

.action-buttons {
	text-align: center;
}

.action-buttons a {
	display: inline-block;
	padding: 12px 30px;
	background-color: #023047;
	color: white;
	font-weight: bold;
	border-radius: 50px;
	text-decoration: none;
	margin: 10px;
	font-size: 15px;
	transition: background-color 0.3s ease, transform 0.2s ease;
}

.action-buttons a:hover {
	background-color: #012a3a;
	transform: scale(1.02);
}

footer {
	background-color: #023047;
	color: white;
	text-align: center;
	padding: 15px 0;
	font-size: 14px;
	margin-top: auto;
}
</style>

<script>
    function confirmDelete(studentId) {
        if (confirm("Are you sure you want to delete student ID " + studentId + "?")) {
            window.location.href = "DeleteStudent?id=" + studentId;
        }
    }
</script>
</head>

<body>

	<!-- Header -->
	<header>
		<h1>Teacher Dashboard</h1>
		<form action="Logout" method="post" style="display: inline;">
			<button type="submit" class="logout-button">Logout</button>
		</form>
	</header>

	<!-- Main -->
	<main>
		<div class="dashboard-card">

			<div class="section-title">Enrolled Students</div>

			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Full Name</th>
						<th>Email</th>
						<th>Contact</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Map<String, Object> student : studentList) {
					%>
					<tr>
						<td><%=student.get("id")%></td>
						<td><%=student.get("name")%></td>
						<td><%=student.get("email")%></td>
						<td><%=student.get("contact")%></td>
						<td><a href="view_student.jsp?id=<%=student.get("id")%>"
							class="action-btn">View</a> <a
							href="add_marks.jsp?id=<%=student.get("id")%>" class="action-btn">Edit
								Marks</a> <a href="#" class="action-btn delete"
							onclick="confirmDelete(<%=student.get("id")%>)">Delete</a></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>

			<div class="action-buttons">
				<a href="add_student.jsp">Add Student</a> <a href="add_marks.jsp">Add
					/ Update Marks</a>
			</div>

		</div>
	</main>

	<!-- Footer -->
	<footer>&copy; 2025 Student Marks Management System</footer>

</body>
</html>
