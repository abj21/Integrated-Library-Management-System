<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login — LibraryMS</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }

body {
  font-family: 'Inter', 'Segoe UI', sans-serif;
  background: #f0f4ff;
  color: #1e293b;
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

/* ── Nav (identical to index) ── */
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

/* ── Main centered layout ── */
.page-body {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 48px 24px;
}

.login-wrapper {
  display: grid;
  grid-template-columns: 1fr 1fr;
  width: 100%;
  max-width: 900px;
  background: #fff;
  border-radius: 20px;
  overflow: hidden;
  border: 1px solid #e2e8f0;
  box-shadow: 0 20px 60px rgba(0,0,0,.1);
  min-height: 500px;
}

/* ── Left panel (brand side) ── */
.login-left {
  background: linear-gradient(160deg, #1e3a8a 0%, #1d4ed8 60%, #2563eb 100%);
  padding: 52px 44px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  position: relative;
  overflow: hidden;
}
.login-left::before {
  content: '';
  position: absolute;
  width: 300px; height: 300px;
  border-radius: 50%;
  background: rgba(255,255,255,0.05);
  top: -80px; right: -80px;
}
.login-left::after {
  content: '';
  position: absolute;
  width: 200px; height: 200px;
  border-radius: 50%;
  background: rgba(255,255,255,0.04);
  bottom: -60px; left: -40px;
}

.left-logo { font-size: 20px; font-weight: 700; color: #fff; letter-spacing: -0.3px; position: relative; z-index: 1; }
.left-logo span { color: #93c5fd; }

.left-content { position: relative; z-index: 1; }
.left-content h2 {
  font-size: 28px; font-weight: 700;
  color: #fff; line-height: 1.2;
  margin-bottom: 12px; letter-spacing: -0.5px;
}
.left-content p { font-size: 14px; color: #bfdbfe; line-height: 1.7; }

.left-features { position: relative; z-index: 1; }
.feature {
  display: flex; align-items: center; gap: 10px;
  margin-bottom: 12px;
}
.feature:last-child { margin-bottom: 0; }
.feature-dot {
  width: 6px; height: 6px;
  border-radius: 50%;
  background: #93c5fd;
  flex-shrink: 0;
}
.feature span { font-size: 13px; color: #bfdbfe; }

/* ── Right panel (form side) ── */
.login-right {
  padding: 52px 44px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.back-link {
  display: inline-flex; align-items: center; gap: 6px;
  font-size: 13px; color: #64748b; text-decoration: none;
  margin-bottom: 36px; font-weight: 500;
  transition: color .2s;
}
.back-link:hover { color: #2563eb; }
.back-link svg { width: 14px; height: 14px; }

.form-header { margin-bottom: 32px; }
.form-header h1 { font-size: 24px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; margin-bottom: 6px; }
.form-header p  { font-size: 14px; color: #64748b; }

.form-group { margin-bottom: 20px; }
.form-group label {
  display: block;
  font-size: 13px; font-weight: 600;
  color: #374151; margin-bottom: 7px;
}
.form-group input {
  width: 100%;
  padding: 11px 14px;
  border: 1px solid #d1d5db;
  border-radius: 10px;
  font-size: 14px;
  font-family: inherit;
  color: #0f172a;
  background: #f9fafb;
  transition: border-color .2s, box-shadow .2s, background .2s;
  outline: none;
}
.form-group input:focus {
  border-color: #2563eb;
  background: #fff;
  box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
}
.form-group input::placeholder { color: #9ca3af; }

.submit-btn {
  width: 100%;
  padding: 12px;
  background: linear-gradient(135deg, #2563eb, #1d4ed8);
  color: #fff;
  font-size: 14px;
  font-weight: 600;
  border: none;
  border-radius: 10px;
  cursor: pointer;
  font-family: inherit;
  letter-spacing: 0.2px;
  transition: opacity .2s, transform .15s;
  margin-top: 8px;
}
.submit-btn:hover { opacity: 0.9; transform: scale(0.99); }

/* error message if any */
.error-msg {
  background: #fef2f2;
  border: 1px solid #fecaca;
  color: #dc2626;
  font-size: 13px;
  padding: 10px 14px;
  border-radius: 10px;
  margin-bottom: 20px;
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

@media (max-width: 700px) {
  nav { padding: 0 24px; }
  nav ul { display: none; }
  .login-wrapper { grid-template-columns: 1fr; }
  .login-left { display: none; }
  .login-right { padding: 36px 28px; }
}
</style>
</head>
<body>

<nav>
  <div class="logo">Library<span>MS</span></div>
  <ul>
    <li><a href="index.jsp">Home</a></li>
    <li><a href="#">About</a></li>
    <li><a href="#">Contact</a></li>
  </ul>
</nav>

<div class="page-body">
  <div class="login-wrapper">

    <!-- Left brand panel -->
    <div class="login-left">
      <div class="left-logo">Library<span>MS</span></div>

      <div class="left-content">
        <h2>Admin Control Panel</h2>
        <p>Sign in to manage your library system — books, users, and borrowing activities.</p>
      </div>

      <div class="left-features">
        <div class="feature"><div class="feature-dot"></div><span>Manage book inventory</span></div>
        <div class="feature"><div class="feature-dot"></div><span>Issue &amp; return books</span></div>
        <div class="feature"><div class="feature-dot"></div><span>Approve user accounts</span></div>
        <div class="feature"><div class="feature-dot"></div><span>Generate reports</span></div>
      </div>
    </div>

    <!-- Right form panel -->
    <div class="login-right">
      <a href="index.jsp" class="back-link">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"/>
        </svg>
        Back to Home
      </a>

      <div class="form-header">
        <h1>Welcome back</h1>
        <p>Sign in to your admin account</p>
      </div>

      <%-- Show error if login failed --%>
      <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg"><%= request.getAttribute("error") %></div>
      <% } %>

      <form action="login" method="post">
        <div class="form-group">
          <label for="email">Email address</label>
          <input type="email" id="email" name="email" placeholder="admin@library.com" required>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" placeholder="Enter your password" required>
        </div>
        <button type="submit" class="submit-btn">Sign in to Dashboard →</button>
      </form>
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
