<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Added Successfully</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,Helvetica,sans-serif;
}

body{
    background:#eef3fb;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.card{
    width:500px;
    background:#fff;
    padding:40px;
    border-radius:18px;
    text-align:center;
    box-shadow:0 10px 30px rgba(0,0,0,.15);
}

.icon{
    width:90px;
    height:90px;
    background:#22c55e;
    color:#fff;
    font-size:50px;
    border-radius:50%;
    display:flex;
    justify-content:center;
    align-items:center;
    margin:auto;
    margin-bottom:20px;
}

h1{
    color:#1e293b;
    margin-bottom:15px;
}

p{
    color:#64748b;
    margin-bottom:35px;
    font-size:17px;
}

.buttons{
    display:flex;
    gap:15px;
    justify-content:center;
}

.btn{
    text-decoration:none;
    padding:12px 28px;
    border-radius:10px;
    color:white;
    font-weight:bold;
    transition:.3s;
}

.green{
    background:#16a34a;
}

.green:hover{
    background:#15803d;
}

.blue{
    background:#2563eb;
}

.blue:hover{
    background:#1d4ed8;
}

</style>

</head>
<body>

<div class="card">

<div class="icon">
✓
</div>

<h1>Book Added Successfully!</h1>

<p>
The new book has been added to the library database successfully.
</p>

<div class="buttons">

<a href="addBook.jsp" class="btn green">
Add Another Book
</a>

<a href="dashboard.jsp" class="btn blue">
Back to Dashboard
</a>

</div>

</div>

</body>
</html>