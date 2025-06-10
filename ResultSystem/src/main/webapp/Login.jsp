<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String error = request.getParameter("error"); %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login | Marks Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet" />
<style>
body {
    background-color: #f4f6f9;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    color: #333;
    margin: 0;
    padding: 0;
}

.top-header {
    background: linear-gradient(90deg, #003366 0%, #004080 100%);
    color: white;
    font-size: 14px;
    padding: 6px 0;
}

.navbar {
    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    background-color: #fff;
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

.navbar-nav .nav-link:hover {
    color: #004080;
}

.navbar-nav .nav-link.active {
    color: #004080;
    font-weight: 600;
}

.page-container {
    display: flex;
    flex-wrap: wrap;
    min-height: calc(100vh - 200px);
    background: linear-gradient(to right, #ffffff 30%, #f4f6f9 100%);
}

.image-side {
    flex: 1 1 40%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.image-side img {
    max-width: 100%;
    height: auto;
    object-fit: contain;
}

.form-side {
    flex: 1 1 60%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 20px;
}

.login-card {
    width: 100%;
    max-width: 400px;
    background-color: #fff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
}

.login-card h2 {
    font-size: 26px;
    font-weight: bold;
    margin-bottom: 20px;
    color: #003366;
    text-align: center;
}

.form-control-icon {
    position: relative;
    margin-bottom: 20px;
}

.form-control-icon input {
    padding-left: 42px;
}

.form-control-icon i {
    position: absolute;
    top: 50%;
    left: 12px;
    transform: translateY(-50%);
    color: #555555;
    font-size: 16px;
    pointer-events: none;
}

.btn-primary {
    background-color: #003366;
    border-color: #003366;
    font-size: 16px;
    padding: 12px;
    border-radius: 8px;
}

.btn-primary:hover {
    background-color: #002855;
    border-color: #002855;
}

.register-link p {
    margin-bottom: 8px;
    color: #555555;
    text-align: center;
}

.register-link .btn-outline-primary {
    border-color: #003366;
    color: #003366;
    font-size: 16px;
    padding: 12px;
    border-radius: 8px;
}

.register-link .btn-outline-primary:hover {
    background-color: #003366;
    color: #fff;
}

footer {
    background-color: #f8f9fa;
    padding: 15px 0;
    text-align: center;
    font-size: 14px;
    color: #555;
    box-shadow: inset 0 1px 0 #eaeaea;
}

@media (max-width: 991px) {
    .page-container {
        flex-direction: column;
        background: #f4f6f9;
        padding: 20px;
    }

    .image-side {
        flex: 0 0 auto;
        margin-bottom: 20px;
    }

    .form-side {
        flex: 0 0 auto;
    }
}
</style>
</head>
<body>

<header>
    <div class="top-header">
        <div class="container d-flex justify-content-between align-items-center">
            <div class="info d-flex align-items-center gap-3 py-1">
                <div><i class="fa-solid fa-phone"></i> +91 84090-40623</div>
                <div><i class="fa-solid fa-envelope"></i> shrestharisheek@gmail.com</div>
            </div>
            <div class="text-white small">Empowering Student Success</div>
        </div>
    </div>

    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-primary" href="Register.jsp" style="font-size: 24px;">
                Marks Management System <small class="text-muted" style="font-size: 14px;">by Risheek Shrestha</small>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="Register.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">About</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<div class="page-container">
    <div class="image-side">
        <img src="assets/img/bg5.webp" alt="Login Image">
    </div>
    <div class="form-side">
        <form action="Login" method="post" class="login-card">
            <h2>Login to Your Account</h2>
            <div class="form-control-icon">
                <i class="fa-solid fa-envelope"></i>
                <input type="email" class="form-control" id="email1" name="email" placeholder="Email Address" required>
            </div>
            <div class="form-control-icon">
                <i class="fa-solid fa-lock"></i>
                <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 mb-3">Login</button>
            <div class="register-link">
                <p>Don't have an account?</p>
                <a href="Register.jsp" class="btn btn-outline-primary w-100">Click here to Register</a>
            </div>
        </form>
    </div>
</div>

<footer>
    &copy; 2025 Marks Management System. All rights reserved. Designed by Risheek Shrestha.
</footer>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script>
    $(document).ready(function() {
        toastr.options = {
            "closeButton": true,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "timeOut": "5000"
        };
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('registered') === 'true') {
            toastr.success('Registration successful. Login to proceed');
        }
        if (urlParams.get('error') === '1') {
            toastr.error('Invalid Credentials. User Details not found');
        }
    });
</script>

</body>
</html>
