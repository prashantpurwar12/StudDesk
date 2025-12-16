<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.studdesk.model.Student" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Advanced Search - StudDesk</title>
                <link rel="stylesheet" href="css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    .search-hero {
                        background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
                        padding: 3rem 2rem;
                        border-radius: 1rem;
                        text-align: center;
                        margin-bottom: 2rem;
                        color: white;
                        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
                    }

                    .search-hero h1 {
                        font-size: 2.5rem;
                        margin-bottom: 0.5rem;
                        color: white;
                    }

                    .search-hero p {
                        font-size: 1.1rem;
                        opacity: 0.95;
                    }

                    .search-container {
                        max-width: 1200px;
                        margin: 0 auto;
                    }

                    .advanced-search-panel {
                        background: var(--card-bg);
                        border-radius: 1rem;
                        padding: 2rem;
                        box-shadow: 0 4px 24px rgba(0, 0, 0, 0.1);
                        margin-bottom: 2rem;
                        border: 1px solid var(--border-color);
                    }

                    .search-section {
                        margin-bottom: 2rem;
                    }

                    .search-section h3 {
                        color: var(--text-primary);
                        margin-bottom: 1rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        font-size: 1.2rem;
                    }

                    .search-section h3 i {
                        color: var(--primary-color);
                    }

                    .search-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
                        gap: 1.5rem;
                    }

                    .search-field {
                        display: flex;
                        flex-direction: column;
                        gap: 0.5rem;
                    }

                    .search-field label {
                        font-weight: 600;
                        color: var(--text-secondary);
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .search-field label i {
                        color: var(--primary-color);
                        width: 1.2rem;
                    }

                    .search-field input,
                    .search-field select {
                        padding: 0.75rem 1rem;
                        border: 2px solid var(--border-color);
                        border-radius: 0.5rem;
                        font-size: 1rem;
                        transition: all 0.3s;
                        background: var(--bg-color);
                        color: var(--text-primary);
                    }

                    .search-field input:focus,
                    .search-field select:focus {
                        outline: none;
                        border-color: var(--primary-color);
                        box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
                    }

                    .search-actions {
                        display: flex;
                        gap: 1rem;
                        justify-content: center;
                        flex-wrap: wrap;
                        margin-top: 2rem;
                        padding-top: 2rem;
                        border-top: 2px solid var(--border-color);
                    }

                    .search-actions .btn {
                        padding: 0.875rem 2rem;
                        font-size: 1rem;
                        min-width: 150px;
                    }

                    .results-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1.5rem;
                        padding: 1rem;
                        background: var(--card-bg);
                        border-radius: 0.75rem;
                        border: 1px solid var(--border-color);
                    }

                    .results-count {
                        font-size: 1.1rem;
                        font-weight: 600;
                        color: var(--text-primary);
                    }

                    .results-count i {
                        color: var(--success-color);
                    }

                    .active-filters-display {
                        background: var(--info-bg);
                        border-left: 4px solid var(--info-color);
                        padding: 1rem 1.5rem;
                        border-radius: 0.5rem;
                        margin-bottom: 1.5rem;
                    }

                    .active-filters-display h4 {
                        color: var(--info-color);
                        margin-bottom: 0.75rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .filter-tags {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 0.5rem;
                    }

                    .filter-tag {
                        background: var(--card-bg);
                        padding: 0.5rem 1rem;
                        border-radius: 2rem;
                        font-size: 0.9rem;
                        color: var(--text-primary);
                        border: 1px solid var(--border-color);
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .filter-tag strong {
                        color: var(--primary-color);
                    }

                    .student-card {
                        background: var(--card-bg);
                        border-radius: 1rem;
                        padding: 1.5rem;
                        border: 1px solid var(--border-color);
                        transition: all 0.3s;
                        margin-bottom: 1rem;
                    }

                    .student-card:hover {
                        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
                        transform: translateY(-2px);
                    }

                    .student-card-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: flex-start;
                        margin-bottom: 1rem;
                    }

                    .student-name {
                        font-size: 1.4rem;
                        font-weight: 700;
                        color: var(--text-primary);
                        margin-bottom: 0.25rem;
                    }

                    .student-roll {
                        display: inline-block;
                        background: var(--primary-color);
                        color: white;
                        padding: 0.25rem 0.75rem;
                        border-radius: 0.5rem;
                        font-size: 0.875rem;
                        font-weight: 600;
                    }

                    .student-details {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                        gap: 1rem;
                        margin: 1rem 0;
                    }

                    .detail-item {
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                        color: var(--text-secondary);
                    }

                    .detail-item i {
                        color: var(--primary-color);
                        width: 1.2rem;
                    }

                    .student-actions {
                        display: flex;
                        gap: 0.75rem;
                        margin-top: 1rem;
                        padding-top: 1rem;
                        border-top: 1px solid var(--border-color);
                    }

                    .no-results {
                        text-align: center;
                        padding: 4rem 2rem;
                        background: var(--card-bg);
                        border-radius: 1rem;
                        border: 2px dashed var(--border-color);
                    }

                    .no-results i {
                        font-size: 4rem;
                        color: var(--text-secondary);
                        opacity: 0.5;
                        margin-bottom: 1rem;
                    }

                    .no-results h3 {
                        color: var(--text-primary);
                        margin-bottom: 0.5rem;
                    }

                    .no-results p {
                        color: var(--text-secondary);
                        margin-bottom: 1.5rem;
                    }

                    .search-tips {
                        background: var(--warning-bg);
                        border-left: 4px solid var(--warning-color);
                        padding: 1rem 1.5rem;
                        border-radius: 0.5rem;
                        margin-top: 1.5rem;
                    }

                    .search-tips h4 {
                        color: var(--warning-color);
                        margin-bottom: 0.5rem;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .search-tips ul {
                        margin-left: 1.5rem;
                        color: var(--text-secondary);
                    }

                    .search-tips li {
                        margin-bottom: 0.25rem;
                    }

                    @media (max-width: 768px) {
                        .search-hero h1 {
                            font-size: 2rem;
                        }

                        .search-grid {
                            grid-template-columns: 1fr;
                        }

                        .search-actions {
                            flex-direction: column;
                        }

                        .search-actions .btn {
                            width: 100%;
                        }

                        .student-details {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <header class="header">
                        <div>
                            <h1 class="brand"><i class="fas fa-graduation-cap"></i> StudDesk</h1>
                            <p class="tagline">Student Management System</p>
                        </div>
                        <div class="header-left">
                            <button id="theme-toggle" class="theme-toggle" title="Toggle Dark Mode">
                                <i class="fas fa-sun"></i>
                                <i class="fas fa-moon"></i>
                            </button>
                            <nav class="nav">
                                <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
                                <a href="student?action=list"><i class="fas fa-users"></i> Students</a>

                                <a href="student?action=add"><i class="fas fa-user-plus"></i> Add Student</a>
                                <a href="student?action=search" class="active"><i class="fas fa-search"></i> Search</a>
                            </nav>
                        </div>
                    </header>

                    <div class="search-container">
                        <div class="advanced-search-panel">
                            <form action="student" method="post">
                                <input type="hidden" name="action" value="search">
                                <div class="search-section">
                                    <h3><i class="fas fa-user"></i> Personal Information</h3>
                                    <div class="search-grid">
                                        <div class="search-field">
                                            <label for="searchName">
                                                <i class="fas fa-signature"></i> Full Name
                                            </label>
                                            <input type="text" id="searchName" name="searchName"
                                                value="<%= request.getParameter(" searchName") !=null ?
                                                request.getParameter("searchName") : "" %>"
                                            placeholder="Enter student name...">
                                        </div>

                                        <div class="search-field">
                                            <label for="searchRollNumber">
                                                <i class="fas fa-id-card"></i> Roll Number
                                            </label>
                                            <input type="text" id="searchRollNumber" name="searchRollNumber"
                                                value="<%= request.getParameter(" searchRollNumber") !=null ?
                                                request.getParameter("searchRollNumber") : "" %>"
                                            placeholder="Enter roll number...">
                                        </div>
                                    </div>
                                </div>
                                <div class="search-section">
                                    <h3><i class="fas fa-graduation-cap"></i> Academic Information</h3>
                                    <div class="search-grid">
                                        <div class="search-field">
                                            <label for="searchGrade">
                                                <i class="fas fa-award"></i> Grade/Class
                                            </label>
                                            <select id="searchGrade" name="searchGrade">
                                                <option value="">All Grades</option>
                                                <% String searchGrade=request.getParameter("searchGrade"); %>
                                                    <option value="9" <%="9" .equals(searchGrade) ? "selected" : "" %>
                                                        >Grade 9</option>
                                                    <option value="10" <%="10" .equals(searchGrade) ? "selected" : "" %>
                                                        >Grade 10</option>
                                                    <option value="11" <%="11" .equals(searchGrade) ? "selected" : "" %>
                                                        >Grade 11</option>
                                                    <option value="12" <%="12" .equals(searchGrade) ? "selected" : "" %>
                                                        >Grade 12</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="search-actions">
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-search"></i> Search Students
                                    </button>
                                    <button type="button" class="btn btn-secondary" onclick="resetSearch()">
                                        <i class="fas fa-undo"></i> Reset All Filters
                                    </button>
                                    <a href="student?action=list" class="btn btn-outline">
                                        <i class="fas fa-list"></i> View All Students
                                    </a>
                                </div>
                            </form>
                        </div>

                        <% List<Student> students = (List<Student>) request.getAttribute("students");
                                Boolean searchPerformed = request.getParameter("searchName") != null ||
                                request.getParameter("searchRollNumber") != null ||
                                request.getParameter("searchGrade") != null;

                                if (searchPerformed) {
                                %>
                                <div class="active-filters-display">
                                    <h4><i class="fas fa-filter"></i> Active Search Criteria</h4>
                                    <div class="filter-tags">
                                        <% if (request.getParameter("searchName") !=null &&
                                            !request.getParameter("searchName").isEmpty()) { %>
                                            <span class="filter-tag">
                                                <i class="fas fa-user"></i> Name: <strong>
                                                    <%= request.getParameter("searchName") %>
                                                </strong>
                                            </span>
                                            <% } %>
                                                <% if (request.getParameter("searchRollNumber") !=null &&
                                                    !request.getParameter("searchRollNumber").isEmpty()) { %>
                                                    <span class="filter-tag">
                                                        <i class="fas fa-id-card"></i> Roll: <strong>
                                                            <%= request.getParameter("searchRollNumber") %>
                                                        </strong>
                                                    </span>
                                                    <% } %>
                                    </div>
                                </div>

                                <div class="results-header">
                                    <div class="results-count">
                                        <i class="fas fa-check-circle"></i>
                                        Found <strong>
                                            <%= students !=null ? students.size() : 0 %>
                                        </strong> student(s)
                                    </div>
                                    <% if (students !=null && !students.isEmpty()) { %>
                                        <a href="student?action=export&format=csv" class="btn btn-outline">
                                            <i class="fas fa-download"></i> Export Results
                                        </a>
                                        <% } %>
                                </div>

                                <% if (students !=null && !students.isEmpty()) { %>
                                    <% for (Student student : students) { %>
                                        <div class="student-card">
                                            <div class="student-card-header">
                                                <div>
                                                    <div class="student-name">
                                                        <i class="fas fa-user-graduate"></i>
                                                        <%= student.getFullName() %>
                                                    </div>
                                                    <span class="student-roll">Roll: <%= student.getRollNumber() %>
                                                    </span>
                                                </div>
                                            </div>

                                            <div class="student-details">
                                                <div class="detail-item">
                                                    <i class="fas fa-graduation-cap"></i>
                                                    <span><strong>Grade:</strong>
                                                        <%= student.getGrade() %>
                                                    </span>
                                                </div>
                                                <div class="detail-item">
                                                    <i class="fas fa-envelope"></i>
                                                    <span><strong>Email:</strong>
                                                        <%= student.getEmail() %>
                                                    </span>
                                                </div>
                                                <div class="detail-item">
                                                    <i class="fas fa-phone"></i>
                                                    <span><strong>Phone:</strong>
                                                        <%= student.getPhone() %>
                                                    </span>
                                                </div>
                                                <% if (student.getGender() !=null && !student.getGender().isEmpty()) {
                                                    %>
                                                    <div class="detail-item">
                                                        <i class="fas fa-<%= student.getGender().equals(" Male")
                                                            ? "mars" : (student.getGender().equals("Female") ? "venus"
                                                            : "genderless" ) %>"></i>
                                                        <span><strong>Gender:</strong>
                                                            <%= student.getGender() %>
                                                        </span>
                                                    </div>
                                                    <% } %>
                                                        <% if (student.getDateOfBirth() !=null) { %>
                                                            <div class="detail-item">
                                                                <i class="fas fa-birthday-cake"></i>
                                                                <span><strong>DOB:</strong>
                                                                    <%= student.getDateOfBirth() %>
                                                                </span>
                                                            </div>
                                                            <% } %>
                                            </div>

                                            <div class="student-actions">
                                                <a href="student?action=view&id=<%= student.getId() %>"
                                                    class="btn btn-sm btn-primary">
                                                    <i class="fas fa-eye"></i> View Details
                                                </a>
                                                <a href="student?action=edit&id=<%= student.getId() %>"
                                                    class="btn btn-sm btn-secondary">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <button data-student-id="<%= student.getId() %>"
                                                    data-student-name="<%= student.getFullName() %>"
                                                    onclick="confirmDelete(this.dataset.studentId, this.dataset.studentName)"
                                                    class="btn btn-sm btn-danger">
                                                    <i class="fas fa-trash"></i> Delete
                                                </button>
                                            </div>
                                        </div>
                                        <% } %>
                                            <% } else { %>
                                                <div class="no-results">
                                                    <i class="fas fa-search"></i>
                                                    <h3>No Students Found</h3>
                                                    <p>We couldn't find any students matching your search criteria.</p>
                                                    <p>Try adjusting your filters or search with different criteria.</p>
                                                    <button type="button" class="btn btn-primary"
                                                        onclick="resetSearch()">
                                                        <i class="fas fa-redo"></i> Start New Search
                                                    </button>
                                                </div>
                                                <% } %>
                                                    <% } %>
                    </div>

                    <footer class="footer">
                        <p>&copy; 2025 StudDesk. Built with <i class="fas fa-heart" style="color: #ef4444;"></i>
                            using
                            Java & JSP</p>
                    </footer>
                </div>

                <script src="js/theme-switcher.js"></script>
                <script>
                    function resetSearch() {
                        document.getElementById('searchName').value = '';
                        document.getElementById('searchRollNumber').value = '';
                        document.getElementById('searchGrade').value = '';
                        window.location.href = 'student?action=search';
                    }

                    function confirmDelete(studentId, studentName) {
                        if (confirm('Are you sure you want to delete ' + studentName + '?')) {
                            window.location.href = 'student?action=delete&id=' + studentId;
                        }
                    }
                    document.addEventListener('DOMContentLoaded', function () {
                        document.getElementById('searchName').focus();
                    });

                    document.addEventListener('DOMContentLoaded', function () {
                        const studentCards = document.querySelectorAll('.student-card');
                        studentCards.forEach((card, index) => {
                            card.style.opacity = '0';
                            card.style.transform = 'translateY(20px)';
                            setTimeout(() => {
                                card.style.transition = 'all 0.3s ease';
                                card.style.opacity = '1';
                                card.style.transform = 'translateY(0)';
                            }, index * 50);
                        });
                    });
                </script>
            </body>

            </html>