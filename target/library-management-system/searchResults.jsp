<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Book" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,Helvetica,sans-serif;
}

body{
    background:#eef3fb;
    min-height:100vh;
    display:flex;
    flex-direction:column;
}

/* Navbar */

nav{
    background:#111827;
    color:white;
    padding:18px 60px;
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.logo{
    font-size:30px;
    font-weight:bold;
}

.logo span{
    color:#2563eb;
}

.back{
    color:white;
    text-decoration:none;
    background:#374151;
    padding:10px 22px;
    border-radius:10px;
    font-weight:bold;
    transition:.3s;
}

.back:hover{
    background:#4b5563;
}

/* Container */

.container{
    width:90%;
    max-width:1100px;
    margin:50px auto;
    flex:1;
}

/* Card */

.card{
    background:white;
    padding:35px;
    border-radius:18px;
    box-shadow:0 8px 25px rgba(0,0,0,.10);
}

h2{
    text-align:center;
    margin-bottom:30px;
    color:#1e293b;
    font-size:40px;
}

/* Table */

table{
    width:100%;
    border-collapse:collapse;
    overflow:hidden;
    border-radius:12px;
}

th{
    background:#2563eb;
    color:white;
    padding:15px;
    font-size:17px;
}

td{
    padding:15px;
    text-align:center;
    border-bottom:1px solid #e5e7eb;
    font-size:16px;
}

tr:hover{
    background:#f8fafc;
}

/* No Result */

.message{
    text-align:center;
    color:#ef4444;
    font-size:22px;
    margin:40px 0;
    font-weight:bold;
}

/* Buttons */

.buttons{
    text-align:center;
    margin-top:35px;
}

.btn{
    display:inline-block;
    padding:13px 30px;
    margin:0 10px;
    border-radius:10px;
    color:white;
    text-decoration:none;
    font-weight:bold;
    transition:.3s;
}

.search{
    background:#16a34a;
}

.search:hover{
    background:#15803d;
}

.dashboard{
    background:#2563eb;
}

.dashboard:hover{
    background:#1d4ed8;
}

/* Footer */

footer{
    background:#111827;
    color:#d1d5db;
    text-align:center;
    padding:18px;
    margin-top:auto;
    font-size:15px;
}

</style>

</head>

<body>

<nav>

<div class="logo">
Library<span>MS</span>
</div>

<a href="dashboard.jsp" class="back">
Dashboard
</a>

</nav>

<div class="container">

<div class="card">

<h2>Search Results</h2>

<%

List<Book> books = (List<Book>)request.getAttribute("books");

if(books != null && !books.isEmpty()){

%>

<table>

<tr>
<th>Book ID</th>
<th>Book Title</th>
<th>Author</th>
<th>Quantity</th>
</tr>

<%

for(Book book : books){

%>

<tr>

<td><%=book.getId()%></td>
<td><%=book.getTitle()%></td>
<td><%=book.getAuthor()%></td>
<td><%=book.getQuantity()%></td>

</tr>

<%

}

%>

</table>

<%

}else{

%>

<p class="message">
No books found.
</p>

<%

}

%>

<div class="buttons">

<a href="searchBook.jsp" class="btn search">
Search Again
</a>

<a href="dashboard.jsp" class="btn dashboard">
Back to Dashboard
</a>

</div>

</div>

</div>
<footer>
    &copy; 2026 Integrated Library Management System |
    Java |
    JSP |
    Servlets |
    JDBC |
    MySQL
</footer>



</body>
</html>