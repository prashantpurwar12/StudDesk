<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.studdesk.model.Student" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Students - StudDesk</title>
                <link rel="stylesheet" href="css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                                <a href="student?action=list" class="active"><i class="fas fa-users"></i> Students</a>
                                <a href="student?action=add"><i class="fas fa-user-plus"></i> Add Student</a>
                                <a href="student?action=search"><i class="fas fa-search"></i> Search</a>
                            </nav>
                        </div>
                    </header>

                    <div class="container">
                        <div class="page-header">
                            <div>
                                <h1>
                                    <i class="fas fa-users"></i> Student List
                                </h1>
                                <p class="subtitle">Manage all student records</p>
                            </div>
                            <div>
                                <a href="student?action=printList" class="btn btn-secondary"
                                    style="margin-right: 0.5rem;">
                                    <i class="fas fa-print"></i> Print List
                                </a>
                                <a href="student?action=add" class="btn btn-primary">
                                    <i class="fas fa-plus"></i> Add New Student
                                </a>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <% List<Student> students = (List<Student>) request.getAttribute("students");
                                        int index = 1;
                                        %>

                                        <% String successMessage=(String) request.getAttribute("successMessage"); %>
                                            <% if (successMessage !=null) { %>
                                                <div class="alert alert-success">
                                                    <i class="fas fa-check-circle"></i>
                                                    <span>
                                                        <%= successMessage %>
                                                    </span>
                                                </div>
                                                <% } %>

                                                    <% String errorMessage=(String)
                                                        request.getAttribute("errorMessage"); %>
                                                        <% if (errorMessage !=null) { %>
                                                            <div class="alert alert-error">
                                                                <i class="fas fa-exclamation-circle"></i>
                                                                <span>
                                                                    <%= errorMessage %>
                                                                </span>
                                                            </div>
                                                            <% } %>

                                                                <div class="table-container">
                                                                    <table class="data-table">
                                                                        <thead>
                                                                            <tr>
                                                                                <th>#</th>
                                                                                <th>Full Name</th>
                                                                                <th>Roll Number</th>
                                                                                <th>Grade</th>
                                                                                <th>Email</th>
                                                                                <th>Phone</th>
                                                                                <th>Gender</th>
                                                                                <th>Date of Birth</th>
                                                                                <th>Actions</th>
                                                                            </tr>
                                                                        </thead>
                                                                        <tbody>
                                                                            <% if (students !=null &&
                                                                                !students.isEmpty()) { %>
                                                                                <% for (Student student : students) { %>
                                                                                    <tr>
                                                                                        <td>
                                                                                            <%= index++ %>
                                                                                        </td>
                                                                                        <td><strong>
                                                                                                <%= student.getFullName()
                                                                                                    %>
                                                                                            </strong></td>
                                                                                        <td><span class="badge">
                                                                                                <%= student.getRollNumber()
                                                                                                    %>
                                                                                            </span></td>
                                                                                        <td>
                                                                                            <%= student.getGrade() %>
                                                                                        </td>
                                                                                        <td><i
                                                                                                class="fas fa-envelope"></i>
                                                                                            <%= student.getEmail() %>
                                                                                        </td>
                                                                                        <td><i class="fas fa-phone"></i>
                                                                                            <%= student.getPhone() %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <% if (student.getGender()
                                                                                                !=null &&
                                                                                                !student.getGender().isEmpty())
                                                                                                { String
                                                                                                genderIcon=student.getGender().equals("Male")
                                                                                                ? "mars" :
                                                                                                (student.getGender().equals("Female")
                                                                                                ? "venus" : "genderless"
                                                                                                ); %>
                                                                                                <i
                                                                                                    class="fas fa-<%= genderIcon %>"></i>
                                                                                                <%= student.getGender()
                                                                                                    %>
                                                                                                    <% } else { %>
                                                                                                        -
                                                                                                        <% } %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <%= student.getDateOfBirth()
                                                                                                !=null ?
                                                                                                student.getDateOfBirth()
                                                                                                : "N/A" %>
                                                                                        </td>
                                                                                        <td class="actions">
                                                                                            <a href="student?action=view&id=<%= student.getId() %>"
                                                                                                class="btn btn-sm btn-purple"
                                                                                                title="View Details">
                                                                                                <i
                                                                                                    class="fas fa-eye"></i>
                                                                                            </a>

                                                                                        </td>
                                                                                    </tr>
                                                                                    <% } %>
                                                                                        <% } else { %>
                                                                                            <tr>
                                                                                                <td colspan="9"
                                                                                                    class="text-center">
                                                                                                    <div
                                                                                                        class="empty-state">
                                                                                                        <i
                                                                                                            class="fas fa-users fa-3x"></i>
                                                                                                        <p>No students
                                                                                                            found</p>
                                                                                                        <a href="student?action=add"
                                                                                                            class="btn btn-primary">
                                                                                                            <i
                                                                                                                class="fas fa-plus"></i>
                                                                                                            Add Your
                                                                                                            First
                                                                                                            Student
                                                                                                        </a>
                                                                                                    </div>
                                                                                                </td>
                                                                                            </tr>
                                                                                            <% } %>
                                                                        </tbody>
                                                                    </table>

                                                                    <% Integer currentPage=(Integer)
                                                                        request.getAttribute("currentPage"); Integer
                                                                        pageSize=(Integer)
                                                                        request.getAttribute("pageSize"); Integer
                                                                        totalPages=(Integer)
                                                                        request.getAttribute("totalPages"); Integer
                                                                        totalStudents=(Integer)
                                                                        request.getAttribute("totalStudents"); if
                                                                        (currentPage==null) currentPage=1; if
                                                                        (pageSize==null) pageSize=10; if
                                                                        (totalPages==null) totalPages=0; if
                                                                        (totalStudents==null) totalStudents=0; int
                                                                        startRecord=(currentPage - 1) * pageSize + 1;
                                                                        int endRecord=Math.min(currentPage * pageSize,
                                                                        totalStudents); %>

                                                                        <% if (totalStudents> 0) { %>
                                                                            <div class="pagination-container">
                                                                                <div class="pagination-info">
                                                                                    <div class="page-size-selector">
                                                                                        <label
                                                                                            for="pageSizeSelect">Items
                                                                                            per page:</label>
                                                                                        <select id="pageSizeSelect"
                                                                                            onchange="changePageSize(this.value)">
                                                                                            <option value="10"
                                                                                                <%=pageSize==10
                                                                                                ? "selected" : "" %>>10
                                                                                            </option>
                                                                                            <option value="25"
                                                                                                <%=pageSize==25
                                                                                                ? "selected" : "" %>>25
                                                                                            </option>
                                                                                            <option value="50"
                                                                                                <%=pageSize==50
                                                                                                ? "selected" : "" %>>50
                                                                                            </option>
                                                                                        </select>
                                                                                    </div>

                                                                                    <div class="total-count">
                                                                                        Showing <strong>
                                                                                            <%= startRecord %> - <%=
                                                                                                    endRecord %>
                                                                                        </strong> of <strong>
                                                                                            <%= totalStudents %>
                                                                                        </strong> students
                                                                                    </div>
                                                                                </div>

                                                                                <% if (totalPages> 1) { %>
                                                                                    <div class="pagination-controls">
                                                                                        <!-- Previous Button -->
                                                                                        <% if (currentPage> 1) { %>
                                                                                            <a href="student?action=list&page=<%= currentPage - 1 %>&pageSize=<%= pageSize %>"
                                                                                                class="btn">
                                                                                                <i
                                                                                                    class="fas fa-chevron-left"></i>
                                                                                                Previous
                                                                                            </a>
                                                                                            <% } else { %>
                                                                                                <button class="btn"
                                                                                                    disabled>
                                                                                                    <i
                                                                                                        class="fas fa-chevron-left"></i>
                                                                                                    Previous
                                                                                                </button>
                                                                                                <% } %>

                                                                                                    <!-- Page Numbers -->
                                                                                                    <% int
                                                                                                        maxPagesToShow=5;
                                                                                                        int
                                                                                                        startPage=Math.max(1,
                                                                                                        currentPage -
                                                                                                        2); int
                                                                                                        endPage=Math.min(totalPages,
                                                                                                        startPage +
                                                                                                        maxPagesToShow -
                                                                                                        1); if (endPage
                                                                                                        - startPage <
                                                                                                        maxPagesToShow -
                                                                                                        1) {
                                                                                                        startPage=Math.max(1,
                                                                                                        endPage -
                                                                                                        maxPagesToShow +
                                                                                                        1); } %>

                                                                                                        <% if
                                                                                                            (startPage>
                                                                                                            1) { %>
                                                                                                            <a href="student?action=list&page=1&pageSize=<%= pageSize %>"
                                                                                                                class="btn">1</a>
                                                                                                            <% if
                                                                                                                (startPage>
                                                                                                                2) { %>
                                                                                                                <span
                                                                                                                    style="padding: 0 0.5rem; color: var(--text-secondary);">...</span>
                                                                                                                <% } %>
                                                                                                                    <% }
                                                                                                                        %>

                                                                                                                        <% for
                                                                                                                            (int
                                                                                                                            i=startPage;
                                                                                                                            i
                                                                                                                            <=endPage;
                                                                                                                            i++)
                                                                                                                            {
                                                                                                                            %>
                                                                                                                            <% if
                                                                                                                                (i==currentPage)
                                                                                                                                {
                                                                                                                                %>
                                                                                                                                <button
                                                                                                                                    class="btn active">
                                                                                                                                    <%= i
                                                                                                                                        %>
                                                                                                                                </button>
                                                                                                                                <% } else
                                                                                                                                    {
                                                                                                                                    %>
                                                                                                                                    <a href="student?action=list&page=<%= i %>&pageSize=<%= pageSize %>"
                                                                                                                                        class="btn">
                                                                                                                                        <%= i
                                                                                                                                            %>
                                                                                                                                    </a>
                                                                                                                                    <% }
                                                                                                                                        %>
                                                                                                                                        <% }
                                                                                                                                            %>

                                                                                                                                            <% if
                                                                                                                                                (endPage
                                                                                                                                                <
                                                                                                                                                totalPages)
                                                                                                                                                {
                                                                                                                                                %>
                                                                                                                                                <% if
                                                                                                                                                    (endPage
                                                                                                                                                    <
                                                                                                                                                    totalPages
                                                                                                                                                    -
                                                                                                                                                    1)
                                                                                                                                                    {
                                                                                                                                                    %>
                                                                                                                                                    <span
                                                                                                                                                        style="padding: 0 0.5rem; color: var(--text-secondary);">...</span>
                                                                                                                                                    <% }
                                                                                                                                                        %>
                                                                                                                                                        <a href="student?action=list&page=<%= totalPages %>&pageSize=<%= pageSize %>"
                                                                                                                                                            class="btn">
                                                                                                                                                            <%= totalPages
                                                                                                                                                                %>
                                                                                                                                                        </a>
                                                                                                                                                        <% }
                                                                                                                                                            %>

                                                                                                                                                            <% if
                                                                                                                                                                (currentPage
                                                                                                                                                                <
                                                                                                                                                                totalPages)
                                                                                                                                                                {
                                                                                                                                                                %>
                                                                                                                                                                <a href="student?action=list&page=<%= currentPage + 1 %>&pageSize=<%= pageSize %>"
                                                                                                                                                                    class="btn">
                                                                                                                                                                    Next
                                                                                                                                                                    <i
                                                                                                                                                                        class="fas fa-chevron-right"></i>
                                                                                                                                                                </a>
                                                                                                                                                                <% } else
                                                                                                                                                                    {
                                                                                                                                                                    %>
                                                                                                                                                                    <button
                                                                                                                                                                        class="btn"
                                                                                                                                                                        disabled>
                                                                                                                                                                        Next
                                                                                                                                                                        <i
                                                                                                                                                                            class="fas fa-chevron-right"></i>
                                                                                                                                                                    </button>
                                                                                                                                                                    <% }
                                                                                                                                                                        %>
                                                                                    </div>

                                                                                    <!-- Jump to Page -->
                                                                                    <div class="page-jump">
                                                                                        <label for="jumpToPage">Jump to
                                                                                            page:</label>
                                                                                        <input type="number"
                                                                                            id="jumpToPage" min="1"
                                                                                            max="<%= totalPages %>"
                                                                                            placeholder="<%= currentPage %>">
                                                                                        <button
                                                                                            class="btn btn-secondary"
                                                                                            onclick="jumpToPage()">Go</button>
                                                                                    </div>
                                                                                    <% } %>
                                                                            </div>
                                                                            <% } %>
                                                                </div>
                            </div>
                        </div>
                    </div>

                    <footer class="footer">
                        <p>&copy; 2025 StudDesk. Built with <i class="fas fa-heart" style="color: #ef4444;"></i> using
                            Java & JSP</p>
                    </footer>
                </div>

                <script src="js/theme-switcher.js"></script>
                <script>
                    function changePageSize(newSize) {
                        window.location.href = 'student?action=list&page=1&pageSize=' + newSize;
                    }

                    function jumpToPage() {
                        const pageInput = document.getElementById('jumpToPage');
                        const page = parseInt(pageInput.value);
                        const maxPage = parseInt(pageInput.max);

                        if (page && page >= 1 && page <= maxPage) {
                            const currentUrl = new URL(window.location);
                            const pageSize = new URLSearchParams(currentUrl.search).get('pageSize') || '10';
                            window.location.href = 'student?action=list&page=' + page + '&pageSize=' + pageSize;
                        } else {
                            alert('Please enter a valid page number between 1 and ' + maxPage);
                        }
                    }

                    // Allow Enter key to trigger jump to page
                    document.addEventListener('DOMContentLoaded', function () {
                        const jumpInput = document.getElementById('jumpToPage');
                        if (jumpInput) {
                            jumpInput.addEventListener('keypress', function (event) {
                                if (event.key === 'Enter') {
                                    event.preventDefault();
                                    jumpToPage();
                                }
                            });
                        }
                    });
                </script>

                <% Boolean printMode=(Boolean) request.getAttribute("printMode"); %>
                    <% if (printMode !=null && printMode) { %>
                        <script>
                            // Auto-trigger print dialog when in print mode
                            window.addEventListener('load', function () {
                                setTimeout(function () {
                                    window.print();
                                }, 500);

                                // After printing (or canceling), go back to the list
                                window.addEventListener('afterprint', function () {
                                    window.location.href = 'student?action=list';
                                });
                            });
                        </script>
                        <% } %>
            </body>

            </html>