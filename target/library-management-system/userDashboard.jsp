<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if(session.getAttribute("userEmail")==null){
    response.sendRedirect("userLogin.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Dashboard - LibraryMS</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:'Inter','Segoe UI',sans-serif;
    background:#f0f4ff;
    color:#1e293b;
    min-height:100vh;

    display:flex;
    flex-direction:column;
}

nav{
    height:66px;
    background:#0f172a;
    padding:0 60px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logo{
    font-size:22px;
    font-weight:700;
    color:#fff;
}

.logo span{
    color:#3b82f6;
}

.logout{
    background:#dc2626;
    color:#fff;
    text-decoration:none;
    padding:8px 16px;
    border-radius:8px;
    transition:.3s;
}

.logout:hover{
    background:#b91c1c;
}

.page{
    flex:1;
    width:100%;
    max-width:1200px;
    margin:40px auto;
    padding:0 25px;
}

.welcome{
    background:#fff;
    border-radius:18px;
    padding:28px;
    box-shadow:0 8px 25px rgba(0,0,0,.06);
    margin-bottom:30px;
}

.welcome h1{
    font-size:32px;
    margin-bottom:8px;
}

.welcome p{
    color:#64748b;
}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:24px;
}

.card{
    text-decoration:none;
    background:#fff;
    border:1px solid #e2e8f0;
    border-radius:18px;
    padding:28px;
    color:#1e293b;
    box-shadow:0 8px 25px rgba(0,0,0,.06);
    transition:.25s;
}

.card:hover{
    transform:translateY(-6px);
}

.icon{
    font-size:38px;
    margin-bottom:14px;
}

.card h2{
    font-size:22px;
    margin-bottom:8px;
}

.card p{
    color:#64748b;
    line-height:1.6;
    font-size:14px;
}

footer{
    background:#0f172a;
    color:#94a3b8;
    text-align:center;
    padding:20px;
    font-size:13px;
    margin-top:auto;
}

</style>

</head>

<body>

<nav>
    <div class="logo">Library<span>MS</span></div>

    <a href="logout" class="logout">
        Logout
    </a>
</nav>

<div class="page">

    <div class="welcome">
        <h1>User Dashboard</h1>

        <p>
            Welcome,
            <strong><%=session.getAttribute("userEmail")%></strong>
        </p>
    </div>

    <div class="grid">

        <a href="viewBooks" class="card">
            <div class="icon">📚</div>
            <h2>View Books</h2>
            <p>Browse all books available in the library.</p>
        </a>

        <a href="viewIssuedBooks" class="card">
            <div class="icon">📖</div>
            <h2>My Borrowed Books</h2>
            <p>View all books currently issued to you.</p>
        </a>

        <a href="logout" class="card">
            <div class="icon">🚪</div>
            <h2>Logout</h2>
            <p>Securely sign out of your account.</p>
        </a>

    </div>

</div>

<footer>
    © 2026 Integrated Library Management System · Java · JSP · Servlets · JDBC · MySQL
</footer>

</body>
</html>