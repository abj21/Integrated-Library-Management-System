<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.dao.BookDao" %>
<%@ page import="com.library.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.model.User" %>
<%
    BookDao bookDao = new BookDao();
    UserDao userDao = new UserDao();

    int totalBooks  = bookDao.getTotalBooks();
    int issuedBooks = bookDao.getIssuedBooksCount();

    List<User> allUsers = userDao.getAllUsers();
    int activeUsers = 0;
    for (User u : allUsers) {
        if ("Approved".equalsIgnoreCase(u.getStatus())) activeUsers++;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Integrated Library Management System</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

body {
  font-family: 'Inter', 'Segoe UI', sans-serif;
  background: #f0f4ff;
  color: #1e293b;
  min-height: 100vh;
}

/* ── Nav ── */
nav {
  background: #0f172a;
  padding: 0 60px;
  height: 66px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: sticky;
  top: 0;
  z-index: 100;
  box-shadow: 0 1px 0 rgba(255,255,255,0.05);
}
.logo { font-size: 22px; font-weight: 700; color: #fff; letter-spacing: -0.3px; }
.logo span { color: #3b82f6; }
nav ul { list-style: none; display: flex; gap: 32px; }
nav ul a { text-decoration: none; color: #94a3b8; font-size: 14px; font-weight: 500; transition: color .2s; }
nav ul a:hover { color: #fff; }

/* ── Hero ── */
.hero-section {
  max-width: 1200px;
  margin: 0 auto;
  padding: 64px 40px 48px;
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: stretch; /* both columns same height */
}

/* ── Left ── */
.hero-left {
  display: flex;
  flex-direction: column;
}
.eyebrow {
  font-size: 11px;
  font-weight: 600;
  letter-spacing: 2.5px;
  text-transform: uppercase;
  color: #3b82f6;
  margin-bottom: 16px;
}
.hero-left h1 {
  font-size: 46px;
  font-weight: 700;
  line-height: 1.1;
  letter-spacing: -1px;
  color: #0f172a;
  margin-bottom: 16px;
}
.hero-left h1 span { color: #2563eb; }
.hero-left > p {
  font-size: 15px;
  line-height: 1.75;
  color: #64748b;
  margin-bottom: 32px;
  max-width: 420px;
}

/* ── Login cards ── */
.cards {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
  flex: 1; /* fill remaining left-column height */
}
.card {
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  padding: 24px 20px;
  display: flex;
  flex-direction: column;
  transition: transform .25s, box-shadow .25s, border-color .25s;
}
.card:hover { transform: translateY(-4px); box-shadow: 0 16px 40px rgba(0,0,0,.09); }
.card.admin-card:hover { border-color: #93c5fd; }
.card.user-card:hover  { border-color: #6ee7b7; }

/* SVG icon wrapper */
.card-icon {
  width: 40px; height: 40px;
  border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  margin-bottom: 14px;
  flex-shrink: 0;
}
.card.admin-card .card-icon { background: #eff6ff; }
.card.user-card  .card-icon { background: #f0fdf4; }
.card-icon svg { width: 20px; height: 20px; }

.card h2   { font-size: 15px; font-weight: 600; margin-bottom: 8px; color: #0f172a; }
.card p    { font-size: 13px; line-height: 1.6; color: #64748b; margin-bottom: 20px; flex: 1; }

.btn {
  display: block;
  text-align: center;
  padding: 11px 16px;
  border-radius: 10px;
  text-decoration: none;
  color: #fff;
  font-size: 13px;
  font-weight: 600;
  letter-spacing: 0.2px;
  transition: opacity .2s, transform .15s;
  margin-top: auto;
}
.btn:hover { opacity: 0.88; transform: scale(0.98); }
.btn-admin { background: linear-gradient(135deg, #2563eb, #1d4ed8); }
.btn-user  { background: linear-gradient(135deg, #16a34a, #15803d); }

/* ── Right image ── */
.hero-right {
  position: relative;
  min-height: 400px;
}
.hero-right img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 20px;
  display: block;
  box-shadow: 0 24px 60px rgba(0,0,0,.15);
  position: absolute;
  inset: 0;
}
.hero-right::after {
  content: '';
  position: absolute;
  inset: 0;
  border-radius: 20px;
  background: linear-gradient(160deg, rgba(37,99,235,0.1) 0%, transparent 50%);
  pointer-events: none;
  z-index: 1;
}

/* ── Stats strip ── */
.stats-section {
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 40px 64px;
}
.stats-inner {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  background: #fff;
  overflow: hidden;
  box-shadow: 0 4px 24px rgba(0,0,0,.05);
}
.stat {
  padding: 30px 32px;
  border-right: 1px solid #e2e8f0;
  display: flex;
  align-items: center;
  gap: 16px;
}
.stat:last-child { border-right: none; }

.stat-icon {
  width: 44px; height: 44px;
  border-radius: 12px;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.stat-icon svg { width: 22px; height: 22px; }
.stat-icon.blue  { background: #eff6ff; }
.stat-icon.green { background: #f0fdf4; }
.stat-icon.amber { background: #fffbeb; }

.stat-text {}
.stat-num {
  font-size: 32px;
  font-weight: 700;
  letter-spacing: -1px;
  line-height: 1;
}
.stat-num.blue  { color: #2563eb; }
.stat-num.green { color: #16a34a; }
.stat-num.amber { color: #d97706; }
.stat-label {
  font-size: 12px;
  color: #64748b;
  margin-top: 4px;
  font-weight: 500;
}

/* ── Footer ── */
footer {
  background: #0f172a;
  color: #475569;
  text-align: center;
  padding: 22px 40px;
  font-size: 13px;
}
footer span { color: #64748b; }

/* ── Responsive ── */
@media (max-width: 900px) {
  nav { padding: 0 24px; }
  nav ul { display: none; }
  .hero-section { grid-template-columns: 1fr; padding: 40px 24px 32px; gap: 32px; align-items: start; }
  .hero-left h1 { font-size: 34px; }
  .hero-right { min-height: 240px; }
  .hero-right img { position: static; height: 240px; }
  .stats-inner { grid-template-columns: 1fr; }
  .stat { border-right: none; border-bottom: 1px solid #e2e8f0; }
  .stat:last-child { border-bottom: none; }
  .stats-section { padding: 0 24px 48px; }
}
</style>
</head>
<body>

<nav>
  <div class="logo">Library<span>MS</span></div>
  <ul>
    <li><a href="#">Home</a></li>
    <li><a href="#">About</a></li>
    <li><a href="#">Contact</a></li>
  </ul>
</nav>

<section class="hero-section">
  <!-- Left -->
  <div class="hero-left">
    <div class="eyebrow">Welcome</div>
    <h1>Integrated <span>Library</span><br>Management System</h1>
    <p>A modern solution for managing books, users and borrowing activities.
       Please choose your login portal below.</p>

    <div class="cards">
      <!-- Admin card -->
      <div class="card admin-card">
        <div class="card-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/>
            <rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/>
          </svg>
        </div>
        <h2>Admin Login</h2>
        <p>Manage books, users, issue and return books, and generate reports.</p>
        <a href="login.jsp" class="btn btn-admin">Admin Login</a>
      </div>

      <!-- User card -->
      <div class="card user-card">
        <div class="card-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
          </svg>
        </div>
        <h2>User Login</h2>
        <p>Browse books, search the catalog and view your borrowed books.</p>
        <a href="userLogin.jsp" class="btn btn-user">User Login</a>
      </div>
    </div>
  </div>

  <!-- Right image — fills exact same height as left column -->
  <div class="hero-right">
    <img src="library.jpeg" alt="Library">
  </div>
</section>

<!-- Live stats from DB -->
<div class="stats-section">
  <div class="stats-inner">
    <div class="stat">
      <div class="stat-icon blue">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
        </svg>
      </div>
      <div class="stat-text">
        <div class="stat-num blue"><%= totalBooks %></div>
        <div class="stat-label">Books in Collection</div>
      </div>
    </div>

    <div class="stat">
      <div class="stat-icon green">
        <svg viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
          <circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
      </div>
      <div class="stat-text">
        <div class="stat-num green"><%= activeUsers %></div>
        <div class="stat-label">Active Members</div>
      </div>
    </div>

    <div class="stat">
      <div class="stat-icon amber">
        <svg viewBox="0 0 24 24" fill="none" stroke="#d97706" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 11 12 14 22 4"/>
          <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/>
        </svg>
      </div>
      <div class="stat-text">
        <div class="stat-num amber"><%= issuedBooks %></div>
        <div class="stat-label">Books Currently Issued</div>
      </div>
    </div>
  </div>
</div>

<footer>
  <p>© 2026 Integrated Library Management System &nbsp;·&nbsp;
     <span>Java</span> &nbsp;·&nbsp; <span>JSP</span> &nbsp;·&nbsp;
     <span>Servlets</span> &nbsp;·&nbsp; <span>JDBC</span> &nbsp;·&nbsp; <span>MySQL</span>
  </p>
</footer>

</body>
</html>
