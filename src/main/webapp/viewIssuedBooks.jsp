<%@ page import="java.util.List" %>
<%@ page import="com.library.model.IssuedBook" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    boolean isAdmin = session.getAttribute("user") != null;
    boolean isUser = session.getAttribute("userEmail") != null;

    if (!isAdmin && !isUser) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Issued Books - LibraryMS</title>

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{
    font-family:Inter,Segoe UI,sans-serif;
    background:#f0f4ff;
    display:flex;
    flex-direction:column;
    min-height:100vh;
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
    color:#fff;
    font-size:22px;
    font-weight:700;
}

.logo span{
    color:#3b82f6;
}

.logout-btn{
    text-decoration:none;
    color:#fff;
    background:#1e293b;
    padding:8px 16px;
    border-radius:8px;
}

.page{
    flex:1;
    max-width:1200px;
    width:100%;
    margin:auto;
    padding:40px;
}

.breadcrumb{
    font-size:13px;
    color:#64748b;
    margin-bottom:18px;
}

.breadcrumb a{
    text-decoration:none;
    color:#64748b;
}

input[type=text]{
    padding:10px;
    width:280px;
    border:1px solid #ddd;
    border-radius:8px;
    margin-bottom:18px;
}

.card{
    background:#fff;
    border-radius:16px;
    overflow:hidden;
    box-shadow:0 5px 20px rgba(0,0,0,.06);
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#f8fafc;
    padding:14px;
    text-align:left;
    font-size:12px;
    color:#64748b;
}

td{
    padding:14px;
    border-top:1px solid #eef2f7;
}

tr:hover{
    background:#f8fafc;
}

.badge{
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
}

.issued{
    background:#dbeafe;
    color:#2563eb;
}

.returned{
    background:#dcfce7;
    color:#15803d;
}

.fine{
    background:#fee2e2;
    color:#dc2626;
}

.fine0{
    background:#dcfce7;
    color:#15803d;
}

.return-btn{
    background:#dc2626;
    color:#fff;
    border:none;
    padding:8px 12px;
    border-radius:8px;
    cursor:pointer;
}

.return-btn:disabled{
    background:#94a3b8;
}

.back{
    display:inline-block;
    margin-top:20px;
    color:#2563eb;
    text-decoration:none;
}

.footer{
    background:#0f172a;
    color:#94a3b8;
    text-align:center;
    padding:20px;
}
</style>

</head>

<body>

<nav>
    <div class="logo">Library<span>MS</span></div>
    <a href="logout" class="logout-btn">Logout</a>
</nav>

<div class="page">

    <div class="breadcrumb">
        <a href="<%= isAdmin ? "dashboard.jsp" : "userDashboard.jsp" %>">Dashboard</a>
        &gt; Issued Books
    </div>

    <input type="text" id="search" placeholder="Search..." onkeyup="filterTable()">

    <div class="card">

        <table id="tbl">

            <thead>
            <tr>
                <th>Issue ID</th>
                <th>User ID</th>
                <th>Book ID</th>
                <th>Book</th>
                <th>Issue Date</th>
                <th>Return Date</th>
                <th>Status</th>
                <th>Fine</th>
                <th>Action</th>
            </tr>
            </thead>

            <tbody>

            <%
                List<IssuedBook> list =
                        (List<IssuedBook>)request.getAttribute("issuedBooks");

                if(list!=null){
                    for(IssuedBook book:list){
            %>

            <tr>

                <td><%=book.getIssueId()%></td>

                <td><%=book.getUserId()%></td>

                <td><%=book.getBookId()%></td>

                <td><%=book.getBookTitle()%></td>

                <td><%=book.getIssueDate()%></td>

                <td>
                    <%=book.getReturnDate()==null ? "-" : book.getReturnDate()%>
                </td>

                <td>

                    <% if("Issued".equals(book.getStatus())){ %>

                        <span class="badge issued">Issued</span>

                    <% }else{ %>

                        <span class="badge returned">Returned</span>

                    <% } %>

                </td>

                <td>

                    <% if(book.getFine()>0){ %>

                        <span class="badge fine">₹ <%=book.getFine()%></span>

                    <% }else{ %>

                        <span class="badge fine0">₹ 0</span>

                    <% } %>

                </td>

                <td>

                    <% if("Issued".equals(book.getStatus())){ %>

                    <form action="returnBook" method="post">
                        <input type="hidden"
                               name="issueId"
                               value="<%=book.getIssueId()%>">

                        <input type="submit"
                               value="Return Book"
                               class="return-btn">
                    </form>

                    <% }else{ %>

                    <input type="button"
                           value="Returned"
                           class="return-btn"
                           disabled>

                    <% } %>

                </td>

            </tr>

            <%
                    }
                }
            %>

            </tbody>

        </table>

    </div>

    <!-- FIXED -->
    <a href="<%= isAdmin ? "dashboard.jsp" : "userDashboard.jsp" %>" class="back">
        ← Back to Dashboard
    </a>

</div>

<div class="footer">
    © 2026 Integrated Library Management System · Java · JSP · Servlets · JDBC · MySQL
</div>

<script>
function filterTable() {

    let q = document.getElementById("search").value.toLowerCase();

    let rows = document.querySelectorAll("#tbl tbody tr");

    rows.forEach(function(row){

        row.style.display =
            row.innerText.toLowerCase().includes(q)
            ? ""
            : "none";

    });

}
</script>

</body>
</html>