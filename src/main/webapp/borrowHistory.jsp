<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.model.IssuedBook" %>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    List<IssuedBook> history =
            (List<IssuedBook>) request.getAttribute("history");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Borrow History</title>

<style>

body{
    font-family: Arial, sans-serif;
    background:#f4f4f4;
    margin:0;
    padding:20px;
}

h1{
    text-align:center;
    color:#333;
}

table{
    width:95%;
    margin:20px auto;
    border-collapse:collapse;
    background:white;
}

th, td{
    border:1px solid #ddd;
    padding:12px;
    text-align:center;
}

th{
    background:#007BFF;
    color:white;
}

tr:nth-child(even){
    background:#f2f2f2;
}

tr:hover{
    background:#e8f4ff;
}

.back-btn{
    display:block;
    width:180px;
    margin:30px auto;
    text-align:center;
    background:#28a745;
    color:white;
    padding:12px;
    text-decoration:none;
    border-radius:5px;
}

.back-btn:hover{
    background:#218838;
}

.no-data{
    text-align:center;
    color:red;
    font-size:18px;
    margin-top:30px;
}

</style>

</head>

<body>

<h1>Borrow History</h1>

<%
if(history != null && !history.isEmpty()){
%>

<table>

<tr>
    <th>Issue ID</th>
    <th>User ID</th>
    <th>Book ID</th>
    <th>Book Title</th>
    <th>Issue Date</th>
    <th>Return Date</th>
    <th>Status</th>
    <th>Fine (₹)</th>
</tr>

<%
for(IssuedBook book : history){
%>

<tr>

<td><%= book.getIssueId() %></td>

<td><%= book.getUserId() %></td>

<td><%= book.getBookId() %></td>

<td><%= book.getBookTitle() %></td>

<td><%= book.getIssueDate() %></td>

<td><%= book.getReturnDate() %></td>

<td><%= book.getStatus() %></td>

<td><%= book.getFine() %></td>

</tr>

<%
}
%>

</table>

<%
}else{
%>

<p class="no-data">No Borrow History Found.</p>

<%
}
%>

<a href="dashboard.jsp" class="back-btn">Back to Dashboard</a>

</body>
</html>