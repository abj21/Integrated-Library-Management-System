<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Registration</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:#eef3fb;
    display:flex;
    flex-direction:column;
    min-height:100vh;
}

/* Navbar */

.navbar{
    background:#111827;
    color:white;
    padding:18px 8%;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
}

.logo{
    font-size:24px;
    font-weight:bold;
}

.navbar a{
    color:white;
    text-decoration:none;
    margin-left:20px;
    transition:.3s;
    font-weight:500;
}

.navbar a:hover{
    color:#60a5fa;
}

/* Main Section */

.main{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:40px 20px;
}

/* Card */

.container{
    width:100%;
    max-width:460px;
    background:#fff;
    border-radius:16px;
    padding:35px;
    box-shadow:0 10px 30px rgba(0,0,0,.12);
}

.container h2{
    text-align:center;
    color:#2563eb;
    margin-bottom:25px;
    font-size:30px;
}

.info{
    background:#eff6ff;
    color:#1e3a8a;
    border-left:5px solid #2563eb;
    padding:15px;
    border-radius:10px;
    margin-bottom:25px;
    font-size:15px;
    line-height:1.5;
}

label{
    display:block;
    margin-bottom:8px;
    margin-top:18px;
    color:#374151;
    font-weight:bold;
}

input{
    width:100%;
    padding:13px 15px;
    border:1px solid #d1d5db;
    border-radius:10px;
    font-size:15px;
    transition:.3s;
    outline:none;
}

input:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 4px rgba(37,99,235,.15);
}

button{
    width:100%;
    margin-top:28px;
    padding:14px;
    background:#16a34a;
    color:white;
    border:none;
    border-radius:10px;
    cursor:pointer;
    font-size:16px;
    font-weight:bold;
    transition:.3s;
}

button:hover{
    background:#15803d;
    transform:translateY(-2px);
}

.login-text{
    text-align:center;
    margin-top:25px;
    color:#4b5563;
    font-size:15px;
}

.login-text a{
    color:#2563eb;
    text-decoration:none;
    font-weight:bold;
}

.login-text a:hover{
    text-decoration:underline;
}

/* Footer */

footer{
    background:#111827;
    color:#d1d5db;
    text-align:center;
    padding:18px;
    font-size:15px;
}

/* Responsive */

@media(max-width:600px){

.container{
    padding:25px;
}

.container h2{
    font-size:26px;
}

.logo{
    font-size:20px;
}

.navbar{
    flex-direction:column;
    gap:10px;
}

}

</style>

</head>
<body>

<!-- Navbar -->

<div class="navbar">

<div class="logo">
📚 Integrated Library Management System
</div>

<div>
<a href="index.jsp">Home</a>
<a href="userLogin.jsp">User Login</a>
<a href="login.jsp">Admin Login</a>
</div>

</div>

<!-- Main Content -->

<div class="main">

<div class="container">

<h2>Create Account</h2>

<div class="info">
Your account will remain <b>Pending</b> after registration and must be approved by the librarian/admin before you can log in.
</div>

<form action="register" method="post">

<label>Name</label>
<input
type="text"
name="name"
placeholder="Enter your full name"
required>

<label>Email</label>
<input
type="email"
name="email"
placeholder="Enter your email"
required>

<label>Password</label>
<input
type="password"
name="password"
placeholder="Create a password"
required>

<button type="submit">
Register
</button>

</form>

<div class="login-text">
Already have an account?<br><br>
<a href="userLogin.jsp">Login Here</a>
</div>

</div>

</div>

<!-- Footer -->

<footer>
© 2026 Integrated Library Management System | L&amp;T EduTech Project
</footer>

</body>
</html>