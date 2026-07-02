<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
if(session.getAttribute("user")==null){
    response.sendRedirect("login.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Library Reports - LibraryMS</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter','Segoe UI',sans-serif;background:#f0f4ff;color:#1e293b;display:flex;flex-direction:column;min-height:100vh}
nav{height:66px;background:#0f172a;padding:0 60px;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:22px;font-weight:700;color:#fff}.logo span{color:#3b82f6}
.logout{color:#fff;text-decoration:none;background:#1e293b;padding:8px 16px;border-radius:8px}
.page{flex:1;max-width:1300px;margin:auto;width:100%;padding:45px 35px}
.breadcrumb{font-size:13px;color:#64748b;margin-bottom:18px}
.breadcrumb a{text-decoration:none;color:#64748b}
h1{font-size:34px;margin-bottom:8px}
.sub{color:#64748b;margin-bottom:30px}
.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:24px}
.card{background:#fff;border-radius:18px;padding:28px;box-shadow:0 8px 25px rgba(0,0,0,.06);border:1px solid #e2e8f0;transition:.25s}
.card:hover{transform:translateY(-6px)}
.label{font-size:14px;color:#64748b;margin-bottom:14px}
.value{font-size:34px;font-weight:700}
.blue{color:#2563eb}.green{color:#16a34a}.orange{color:#ea580c}.purple{color:#7c3aed}.red{color:#dc2626}.teal{color:#0891b2}
.back{display:inline-block;margin-top:35px;background:#2563eb;color:#fff;text-decoration:none;padding:12px 22px;border-radius:10px;font-weight:600}
footer{background:#0f172a;color:#94a3b8;text-align:center;padding:20px;font-size:13px;margin-top:40px}
</style>
</head>
<body>
<nav>
<div class="logo">Library<span>MS</span></div>
<a href="logout" class="logout">Logout</a>
</nav>

<div class="page">
<div class="breadcrumb"><a href="dashboard.jsp">Dashboard</a> &gt; Reports</div>
<h1>Library Reports</h1>
<div class="sub">Overview of your library statistics.</div>

<div class="grid">

<div class="card">
<div class="label">📚 Total Books</div>
<div class="value blue"><%=request.getAttribute("totalBooks")%></div>
</div>

<div class="card">
<div class="label">📖 Books Issued</div>
<div class="value green"><%=request.getAttribute("booksIssued")%></div>
</div>

<div class="card">
<div class="label">✅ Books Returned</div>
<div class="value orange"><%=request.getAttribute("returnedBooks")%></div>
</div>

<div class="card">
<div class="label">💰 Fine Collection</div>
<div class="value red">₹ <%=request.getAttribute("fineCollection")%></div>
</div>

<div class="card">
<div class="label">🏆 Most Borrowed Book</div>
<div class="value purple" style="font-size:22px"><%=request.getAttribute("mostBorrowedBook")%></div>
</div>

<div class="card">
<div class="label">⏰ Overdue Books</div>
<div class="value teal"><%=request.getAttribute("overdueBooks")%></div>
</div>

</div>

<a href="dashboard.jsp" class="back">Back to Dashboard</a>
</div>

<footer>© 2026 Integrated Library Management System · Java · JSP · Servlets · JDBC · MySQL</footer>
</body>
</html>
