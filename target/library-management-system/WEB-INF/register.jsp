<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Registration</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#f4f4f4;
}

.container{
    width:400px;
    margin:60px auto;
    background:white;
    padding:25px;
    border-radius:8px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
}

h2{
    text-align:center;
    color:#007bff;
}

input{
    width:100%;
    padding:10px;
    margin:10px 0;
    box-sizing:border-box;
}

button{
    width:100%;
    padding:10px;
    background:#007bff;
    color:white;
    border:none;
    cursor:pointer;
    font-size:16px;
}

button:hover{
    background:#0056b3;
}

a{
    text-decoration:none;
}

</style>

</head>
<body>

<div class="container">

<h2>User Registration</h2>

<form action="register" method="post">

<label>Name</label>
<input
type="text"
name="name"
required>

<label>Email</label>
<input
type="email"
name="email"
required>

<label>Password</label>
<input
type="password"
name="password"
required>

<button type="submit">
Register
</button>

</form>

<br>

<center>
Already have an account?
<br><br>
<a href="userLogin.jsp">User Login</a>
</center>

</div>

</body>
</html>