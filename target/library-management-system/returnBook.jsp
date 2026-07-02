<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Return Book</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{
    background:#eef3fb;
    display:flex;
    flex-direction:column;
    min-height:100vh;
}

/* Navbar */

.navbar{
    background:#111827;
    color:white;
    padding:18px 8%;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 4px 12px rgba(0,0,0,.15);
}

.logo{
    font-size:24px;
    font-weight:bold;
}

/* Main */

.main{
    flex:1;
    display:flex;
    justify-content:center;
    align-items:center;
    padding:40px 20px;
}

/* Card */

.card{
    background:white;
    width:100%;
    max-width:500px;
    padding:40px;
    border-radius:18px;
    box-shadow:0 12px 30px rgba(0,0,0,.12);
    animation:fadeIn .5s ease;
}

.card h2{
    text-align:center;
    color:#2563eb;
    margin-bottom:30px;
    font-size:30px;
}

label{
    display:block;
    margin-bottom:10px;
    color:#374151;
    font-weight:bold;
}

input[type=number]{
    width:100%;
    padding:14px;
    border:1px solid #d1d5db;
    border-radius:10px;
    font-size:16px;
    outline:none;
    transition:.3s;
}

input[type=number]:focus{
    border-color:#2563eb;
    box-shadow:0 0 0 4px rgba(37,99,235,.15);
}

.btn{
    width:100%;
    margin-top:25px;
    padding:14px;
    border:none;
    border-radius:10px;
    background:#16a34a;
    color:white;
    font-size:16px;
    font-weight:bold;
    cursor:pointer;
    transition:.3s;
}

.btn:hover{
    background:#15803d;
    transform:translateY(-2px);
}

.back{
    display:block;
    margin-top:20px;
    text-align:center;
    color:#2563eb;
    text-decoration:none;
    font-weight:bold;
}

.back:hover{
    text-decoration:underline;
}

/* Footer */

footer{
    background:#111827;
    color:#d1d5db;
    text-align:center;
    padding:18px;
    font-size:15px;
}

/* Animation */

@keyframes fadeIn{

from{
opacity:0;
transform:translateY(20px);
}

to{
opacity:1;
transform:translateY(0);
}

}

/* Responsive */

@media(max-width:600px){

.card{
padding:30px 25px;
}

.card h2{
font-size:26px;
}

.logo{
font-size:20px;
}

}

</style>

</head>

<body>

<div class="navbar">
    <div class="logo"> Integrated Library Management System</div>
</div>

<div class="main">

<div class="card">

<h2>Return Book</h2>

<form action="returnBook" method="post">

<label>Issue ID</label>

<input
type="number"
name="issueId"
placeholder="Enter Issue ID"
required>

<input
type="submit"
value="Return Book"
class="btn">

</form>

<a href="dashboard.jsp" class="back">
 Back to Dashboard
</a>

</div>

</div>

<footer>
© 2026 Integrated Library Management System | L&T EduTech Project
</footer>

</body>
</html>