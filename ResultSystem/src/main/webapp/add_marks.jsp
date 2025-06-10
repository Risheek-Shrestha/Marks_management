<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String message = (String) request.getAttribute("message");
String error = (String) request.getAttribute("error");

String teacherEmail = (String) session.getAttribute("email");
if (teacherEmail == null) {
    response.sendRedirect("Login.jsp");
    return;
}

String studentIdParam = (String) request.getAttribute("student_id");
String selectedSemester = (String) request.getAttribute("semester");

String subject1 = (String) request.getAttribute("subject1");
String subject2 = (String) request.getAttribute("subject2");
String subject3 = (String) request.getAttribute("subject3");
String subject4 = (String) request.getAttribute("subject4");
String subject5 = (String) request.getAttribute("subject5");
String subject6 = (String) request.getAttribute("subject6");

String marks1 = (String) request.getAttribute("marks1");
String marks2 = (String) request.getAttribute("marks2");
String marks3 = (String) request.getAttribute("marks3");
String marks4 = (String) request.getAttribute("marks4");
String marks5 = (String) request.getAttribute("marks5");
String marks6 = (String) request.getAttribute("marks6");

boolean studentLoaded = (subject1 != null && !subject1.isEmpty());
%>

<!DOCTYPE html>
<html>
<head>
<title>Add / Update Marks | Marks Management System</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />

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
    flex: 1;
    padding: 40px 20px; /* Bigger padding */
    animation: fadeIn 0.8s ease;
    max-width: 1200px;  /* Wider main section */
    margin: 0 auto;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.table-form {
    background-color: white;
    border-radius: 16px; /* Bigger radius */
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1); 
    padding: 40px 50px; 
    border-top: 6px solid #023047;
    margin-bottom: 20px;
    font-size: 18px; 
}

.table-form h2 {
    text-align: center;
    margin-bottom: 30px;
    color: #023047;
    font-weight: 700;
    font-size: 28px;
}

footer {
    background-color: #023047;
    color: white;
    text-align: center;
    padding: 18px 0;
    font-size: 15px;
    margin-top: auto;
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

<!-- Main -->
<main>
    <div class="table-form">

        <h2>Add / Update Marks</h2>

        <!-- Load Form Section -->
        <div style="<%=studentLoaded ? "display:none;" : ""%>">
            <form method="post" action="AddMarks">
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="student_id" class="form-label">Student ID:</label> 
                        <input type="number" name="student_id" class="form-control" required
                            value="<%=studentIdParam != null ? studentIdParam : ""%>" />
                    </div>
                    <div class="col-md-4">
                        <label for="semester" class="form-label">Semester:</label> 
                        <select name="semester" class="form-select" required>
                            <option value="">Select Semester</option>
                            <% for (int i = 1; i <= 6; i++) { %>
                                <option value="<%=i%>" <%=String.valueOf(i).equals(selectedSemester) ? "selected" : ""%>>Semester <%=i%></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-4 d-flex align-items-end">
                        <button type="submit" name="action" value="load" class="btn btn-primary w-100">Load Student</button>
                    </div>
                </div>
            </form>
            <!-- Back to Dashboard -->
            <a href="Teacher_dashboard.jsp" class="btn btn-secondary mb-3">Back to Dashboard</a>
        </div>

        <!-- Marks Form Section -->
        <div style="<%=studentLoaded ? "" : "display:none;"%>">
            <!-- Student Info -->
            <div class="mb-4 p-3 border rounded bg-light">
                <h5 class="mb-3 text-primary">Student Details</h5>
                <dl class="row mb-0">
                    <dt class="col-sm-4">Name:</dt>
                    <dd class="col-sm-8"><%=request.getAttribute("student_name")%></dd>

                    <dt class="col-sm-4">Course:</dt>
                    <dd class="col-sm-8"><%=request.getAttribute("student_course")%></dd>

                    <dt class="col-sm-4">University:</dt>
                    <dd class="col-sm-8"><%=request.getAttribute("student_university")%></dd>

                    <dt class="col-sm-4">Student ID:</dt>
                    <dd class="col-sm-8"><%=studentIdParam%></dd>

                    <dt class="col-sm-4">Semester:</dt>
                    <dd class="col-sm-8"><%=selectedSemester%></dd>
                </dl>
            </div>

            <form method="post" action="AddMarks">
                <input type="hidden" name="student_id" value="<%=studentIdParam%>" />
                <input type="hidden" name="semester" value="<%=selectedSemester%>" />

                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Subject</th>
                            <th>Marks (out of 100)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%-- Subjects --%>
                        <tr><td><%=subject1%></td><td><input type="number" min="0" max="100" name="subject1_marks" class="form-control" required value="<%=marks1 != null ? marks1 : ""%>" /></td></tr>
                        <tr><td><%=subject2%></td><td><input type="number" min="0" max="100" name="subject2_marks" class="form-control" required value="<%=marks2 != null ? marks2 : ""%>" /></td></tr>
                        <tr><td><%=subject3%></td><td><input type="number" min="0" max="100" name="subject3_marks" class="form-control" required value="<%=marks3 != null ? marks3 : ""%>" /></td></tr>
                        <tr><td><%=subject4%></td><td><input type="number" min="0" max="100" name="subject4_marks" class="form-control" required value="<%=marks4 != null ? marks4 : ""%>" /></td></tr>
                        <% if (subject5 != null && !subject5.isEmpty()) { %>
                            <tr><td><%=subject5%></td><td><input type="number" min="0" max="100" name="subject5_marks" class="form-control" value="<%=marks5 != null ? marks5 : ""%>" /></td></tr>
                        <% } %>
                        <% if (subject6 != null && !subject6.isEmpty()) { %>
                            <tr><td><%=subject6%></td><td><input type="number" min="0" max="100" name="subject6_marks" class="form-control" value="<%=marks6 != null ? marks6 : ""%>" /></td></tr>
                        <% } %>
                    </tbody>
                </table>

                <button type="submit" name="action" value="save" class="btn btn-success">Save Marks</button>
            </form>

            <form action="AddMarks" method="post" class="mt-3">
                <button type="submit" class="btn btn-primary" name="action" value="reset">Update Marks of Another Student</button>
            </form>
        </div>

    </div>
</main>

<!-- Footer -->
<footer>&copy; 2025 Student Marks Management System</footer>

<!-- Toastr JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<script>
<% if (message != null) { %>
    toastr.success('<%=message%>');
<% } %>

<% if (error != null) { %>
    toastr.error('<%=error%>');
<% } %>
</script>

</body>
</html>
