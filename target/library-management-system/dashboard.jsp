<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.library.dao.BookDao" %>
<%@ page import="com.library.dao.UserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.library.model.User" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    BookDao bookDao = new BookDao();
    UserDao userDao = new UserDao();

    int totalBooks  = bookDao.getTotalBooks();
    int issuedBooks = bookDao.getIssuedBooksCount();
    int returned    = bookDao.getReturnedBooksCount();

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
<title>Admin Dashboard — LibraryMS</title>
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
  padding: 7px 16px;
  border-radius: 8px;
  border: 1px solid rgba(255,255,255,0.12);
  color: #cbd5e1;
  text-decoration: none;
  background: rgba(255,255,255,0.05);
  transition: background .2s, color .2s;
}
.logout-btn:hover { background: rgba(239,68,68,0.15); color: #fca5a5; border-color: rgba(239,68,68,0.3); }

/* ── Page ── */
.page { max-width: 1200px; margin: 0 auto; padding: 48px 40px 64px; flex: 1; width: 100%; }

.page-header { margin-bottom: 36px; }
.page-header h1 { font-size: 28px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; }
.page-header p  { font-size: 14px; color: #64748b; margin-top: 4px; }

/* ── Stats row ── */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  margin-bottom: 36px;
}
.stat-card {
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 14px;
  padding: 22px 20px;
  display: flex; align-items: center; gap: 14px;
  box-shadow: 0 2px 8px rgba(0,0,0,.04);
}
.stat-icon {
  width: 42px; height: 42px;
  border-radius: 11px;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.stat-icon svg { width: 20px; height: 20px; }
.si-blue  { background: #eff6ff; }
.si-green { background: #f0fdf4; }
.si-amber { background: #fffbeb; }
.si-purple{ background: #f5f3ff; }
.stat-info {}
.stat-val  { font-size: 26px; font-weight: 700; color: #0f172a; letter-spacing: -0.5px; line-height: 1; }
.stat-lbl  { font-size: 12px; color: #64748b; margin-top: 3px; font-weight: 500; }

/* ── Action grid ── */
.section-title {
  font-size: 13px; font-weight: 600; letter-spacing: 1px;
  text-transform: uppercase; color: #94a3b8;
  margin-bottom: 16px;
}
.actions-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 14px;
}
.action-card {
  background: #fff;
  border: 1px solid #e2e8f0;
  border-radius: 14px;
  padding: 22px 20px;
  text-decoration: none;
  color: inherit;
  display: flex; align-items: center; gap: 14px;
  transition: transform .22s, box-shadow .22s, border-color .22s;
  box-shadow: 0 2px 8px rgba(0,0,0,.04);
}
.action-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 28px rgba(0,0,0,.09);
}
.action-card.c-blue:hover   { border-color: #93c5fd; }
.action-card.c-green:hover  { border-color: #6ee7b7; }
.action-card.c-amber:hover  { border-color: #fcd34d; }
.action-card.c-purple:hover { border-color: #c4b5fd; }
.action-card.c-rose:hover   { border-color: #fda4af; }
.action-card.c-cyan:hover   { border-color: #67e8f9; }

.ac-icon {
  width: 40px; height: 40px;
  border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.ac-icon svg { width: 18px; height: 18px; }
.aci-blue   { background: #eff6ff; }
.aci-green  { background: #f0fdf4; }
.aci-amber  { background: #fffbeb; }
.aci-purple { background: #f5f3ff; }
.aci-rose   { background: #fff1f2; }
.aci-cyan   { background: #ecfeff; }

.ac-text {}
.ac-title { font-size: 14px; font-weight: 600; color: #0f172a; }
.ac-desc  { font-size: 12px; color: #64748b; margin-top: 2px; }

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
@media (max-width: 1000px) {
  .stats-grid { grid-template-columns: repeat(2, 1fr); }
  .actions-grid { grid-template-columns: repeat(2, 1fr); }
}
@media (max-width: 640px) {
  nav { padding: 0 20px; }
  .page { padding: 32px 20px 48px; }
  .stats-grid { grid-template-columns: repeat(2, 1fr); }
  .actions-grid { grid-template-columns: 1fr; }
  .nav-right span { display: none; }
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
  <div class="page-header">
    <h1>Admin Dashboard</h1>
    <p>Welcome back, Admin. Here's what's happening in your library.</p>
  </div>

  <!-- Stats -->
  <div class="stats-grid">
    <div class="stat-card">
      <div class="stat-icon si-blue">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
        </svg>
      </div>
      <div class="stat-info">
        <div class="stat-val"><%= totalBooks %></div>
        <div class="stat-lbl">Total Books</div>
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon si-green">
        <svg viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
          <circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
      </div>
      <div class="stat-info">
        <div class="stat-val"><%= activeUsers %></div>
        <div class="stat-lbl">Active Members</div>
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon si-amber">
        <svg viewBox="0 0 24 24" fill="none" stroke="#d97706" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 11 12 14 22 4"/>
          <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/>
        </svg>
      </div>
      <div class="stat-info">
        <div class="stat-val"><%= issuedBooks %></div>
        <div class="stat-lbl">Books Issued</div>
      </div>
    </div>

    <div class="stat-card">
      <div class="stat-icon si-purple">
        <svg viewBox="0 0 24 24" fill="none" stroke="#7c3aed" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"/>
        </svg>
      </div>
      <div class="stat-info">
        <div class="stat-val"><%= returned %></div>
        <div class="stat-lbl">Books Returned</div>
      </div>
    </div>
  </div>

  <!-- Actions -->
  <div class="section-title">Quick Actions</div>
  <div class="actions-grid">

    <a href="addBook.jsp" class="action-card c-blue">
      <div class="ac-icon aci-blue">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">Add Book</div>
        <div class="ac-desc">Add a new book to the catalog</div>
      </div>
    </a>

    <a href="viewBooks" class="action-card c-green">
      <div class="ac-icon aci-green">
        <svg viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20"/><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">View Books</div>
        <div class="ac-desc">Browse the full book inventory</div>
      </div>
    </a>

    <a href="searchBook.jsp" class="action-card c-cyan">
      <div class="ac-icon aci-cyan">
        <svg viewBox="0 0 24 24" fill="none" stroke="#0891b2" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">Search Book</div>
        <div class="ac-desc">Find books by title or author</div>
      </div>
    </a>

    <a href="issueBook.jsp" class="action-card c-amber">
      <div class="ac-icon aci-amber">
        <svg viewBox="0 0 24 24" fill="none" stroke="#d97706" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 11 12 14 22 4"/>
          <path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">Issue Book</div>
        <div class="ac-desc">Issue a book to a member</div>
      </div>
    </a>

    <a href="returnBook.jsp" class="action-card c-blue">
      <div class="ac-icon aci-blue">
        <svg viewBox="0 0 24 24" fill="none" stroke="#2563eb" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M9 14L4 9l5-5"/>
          <path d="M20 20v-7a4 4 0 0 0-4-4H4"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">Return Book</div>
        <div class="ac-desc">Return an issued book</div>
      </div>
    </a>

    <a href="viewIssuedBooks" class="action-card c-purple">
      <div class="ac-icon aci-purple">
        <svg viewBox="0 0 24 24" fill="none" stroke="#7c3aed" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
          <polyline points="14 2 14 8 20 8"/><line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">Issued Books</div>
        <div class="ac-desc">View all currently issued books</div>
      </div>
    </a>

    <a href="viewUsers" class="action-card c-green">
      <div class="ac-icon aci-green">
        <svg viewBox="0 0 24 24" fill="none" stroke="#16a34a" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
          <circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">View Users</div>
        <div class="ac-desc">Manage and approve members</div>
      </div>
    </a>

    <a href="reports" class="action-card c-rose">
      <div class="ac-icon aci-rose">
        <svg viewBox="0 0 24 24" fill="none" stroke="#e11d48" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="20" x2="18" y2="10"/><line x1="12" y1="20" x2="12" y2="4"/>
          <line x1="6" y1="20" x2="6" y2="14"/><line x1="2" y1="20" x2="22" y2="20"/>
        </svg>
      </div>
      <div class="ac-text">
        <div class="ac-title">Reports & Analytics</div>
        <div class="ac-desc">View stats and generate reports</div>
      </div>
    </a>

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
