<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Issued Successfully</title>

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
    box-shadow:0 4px 12px rgba(0,0,0,0.15);
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

/* Success Card */

.card{
    background:white;
    width:100%;
    max-width:520px;
    padding:45px 35px;
    border-radius:18px;
    text-align:center;
    box-shadow:0 12px 30px rgba(0,0,0,.12);
}

.success-icon{
    width:90px;
    height:90px;
    margin:0 auto 20px;
    background:#16a34a;
    color:white;
    border-radius:50%;
    display:flex;
    justify-content:center;
    align-items:center;
    font-size:45px;
    font-weight:bold;
}

.card h2{
    color:#16a34a;
    margin-bottom:15px;
    font-size:30px;
}

.card p{
    color:#555;
    font-size:17px;
    margin-bottom:35px;
    line-height:1.6;
}

/* Buttons */

.buttons{
    display:flex;
    justify-content:center;
    gap:15px;
    flex-wrap:wrap;
}

.btn{
    text-decoration:none;
    padding:14px 24px;
    border-radius:10px;
    color:white;
    font-weight:bold;
    transition:.3s;
}

.issue-btn{
    background:#2563eb;
}

.issue-btn:hover{
    background:#1d4ed8;
    transform:translateY(-2px);
}

.dashboard-btn{
    background:#16a34a;
}

.dashboard-btn:hover{
    background:#15803d;
    transform:translateY(-2px);
}

/* Footer */

footer{
    background:#111827;
    color:#d1d5db;
    text-align:center;
    padding:18px;
    font-size:15px;
}

/* Responsive */

@media(max-width:600px){

.card{
    padding:35px 25px;
}

.card h2{
    font-size:26px;
}

.buttons{
    flex-direction:column;
}

.btn{
    width:100%;
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

        <div class="success-icon">
            
        </div>

        <h2>Book Issued Successfully!</h2>

        <p>
            The selected book has been issued successfully and the transaction has been recorded in the library system.
        </p>

        <div class="buttons">

            <a href="issueBook.jsp" class="btn issue-btn">
                 Issue Another Book
            </a>

            <a href="dashboard.jsp" class="btn dashboard-btn">
                Go to Dashboard
            </a>

        </div>

    </div>

</div>

<footer>
    © 2026 Integrated Library Management System | L&T EduTech Project
</footer>

</body>
</html>