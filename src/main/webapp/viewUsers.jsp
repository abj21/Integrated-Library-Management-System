<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Users - LibraryMS</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:'Inter','Segoe UI',sans-serif;background:#f0f4ff;color:#1e293b;min-height:100vh;display:flex;flex-direction:column}
nav{height:66px;background:#0f172a;padding:0 60px;display:flex;justify-content:space-between;align-items:center}
.logo{font-size:22px;font-weight:700;color:#fff}.logo span{color:#3b82f6}
.logout{padding:8px 16px;background:rgba(255,255,255,.06);border-radius:8px;color:#fff;text-decoration:none}
.page{flex:1;max-width:1100px;width:100%;margin:auto;padding:45px 30px}
.breadcrumb{font-size:13px;color:#64748b;margin-bottom:20px}
.breadcrumb a{text-decoration:none;color:#64748b}
.header{display:flex;justify-content:space-between;align-items:center;margin-bottom:22px}
.header h1{font-size:28px}
.card{background:#fff;border:1px solid #e2e8f0;border-radius:16px;overflow:hidden;box-shadow:0 5px 20px rgba(0,0,0,.06)}
.toolbar{padding:16px;border-bottom:1px solid #eef2f7;display:flex;justify-content:space-between;align-items:center}
.toolbar input{padding:10px 14px;border:1px solid #dbe2ea;border-radius:8px;width:260px}
.count{font-size:13px;color:#64748b}
table{width:100%;border-collapse:collapse}
th{background:#f8fafc;color:#64748b;text-transform:uppercase;font-size:12px;padding:14px;text-align:left}
td{padding:14px;border-top:1px solid #eef2f7}
tr:hover{background:#f8fafc}
.badge{padding:5px 10px;border-radius:20px;font-size:12px;font-weight:600}
.approved{background:#dcfce7;color:#15803d}
.pending{background:#fef3c7;color:#b45309}
.action-btn{background:#16a34a;color:#fff;text-decoration:none;padding:8px 14px;border-radius:8px;font-size:13px;font-weight:600}
.back{display:inline-block;margin-top:20px;text-decoration:none;color:#2563eb;font-weight:600}
footer{background:#0f172a;color:#94a3b8;text-align:center;padding:20px;font-size:13px}
</style>
</head>
<body>
<nav><div class="logo">Library<span>MS</span></div><a class="logout" href="logout">Logout</a></nav>
<div class="page">
<div class="breadcrumb"><a href="dashboard.jsp">Dashboard</a> &gt; View Users</div>
<div class="header"><h1>Registered Users</h1></div>
<div class="card">
<div class="toolbar">
<input type="text" id="search" placeholder="Search users..." onkeyup="filterUsers()">
<span class="count" id="count"><%= request.getAttribute("users")!=null?((java.util.List)request.getAttribute("users")).size():0 %> Users</span>
</div>
<table id="userTable">
<thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Status</th><th>Action</th></tr></thead>
<tbody>
<%
List<User> users=(List<User>)request.getAttribute("users");
if(users!=null){
for(User user:users){
%>
<tr>
<td>#<%=user.getId()%></td>
<td><%=user.getName()%></td>
<td><%=user.getEmail()%></td>
<td>
<% if("Approved".equalsIgnoreCase(user.getStatus())){ %>
<span class="badge approved">Approved</span>
<% } else { %>
<span class="badge pending">Pending</span>
<% } %>
</td>
<td>
<% if("Pending".equalsIgnoreCase(user.getStatus())){ %>
<a class="action-btn" href="approveUser?id=<%=user.getId()%>">Approve</a>
<% } else { %>
&mdash; 
<% } %>
</td>
</tr>
<% }} %>
</tbody>
</table>
</div>
<a class="back" href="dashboard.jsp">&larr; Back to Dashboard</a>
</div>
<footer>&copy; 2026 Integrated Library Management System &middot; Java &middot; JSP &middot; Servlets &middot; JDBC &middot; MySQL</footer>
<script>
function filterUsers(){
let q=document.getElementById('search').value.toLowerCase();
let rows=document.querySelectorAll('#userTable tbody tr');let c=0;
rows.forEach(r=>{let ok=r.innerText.toLowerCase().includes(q);r.style.display=ok?'':'none';if(ok)c++;});
document.getElementById('count').textContent=c+" Users";
}
</script>
</body>
</html>
