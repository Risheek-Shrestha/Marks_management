<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String error = request.getParameter("error");
String teacherEmail = (String) session.getAttribute("email");
if (teacherEmail == null) {
    response.sendRedirect("Login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Add Student | Marks Management System</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

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

@media (min-height: 700px) {
    main {
        align-items: center;
    }
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

.table-form {
    width: 100%;
    max-width: 800px;
    background-color: white;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.07);
    padding: 30px 35px;
    border-top: 6px solid #023047;
    transition: all 0.3s ease;
    margin-bottom: 20px;
}

.table-form:hover {
    transform: translateY(-3px);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.09);
}

.table-form h2 {
    text-align: center;
    margin-bottom: 25px;
    color: #023047;
    font-weight: 700;
    font-size: 25px;
}

.form-group {
    display: flex;
    align-items: center;
    margin-bottom: 16px;
    flex-wrap: wrap;
}

.form-group label {
    flex: 0 0 35%;
    text-align: right;
    padding-right: 15px;
    font-weight: 600;
    color: #444;
    font-size: 15px;
}

.input-with-icon {
    flex: 1;
    position: relative;
}

.input-with-icon i {
    position: absolute;
    top: 50%;
    left: 12px;
    transform: translateY(-50%);
    color: #999;
    font-size: 14px;
    pointer-events: none;
}

.input-with-icon input {
    width: 100%;
    padding: 10px 12px 10px 36px;
    border-radius: 8px;
    border: 1px solid #ccc;
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}

.input-with-icon input:focus {
    border-color: #023047;
    box-shadow: 0 0 0 3px rgba(2, 48, 71, 0.15);
    outline: none;
}

.btn-submit {
    background-color: #023047;
    color: white;
    font-weight: bold;
    border: none;
    padding: 12px 30px;
    border-radius: 50px;
    font-size: 15px;
    letter-spacing: 0.5px;
    transition: background-color 0.3s ease, transform 0.2s ease;
    display: block;
    margin: 25px auto 0;
}

.btn-submit:hover {
    background-color: #012a3a;
    transform: scale(1.02);
}

.error {
    color: red;
    font-size: 14px;
    font-weight: 600;
    margin-top: 5px;
    text-align: center;
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
    padding: 15px 0;
    font-size: 14px;
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
    <form action="Register" method="post" class="table-form">

        <h2>Add New Student</h2>

        <div class="form-group">
            <label for="name">Full Name:</label>
            <div class="input-with-icon">
                <i class="fa fa-user"></i>
                <input type="text" name="name" id="name" required value="<%=request.getParameter("name") != null ? request.getParameter("name") : ""%>">
            </div>
        </div>

        <div class="form-group">
            <label for="email">Email Address:</label>
            <div class="input-with-icon">
                <i class="fa fa-envelope"></i>
                <input type="email" name="email" id="email" required value="<%=request.getParameter("email") != null ? request.getParameter("email") : ""%>">
            </div>
        </div>
        <% if ("2".equals(error)) { %>
            <div class="error">Email already exists. Please use another email.</div>
        <% } %>

        <div class="form-group">
            <label for="number">Contact No:</label>
            <div class="input-with-icon">
                <i class="fa fa-phone"></i>
                <input type="tel" name="number" id="number" pattern="[0-9]{10}" required value="<%=request.getParameter("number") != null ? request.getParameter("number") : ""%>">
            </div>
        </div>

        <div class="form-group">
            <label for="course">Course:</label>
            <div class="input-with-icon">
                <i class="fa fa-book"></i>
                <input type="text" name="course" id="course" required value="<%=request.getParameter("course") != null ? request.getParameter("course") : ""%>">
            </div>
        </div>

        <div class="form-group">
            <label for="university">University:</label>
            <div class="input-with-icon">
                <i class="fa fa-university"></i>
                <input type="text" name="university" id="university" required value="<%=request.getParameter("university") != null ? request.getParameter("university") : ""%>">
            </div>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <div class="input-with-icon">
                <i class="fa fa-lock"></i>
                <input type="password" name="password" id="password" required>
            </div>
        </div>

        <div class="form-group">
            <label for="confirm_pass">Confirm Password:</label>
            <div class="input-with-icon">
                <i class="fa fa-lock"></i>
                <input type="password" name="confirm_pass" id="confirm_pass" required>
            </div>
        </div>
        <% if ("1".equals(error)) { %>
            <div class="error">Password Does Not Match</div>
        <% } %>

        <button type="submit" class="btn-submit">Add Student</button>

        <a href="Teacher_dashboard.jsp" class="back-link">&larr; Back to Dashboard</a>

    </form>
</main>

<!-- Footer -->
<footer>&copy; 2025 Student Marks Management System</footer>

</body>
</html>
