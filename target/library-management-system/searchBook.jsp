<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Book" %>
<%
    boolean isAdmin = session.getAttribute("user") != null;
    boolean isUser = session.getAttribute("userEmail") != null;

    if (!isAdmin && !isUser) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Book> results = (List<Book>) request.getAttribute("books");
    String keyword = request.getParameter("keyword");
    if (keyword == null) keyword = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Book — LibraryMS</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*, *::before, *::after { margin: 0; padding: 0; box-sizing: border-box; }
body {
  font-family: 'Inter', 'Segoe UI', sans-serif;
  background: #f0f4ff; color: #1e293b;
  min-height: 100vh; display: flex; flex-direction: column;
}
nav {
  background: #0f172a; padding: 0 60px; height: 66px;
  display: flex; align-items: center; justify-content: space-between;
  position: sticky; top: 0; z-index: 100;
  box-shadow: 0 1px 0 rgba(255,255,255,0.05);
}
.logo { font-size: 22px; font-weight: 700; color: #fff; letter-spacing: -0.3px; }
.logo span { color: #3b82f6; }
.nav-right { display: flex; align-items: center; gap: 20px; }
.nav-right span { font-size: 13px; color: #94a3b8; }
.nav-right strong { color: #e2e8f0; }
.logout-btn {
  font-size: 13px; font-weight: 600; padding: 7px 16px; border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.12); color: #cbd5e1;
  text-decoration: none; background: rgba(255,255,255,0.05);
  transition: background .2s, color .2s;
}
.logout-btn:hover { background: rgba(239,68,68,0.15); color: #fca5a5; border-color: rgba(239,68,68,0.3); }

.page { flex: 1; max-width: 860px; width: 100%; margin: 0 auto; padding: 52px 40px 64px; }

.breadcrumb {
  display: flex; align-items: center; gap: 6px;
  font-size: 13px; color: #64748b; margin-bottom: 28px;
}
.breadcrumb a { color: #64748b; text-decoration: none; transition: color .2s; }
.breadcrumb a:hover { color: #2563eb; }
.breadcrumb svg { width: 12px; height: 12px; }

.page-header { margin-bottom: 28px; }
.page-header h1 { font-size: 26px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; }
.page-header p  { font-size: 14px; color: #64748b; margin-top: 4px; }

/* Search card */
.search-card {
  background: #fff; border: 1px solid #e2e8f0;
  border-radius: 16px; padding: 28px 28px;
  box-shadow: 0 4px 20px rgba(0,0,0,.05);
  margin-bottom: 28px;
}
.search-row { display: flex; gap: 10px; }
.search-input-wrap { position: relative; flex: 1; }
.search-input-wrap svg {
  position: absolute; left: 13px; top: 50%; transform: translateY(-50%);
  width: 16px; height: 16px; color: #94a3b8; pointer-events: none;
}
.search-input-wrap input {
  width: 100%; padding: 12px 14px 12px 40px;
  border: 1px solid #d1d5db; border-radius: 10px;
  font-size: 14px; font-family: inherit; color: #0f172a;
  background: #f9fafb; outline: none;
  transition: border-color .2s, box-shadow .2s, background .2s;
}
.search-input-wrap input:focus {
  border-color: #2563eb; background: #fff;
  box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
}
.search-input-wrap input::placeholder { color: #9ca3af; }
.search-btn {
  padding: 12px 22px;
  background: linear-gradient(135deg, #2563eb, #1d4ed8);
  color: #fff; font-size: 14px; font-weight: 600;
  border: none; border-radius: 10px; cursor: pointer;
  font-family: inherit; white-space: nowrap;
  transition: opacity .2s;
}
.search-btn:hover { opacity: 0.88; }
.search-hint { font-size: 12px; color: #94a3b8; margin-top: 10px; }

/* Results table */
.table-card {
  background: #fff; border: 1px solid #e2e8f0;
  border-radius: 16px; overflow: hidden;
  box-shadow: 0 4px 20px rgba(0,0,0,.05);
}
.table-header {
  padding: 16px 20px; border-bottom: 1px solid #f1f5f9;
  display: flex; align-items: center; justify-content: space-between;
}
.table-header h2 { font-size: 15px; font-weight: 600; color: #0f172a; }
.result-badge {
  font-size: 12px; font-weight: 600; padding: 3px 10px;
  border-radius: 20px; background: #eff6ff; color: #2563eb;
}
table { width: 100%; border-collapse: collapse; }
thead tr { background: #f8fafc; border-bottom: 1px solid #e2e8f0; }
thead th {
  padding: 12px 16px; font-size: 11px; font-weight: 600;
  text-transform: uppercase; letter-spacing: 0.8px;
  color: #64748b; text-align: left;
}
tbody tr { border-bottom: 1px solid #f1f5f9; transition: background .15s; }
tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: #f8fafc; }
tbody td { padding: 14px 16px; font-size: 14px; color: #1e293b; }
.td-id     { color: #94a3b8; font-size: 13px; font-weight: 500; }
.td-title  { font-weight: 600; color: #0f172a; }
.td-author { color: #475569; }
.qty-badge {
  display: inline-flex; align-items: center; justify-content: center;
  min-width: 28px; height: 24px; border-radius: 6px;
  font-size: 12px; font-weight: 600; padding: 0 8px;
}
.qty-high { background: #f0fdf4; color: #16a34a; }
.qty-low  { background: #fffbeb; color: #d97706; }
.qty-zero { background: #fef2f2; color: #dc2626; }

.empty-state { padding: 52px 20px; text-align: center; }
.empty-state svg { width: 44px; height: 44px; color: #cbd5e1; margin-bottom: 14px; }
.empty-state h3  { font-size: 15px; font-weight: 600; color: #374151; margin-bottom: 5px; }
.empty-state p   { font-size: 13px; color: #64748b; }

footer {
  background: #0f172a; color: #475569;
  text-align: center; padding: 22px 40px; font-size: 13px;
}
footer span { color: #64748b; }

@media (max-width: 640px) {
  nav { padding: 0 20px; }
  .nav-right span { display: none; }
  .page { padding: 32px 16px 48px; }
  .search-card { padding: 20px; }
  .search-row { flex-direction: column; }
}
</style>
</head>
<body>

<nav>
  <div class="logo">Library<span>MS</span></div>
  <div class="nav-right">
    <span>Signed in as <strong><%= isAdmin ? "Admin" : "User" %></strong></span>
    <a href="logout" class="logout-btn">Logout</a>
  </div>
</nav>

<div class="page">

  <div class="breadcrumb">
    <a href="<%= isAdmin ? "dashboard.jsp" : "userDashboard.jsp" %>">Dashboard</a>
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"/></svg>
    <span>Search Book</span>
  </div>

  <div class="page-header">
    <h1>Search Books</h1>
    <p>Search by Book ID, title, or author name.</p>
  </div>

  <!-- Search form -->
  <div class="search-card">
    <form action="searchBook" method="get">
      <div class="search-row">
        <div class="search-input-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          <input type="text" name="keyword" value="<%= keyword %>" placeholder="Enter Book ID, title or author…" required>
        </div>
        <button type="submit" class="search-btn">Search</button>
      </div>
      <div class="search-hint">e.g. "Harry Potter", "Rowling", or "12"</div>
    </form>
  </div>

  <!-- Results -->
  <% if (results != null) { %>
  <div class="table-card">
    <div class="table-header">
      <h2>Results for "<%= keyword %>"</h2>
      <span class="result-badge"><%= results.size() %> found</span>
    </div>

    <% if (!results.isEmpty()) { %>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Author</th>
          <th>Quantity</th>
        </tr>
      </thead>
      <tbody>
        <% for (Book book : results) {
               int qty = book.getQuantity();
               String qtyClass = qty == 0 ? "qty-zero" : qty <= 2 ? "qty-low" : "qty-high";
        %>
        <tr>
          <td class="td-id">#<%= book.getId() %></td>
          <td class="td-title"><%= book.getTitle() %></td>
          <td class="td-author"><%= book.getAuthor() %></td>
          <td><span class="qty-badge <%= qtyClass %>"><%= qty %></span></td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <% } else { %>
    <div class="empty-state">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
        <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
      </svg>
      <h3>No books found</h3>
      <p>No results matched "<%= keyword %>". Try a different keyword.</p>
    </div>
    <% } %>
  </div>
  <% } %>

</div>

<footer>
  <p>© 2026 Integrated Library Management System &nbsp;·&nbsp;
     <span>Java</span> &nbsp;·&nbsp; <span>JSP</span> &nbsp;·&nbsp;
     <span>Servlets</span> &nbsp;·&nbsp; <span>JDBC</span> &nbsp;·&nbsp; <span>MySQL</span>
  </p>
</footer>

</body>
</html>
