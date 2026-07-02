<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Issue Book — LibraryMS</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Inter','Segoe UI',sans-serif;
}

body{
background:#f0f4ff;
color:#1e293b;
min-height:100vh;
display:flex;
flex-direction:column;
}

/* ---------- Navbar ---------- */

nav{
background:#0f172a;
height:66px;
padding:0 60px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 1px 0 rgba(255,255,255,.05);
}

.logo{
font-size:22px;
font-weight:700;
color:white;
}

.logo span{
color:#3b82f6;
}

.logout-btn{
padding:8px 16px;
background:rgba(255,255,255,.05);
border:1px solid rgba(255,255,255,.1);
border-radius:8px;
color:#e2e8f0;
text-decoration:none;
font-size:13px;
font-weight:600;
transition:.25s;
}

.logout-btn:hover{
background:rgba(239,68,68,.15);
color:#fca5a5;
}

/* ---------- Page ---------- */

.page{

max-width:700px;

width:100%;

margin:auto;

padding:45px 20px;

flex:1;

}

.breadcrumb{

font-size:13px;

color:#64748b;

margin-bottom:20px;

}

.breadcrumb a{

text-decoration:none;

color:#64748b;

}

.breadcrumb a:hover{

color:#2563eb;

}

/* ---------- Card ---------- */

.card{

background:white;

border-radius:16px;

padding:35px;

box-shadow:0 5px 20px rgba(0,0,0,.08);

border:1px solid #e2e8f0;

}

.card h2{

font-size:26px;

margin-bottom:6px;

}

.subtitle{

font-size:14px;

color:#64748b;

margin-bottom:28px;

}

/* ---------- Form ---------- */

label{

display:block;

margin-bottom:8px;

font-size:14px;

font-weight:600;

color:#334155;

}

input{

width:100%;

padding:12px 14px;

margin-bottom:20px;

border:1px solid #d1d5db;

border-radius:10px;

font-size:14px;

outline:none;

transition:.25s;

}

input:focus{

border-color:#2563eb;

box-shadow:0 0 0 3px rgba(37,99,235,.12);

}

button{

width:100%;

padding:14px;

border:none;

border-radius:10px;

background:linear-gradient(135deg,#2563eb,#1d4ed8);

color:white;

font-size:15px;

font-weight:600;

cursor:pointer;

transition:.25s;

}

button:hover{

opacity:.9;

}

/* ---------- Back ---------- */

.back{

display:inline-block;

margin-top:22px;

text-decoration:none;

font-size:14px;

color:#2563eb;

font-weight:600;

}

.back:hover{

text-decoration:underline;

}

/* ---------- Footer ---------- */

footer{

background:#0f172a;

color:#64748b;

text-align:center;

padding:20px;

font-size:13px;

}

footer span{

color:#94a3b8;

}

</style>

</head>

<body>

<nav>

<div class="logo">
Library<span>MS</span>
</div>

<a href="logout" class="logout-btn">
Logout
</a>

</nav>

<div class="page">

<div class="breadcrumb">

<a href="dashboard.jsp">Dashboard</a>

>

Issue Book

</div>

<div class="card">

<h2>Issue Book</h2>

<p class="subtitle">

Issue a book to a registered user.

</p>

<form action="IssueBookServlet" method="post">

<label>User ID</label>

<input type="number" name="userId" required>

<label>Book ID</label>

<input type="number" name="bookId" required>

<label>Issue Date</label>

<input type="date" name="issueDate" required>

<label>Return Date</label>

<input type="date" name="returnDate" required>

<button type="submit">

Issue Book

</button>

</form>

<a class="back" href="dashboard.jsp">

← Back to Dashboard

</a>

</div>

</div>

<footer>

© 2026 Integrated Library Management System ·
<span>Java</span> ·
<span>JSP</span> ·
<span>Servlets</span> ·
<span>JDBC</span> ·
<span>MySQL</span>

</footer>

</body>
</html>