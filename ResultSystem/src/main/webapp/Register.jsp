<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<% String error = request.getParameter("error"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - Marks Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    padding: 0;
    font-family: 'Poppins', sans-serif;
    background-color: #f0f2f5;
    overflow-x: hidden;
}

.top-header {
    background-color: #003366;
    color: white;
    font-size: 14px;
    padding: 6px 0;
}

.navbar-brand {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.navbar-nav .nav-link {
    font-size: 16px;
    font-weight: 500;
    color: #555555;
    transition: color 0.3s ease;
}

.navbar-nav .nav-link:hover,
.navbar-nav .nav-link.active {
    color: #007bff;
    font-weight: 600;
}

.hero-section {
    position: relative;
    background-color: #f0f2f5;
    min-height: calc(100vh - 120px);
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 50px 20px;
    overflow: hidden;
}

.register-content {
    position: relative;
    z-index: 2;
    max-width: 1200px;
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: center;
    background-color: rgba(255,255,255,0.95);
    border-radius: 16px;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
    overflow: hidden;
}

.register-image {
    flex: 1 1 50%;
    min-height: 400px;
    background: url('https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg') no-repeat center center/cover;
    animation: fadeInLeft 1.5s ease forwards;
    display: none;
}

@keyframes fadeInLeft {
    0% { opacity: 0; transform: translateX(-50px); }
    100% { opacity: 1; transform: translateX(0); }
}

@keyframes fadeInUp {
    0% { opacity: 0; transform: translateY(50px); }
    100% { opacity: 1; transform: translateY(0); }
}

.register-form {
    flex: 1 1 50%;
    padding: 40px;
    animation: fadeInUp 1s ease forwards;
}

.register-form h2 {
    color: #007bff;
    font-weight: 700;
    margin-bottom: 10px;
}

.register-form p {
    font-size: 15px;
    color: #555;
    margin-bottom: 25px;
}

.register-form .form-control {
    border-radius: 8px;
}

.register-form .btn {
    border-radius: 8px;
    font-weight: 600;
    letter-spacing: 0.5px;
}

.login-link {
    font-size: 14px;
    margin-top: 15px;
}

.login-link a {
    color: #007bff;
    text-decoration: none;
    font-weight: 600;
}

.login-link a:hover {
    text-decoration: underline;
}

.error {
    color: red;
    font-weight: bold;
    margin-top: 5px;
}

footer {
    background-color: #003366;
    color: white;
    padding: 15px 0;
    text-align: center;
    font-size: 14px;
    margin-top: 40px;
}

@media (min-width: 992px) {
    .register-image {
        display: block;
    }
}

@media (max-width: 767.98px) {
    .register-form {
        padding: 20px;
    }
    .register-content {
        border-radius: 8px;
        margin: 10px;
    }
}
</style>
</head>
<body>

<header>
    <div class="top-header">
        <div class="container d-flex flex-wrap justify-content-between align-items-center">
            <div class="info d-flex align-items-center gap-3 py-1 flex-wrap">
                <div><i class="fa-solid fa-phone"></i> +91 84090-40623</div>
                <div><i class="fa-solid fa-envelope"></i> shrestharisheek@gmail.com</div>
            </div>
            <div class="text-white small mt-1 mt-md-0">Empowering Student Success</div>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="Register.jsp" style="font-size: 24px;">
                Marks Management System <small class="text-muted" style="font-size: 14px;">by Risheek Shrestha</small>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="Register.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact Us</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<main>
    <section class="hero-section">
        <div class="register-content">
            <div class="register-image"></div>
            
            <form action="Register" method="post" class="register-form">
                <h2>Register Now</h2>
                
                <div class="mb-3">
                    <label for="name" class="form-label">Full Name:</label> 
                    <input type="text" class="form-control" id="name" name="name" required
                        value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                </div>
                
                <div class="mb-3">
                    <label for="email1" class="form-label">Email address:</label> 
                    <input type="email" class="form-control" id="email1" name="email" required
                        value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                </div>
                <% if("2".equals(error)){ %>
                <div class="error"> Email already exists. Please login to proceed</div>
                <% } %>
                
                <div class="mb-3">
                    <label for="number" class="form-label">Contact No:</label> 
                    <input type="tel" class="form-control" id="number" name="number" pattern="[0-9]{10}" required
                        value="<%= request.getParameter("number") != null ? request.getParameter("number") : "" %>">
                </div>
                
                <div class="mb-3">
                    <label for="course" class="form-label">Course:</label> 
                    <input type="text" class="form-control" id="course" name="course" required
                        value="<%= request.getParameter("course") != null ? request.getParameter("course") : "" %>">
                </div>
                
                <div class="mb-3">
                    <label for="university" class="form-label">University:</label> 
                    <input type="text" class="form-control" id="university" name="university" required
                        value="<%= request.getParameter("university") != null ? request.getParameter("university") : "" %>">
                </div>
                
                <div class="mb-3">
                    <label for="password" class="form-label">Password:</label> 
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                
                <div class="mb-3">
                    <label for="confirm_pass" class="form-label">Confirm Password:</label> 
                    <input type="password" class="form-control" id="confirm_pass" name="confirm_pass" required>
                    <% if ("1".equals(error)) { %>
                        <div class="error">Password Does Not Match</div>
                    <% } %>
                </div>
                
                <button type="submit" class="btn btn-primary w-100">Register</button>
                
                <div class="login-link text-center mt-3">
                    Already have an account? <a href="Login.jsp">Login here</a>
                </div>
            </form>
        </div>
    </section>
</main>

<footer>
    &copy; 2025 Marks Management System by Risheek Shrestha. All Rights Reserved.
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
