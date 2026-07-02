<%@ page import="java.util.List" %>
<%@ page import="com.library.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    boolean isAdmin = session.getAttribute("user") != null;
    boolean isUser = session.getAttribute("userEmail") != null;

    if (!isAdmin && !isUser) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Book> books = (List<Book>) request.getAttribute("books");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Books — LibraryMS</title>
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
  font-size: 13px; font-weight: 600;
  padding: 7px 16px; border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.12);
  color: #cbd5e1; text-decoration: none;
  background: rgba(255,255,255,0.05);
  transition: background .2s, color .2s;
}
.logout-btn:hover { background: rgba(239,68,68,0.15); color: #fca5a5; border-color: rgba(239,68,68,0.3); }

/* ── Page ── */
.page { flex: 1; max-width: 1100px; width: 100%; margin: 0 auto; padding: 52px 40px 64px; }

.breadcrumb {
  display: flex; align-items: center; gap: 6px;
  font-size: 13px; color: #64748b; margin-bottom: 28px;
}
.breadcrumb a { color: #64748b; text-decoration: none; transition: color .2s; }
.breadcrumb a:hover { color: #2563eb; }
.breadcrumb svg { width: 12px; height: 12px; }

.page-header {
  display: flex; align-items: flex-start;
  justify-content: space-between; gap: 20px;
  margin-bottom: 28px; flex-wrap: wrap;
}
.page-header-left h1 { font-size: 26px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; }
.page-header-left p  { font-size: 14px; color: #64748b; margin-top: 4px; }

.btn-primary {
  display: inline-flex; align-items: center; gap: 7px;
  padding: 10px 18px;
  background: linear-gradient(135deg, #2563eb, #1d4ed8);
  color: #fff; font-size: 13px; font-weight: 600;
  border-radius: 10px; text-decoration: none;
  transition: opacity .2s; white-space: nowrap;
}
.btn-primary:hover { opacity: 0.88; }
.btn-primary svg { width: 14px; height: 14px; }

/* ── Table card ── */
.table-card {
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  overflow: hidden;
  box-shadow: 0 4px 20px rgba(0,0,0,.05);
}

/* search bar inside card header */
.table-toolbar {
  padding: 16px 20px;
  border-bottom: 1px solid #f1f5f9;
  display: flex; align-items: center; gap: 12px;
}
.search-wrap {
  position: relative; flex: 1; max-width: 320px;
}
.search-wrap svg {
  position: absolute; left: 11px; top: 50%; transform: translateY(-50%);
  width: 14px; height: 14px; color: #94a3b8; pointer-events: none;
}
.search-wrap input {
  width: 100%; padding: 8px 12px 8px 34px;
  border: 1px solid #e2e8f0; border-radius: 8px;
  font-size: 13px; font-family: inherit; color: #0f172a;
  background: #f9fafb; outline: none;
  transition: border-color .2s, box-shadow .2s;
}
.search-wrap input:focus {
  border-color: #2563eb;
  box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
  background: #fff;
}
.search-wrap input::placeholder { color: #9ca3af; }
.record-count { font-size: 13px; color: #64748b; margin-left: auto; }

table { width: 100%; border-collapse: collapse; }
thead tr { background: #f8fafc; border-bottom: 1px solid #e2e8f0; }
thead th {
  padding: 12px 16px;
  font-size: 11px; font-weight: 600;
  text-transform: uppercase; letter-spacing: 0.8px;
  color: #64748b; text-align: left;
}
tbody tr {
  border-bottom: 1px solid #f1f5f9;
  transition: background .15s;
}
tbody tr:last-child { border-bottom: none; }
tbody tr:hover { background: #f8fafc; }
tbody td {
  padding: 14px 16px;
  font-size: 14px; color: #1e293b;
}
.td-id    { color: #94a3b8; font-size: 13px; font-weight: 500; }
.td-title { font-weight: 600; color: #0f172a; }
.td-author { color: #475569; }

.qty-badge {
  display: inline-flex; align-items: center; justify-content: center;
  min-width: 28px; height: 24px;
  border-radius: 6px; font-size: 12px; font-weight: 600;
  padding: 0 8px;
}
.qty-high { background: #f0fdf4; color: #16a34a; }
.qty-low  { background: #fffbeb; color: #d97706; }
.qty-zero { background: #fef2f2; color: #dc2626; }

/* empty state */
.empty-state {
  padding: 60px 20px; text-align: center;
}
.empty-state svg { width: 48px; height: 48px; color: #cbd5e1; margin-bottom: 16px; }
.empty-state h3  { font-size: 16px; font-weight: 600; color: #374151; margin-bottom: 6px; }
.empty-state p   { font-size: 14px; color: #64748b; }

/* ── Footer ── */
footer {
  background: #0f172a; color: #475569;
  text-align: center; padding: 22px 40px; font-size: 13px;
}
footer span { color: #64748b; }

@media (max-width: 700px) {
  nav { padding: 0 20px; }
  .nav-right span { display: none; }
  .page { padding: 32px 16px 48px; }
  .page-header { flex-direction: column; }
  thead th:first-child, tbody td:first-child { display: none; }
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
    <span>View Books</span>
  </div>

  <div class="page-header">
    <div class="page-header-left">
      <h1>Book Catalog</h1>
      <p>All books currently in the library inventory.</p>
    </div>
    <% if(isAdmin){ %>
    <a href="addBook.jsp" class="btn-primary">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
      Add Book
    </a>
    <% } %>
  </div>

  <div class="table-card">
    <div class="table-toolbar">
      <div class="search-wrap">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" id="searchInput" placeholder="Search by title or author…" oninput="filterTable()">
      </div>
      <span class="record-count" id="recordCount">
        <%= (books != null ? books.size() : 0) %> books
      </span>
    </div>

    <% if (books != null && !books.isEmpty()) { %>
    <table id="booksTable">
      <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Author</th>
          <th>Quantity</th>
        </tr>
      </thead>
      <tbody>
        <% for (Book book : books) {
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
        <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
      </svg>
      <h3>No books found</h3>
      <p>Start by adding your first book to the catalog.</p>
    </div>
    <% } %>
  </div>

</div>

<footer>
  <p>© 2026 Integrated Library Management System &nbsp;·&nbsp;
     <span>Java</span> &nbsp;·&nbsp; <span>JSP</span> &nbsp;·&nbsp;
     <span>Servlets</span> &nbsp;·&nbsp; <span>JDBC</span> &nbsp;·&nbsp; <span>MySQL</span>
  </p>
</footer>

<script>
function filterTable() {
  const q = document.getElementById('searchInput').value.toLowerCase();
  const rows = document.querySelectorAll('#booksTable tbody tr');
  let visible = 0;
  rows.forEach(row => {
    const title  = row.cells[1].textContent.toLowerCase();
    const author = row.cells[2].textContent.toLowerCase();
    const match  = title.includes(q) || author.includes(q);
    row.style.display = match ? '' : 'none';
    if (match) visible++;
  });
  document.getElementById('recordCount').textContent = visible + ' books';
}
</script>

</body>
</html>
