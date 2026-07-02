<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Book — LibraryMS</title>
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

/* ── Nav ── */
nav {
  background: #0f172a;
  padding: 0 60px;
  height: 66px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  position: sticky; top: 0; z-index: 100;
  box-shadow: 0 1px 0 rgba(255,255,255,0.05);
}
.logo { font-size: 22px; font-weight: 700; color: #fff; letter-spacing: -0.3px; }
.logo span { color: #3b82f6; }
.nav-right { display: flex; align-items: center; gap: 20px; }
.nav-right span { font-size: 13px; color: #94a3b8; }
.nav-right strong { color: #e2e8f0; }
.logout-btn {
  font-size: 13px; font-weight: 600;
  padding: 7px 16px; border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.12);
  color: #cbd5e1; text-decoration: none;
  background: rgba(255,255,255,0.05);
  transition: background .2s, color .2s;
}
.logout-btn:hover { background: rgba(239,68,68,0.15); color: #fca5a5; border-color: rgba(239,68,68,0.3); }

/* ── Page ── */
.page {
  flex: 1;
  max-width: 640px;
  width: 100%;
  margin: 0 auto;
  padding: 52px 40px 64px;
}

/* breadcrumb */
.breadcrumb {
  display: flex; align-items: center; gap: 6px;
  font-size: 13px; color: #64748b;
  margin-bottom: 28px;
}
.breadcrumb a { color: #64748b; text-decoration: none; transition: color .2s; }
.breadcrumb a:hover { color: #2563eb; }
.breadcrumb svg { width: 12px; height: 12px; }

.page-header { margin-bottom: 32px; }
.page-header h1 { font-size: 26px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; }
.page-header p  { font-size: 14px; color: #64748b; margin-top: 4px; }

/* ── Card ── */
.form-card {
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  padding: 36px;
  box-shadow: 0 4px 20px rgba(0,0,0,.06);
}

.form-group { margin-bottom: 22px; }
.form-group:last-of-type { margin-bottom: 0; }

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

.form-hint { font-size: 12px; color: #94a3b8; margin-top: 5px; }

.form-divider {
  border: none;
  border-top: 1px solid #f1f5f9;
  margin: 28px 0;
}

.form-actions { display: flex; gap: 12px; align-items: center; }

.btn-submit {
  flex: 1;
  padding: 12px 20px;
  background: linear-gradient(135deg, #2563eb, #1d4ed8);
  color: #fff;
  font-size: 14px; font-weight: 600;
  border: none; border-radius: 10px;
  cursor: pointer; font-family: inherit;
  letter-spacing: 0.2px;
  transition: opacity .2s, transform .15s;
}
.btn-submit:hover { opacity: 0.9; transform: scale(0.99); }

.btn-cancel {
  padding: 12px 20px;
  background: transparent;
  color: #64748b;
  font-size: 14px; font-weight: 500;
  border: 1px solid #e2e8f0;
  border-radius: 10px;
  cursor: pointer; font-family: inherit;
  text-decoration: none;
  transition: border-color .2s, color .2s;
  white-space: nowrap;
}
.btn-cancel:hover { border-color: #94a3b8; color: #374151; }

/* success / error banner */
.banner {
  display: flex; align-items: center; gap: 10px;
  padding: 12px 16px; border-radius: 10px;
  font-size: 13px; font-weight: 500;
  margin-bottom: 24px;
}
.banner.success { background: #f0fdf4; border: 1px solid #bbf7d0; color: #15803d; }
.banner.error   { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }
.banner svg { width: 16px; height: 16px; flex-shrink: 0; }

/* ── Footer ── */
footer {
  background: #0f172a; color: #475569;
  text-align: center; padding: 22px 40px; font-size: 13px;
}
footer span { color: #64748b; }

@media (max-width: 640px) {
  nav { padding: 0 20px; }
  .nav-right span { display: none; }
  .page { padding: 32px 20px 48px; }
  .form-card { padding: 24px 20px; }
}
</style>
</head>
<body>

<nav>
  <div class="logo">Library<span>MS</span></div>
  <div class="nav-right">
    <span>Signed in as <strong>Admin</strong></span>
    <a href="logout" class="logout-btn">Logout</a>
  </div>
</nav>

<div class="page">

  <!-- Breadcrumb -->
  <div class="breadcrumb">
    <a href="dashboard.jsp">Dashboard</a>
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
    <span>Add Book</span>
  </div>

  <div class="page-header">
    <h1>Add New Book</h1>
    <p>Fill in the details below to add a book to the catalog.</p>
  </div>

  <%-- Success / error messages --%>
  <% if ("success".equals(request.getParameter("status"))) { %>
    <div class="banner success">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>
      Book added successfully!
    </div>
  <% } %>
  <% if (request.getAttribute("error") != null) { %>
    <div class="banner error">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
      <%= request.getAttribute("error") %>
    </div>
  <% } %>

  <div class="form-card">
    <form action="addBook" method="post">

      <div class="form-group">
        <label for="title">Book Title</label>
        <input type="text" id="title" name="title" placeholder="e.g. The Great Gatsby" required>
      </div>

      <div class="form-group">
        <label for="author">Author</label>
        <input type="text" id="author" name="author" placeholder="e.g. F. Scott Fitzgerald" required>
      </div>

      <div class="form-group">
        <label for="quantity">Quantity</label>
        <input type="number" id="quantity" name="quantity" placeholder="e.g. 5" min="1" required>
        <div class="form-hint">Number of copies available in the library.</div>
      </div>

      <hr class="form-divider">

      <div class="form-actions">
        <a href="dashboard.jsp" class="btn-cancel">Cancel</a>
        <button type="submit" class="btn-submit">Add Book to Catalog →</button>
      </div>

    </form>
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
