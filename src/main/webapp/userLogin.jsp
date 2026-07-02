<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Login - LibraryMS</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter','Segoe UI',sans-serif;background:#eef4ff;min-height:100vh}
nav{height:66px;background:#0f172a;padding:0 60px;display:flex;align-items:center}
.logo{font-size:24px;font-weight:700;color:#fff}.logo span{color:#3b82f6}
.wrapper{max-width:1100px;margin:60px auto;padding:20px;display:grid;grid-template-columns:1fr 1fr;background:#fff;border-radius:22px;overflow:hidden;box-shadow:0 15px 40px rgba(0,0,0,.08)}
.left{background:linear-gradient(135deg,#2563eb,#1d4ed8);color:#fff;padding:60px 45px;display:flex;flex-direction:column;justify-content:center}
.left h1{font-size:40px;margin-bottom:20px}
.left p{line-height:1.8;color:#dbeafe}
.right{padding:50px}
.right h2{font-size:30px;margin-bottom:10px}
.right p{color:#64748b;margin-bottom:25px}
.success,.error{padding:12px;border-radius:8px;margin-bottom:18px;font-weight:600}
.success{background:#dcfce7;color:#15803d}
.error{background:#fee2e2;color:#dc2626}
label{display:block;margin:12px 0 6px;font-weight:600;color:#334155}
input{width:100%;padding:13px;border:1px solid #dbe2ea;border-radius:10px;font-size:14px}
input:focus{outline:none;border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,.12)}
button{width:100%;margin-top:22px;padding:14px;border:none;border-radius:10px;background:linear-gradient(135deg,#2563eb,#1d4ed8);color:#fff;font-size:16px;font-weight:600;cursor:pointer}
button:hover{opacity:.92}
.bottom{text-align:center;margin-top:25px;color:#64748b}
.bottom a{text-decoration:none;color:#2563eb;font-weight:600}
@media(max-width:900px){.wrapper{grid-template-columns:1fr}.left{display:none}}
</style>
</head>
<body>

<nav><div class="logo">Library<span>MS</span></div></nav>

<div class="wrapper">

<div class="left">
<h1>Welcome Back!</h1>
<p>Login to access your library dashboard, search books, view borrowed books and manage your account.</p>
</div>

<div class="right">

<h2>User Login</h2>
<p>Sign in to continue.</p>

<%
String msg=request.getParameter("msg");
if(msg!=null){
%>
<div class="success"><%=msg%></div>
<%
}
String error=(String)request.getAttribute("error");
if(error!=null){
%>
<div class="error"><%=error%></div>
<%
}
%>

<form action="userLogin" method="post">

<label>Email</label>
<input type="email" name="email" placeholder="Enter your email" required>

<label>Password</label>
<input type="password" name="password" placeholder="Enter your password" required>

<button type="submit">Login</button>

</form>

<div class="bottom">
Don't have an account?<br><br>
<a href="register.jsp">Register Here</a>
</div>

</div>
</div>

</body>
</html>