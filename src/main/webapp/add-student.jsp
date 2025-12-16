<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.studdesk.model.Student" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Add Student - StudDesk</title>
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
                            <a href="student?action=list"><i class="fas fa-users"></i> Students</a>

                            <a href="student?action=add" class="active"><i class="fas fa-user-plus"></i> Add Student</a>
                            <a href="student?action=search"><i class="fas fa-search"></i> Search</a>
                        </nav>
                    </div>
                </header>

                <div class="content">
                    <div class="form-container">
                        <h2><i class="fas fa-user-plus"></i> Add New Student</h2>

                        <% String errorMessage=(String) request.getAttribute("errorMessage"); %>
                            <% if (errorMessage !=null) { %>
                                <div class="alert alert-error">
                                    <i class="fas fa-exclamation-circle"></i>
                                    <span>
                                        <%= errorMessage %>
                                    </span>
                                </div>
                                <% } %>

                                    <% Student student=(Student) request.getAttribute("student"); %>

                                        <form action="student" method="post" id="studentForm" novalidate>
                                            <input type="hidden" name="action" value="add">

                                            <div class="form-group">
                                                <label for="fullName">
                                                    <i class="fas fa-user"></i> Full Name <span
                                                        class="required">*</span>
                                                </label>
                                                <input type="text" id="fullName" name="fullName"
                                                    value="<%= student != null ? student.getFullName() : "" %>"
                                                    placeholder="Enter full name" required>
                                                <span class="error-message" id="fullNameError"></span>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="rollNumber">
                                                        <i class="fas fa-id-card"></i> Roll Number <span
                                                            class="required">*</span>
                                                    </label>
                                                    <input type="text" id="rollNumber" name="rollNumber"
                                                        value="<%= student != null ? student.getRollNumber() : "" %>"
                                                        placeholder="Enter roll number" required>
                                                    <span class="error-message" id="rollNumberError"></span>
                                                </div>

                                                <div class="form-group">
                                                    <label for="grade">
                                                        <i class="fas fa-graduation-cap"></i> Grade/Class <span
                                                            class="required">*</span>
                                                    </label>
                                                    <input type="text" id="grade" name="grade"
                                                        value="<%= student != null ? student.getGrade() : "" %>"
                                                        placeholder="e.g., 10th, XII, CS-101" required>
                                                    <span class="error-message" id="gradeError"></span>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="email">
                                                        <i class="fas fa-envelope"></i> Email <span
                                                            class="required">*</span>
                                                    </label>
                                                    <input type="email" id="email" name="email"
                                                        value="<%= student != null ? student.getEmail() : "" %>"
                                                        placeholder="student@example.com" required>
                                                    <span class="error-message" id="emailError"></span>
                                                </div>

                                                <div class="form-group">
                                                    <label for="phone">
                                                        <i class="fas fa-phone"></i> Phone Number <span
                                                            class="required">*</span>
                                                    </label>
                                                    <input type="tel" id="phone" name="phone"
                                                        value="<%= student != null ? student.getPhone() : "" %>"
                                                        placeholder="10 digits" maxlength="10" required>
                                                    <span class="error-message" id="phoneError"></span>
                                                </div>
                                            </div>

                                            <div class="form-row">
                                                <div class="form-group">
                                                    <label for="gender">
                                                        <i class="fas fa-venus-mars"></i> Gender <span
                                                            class="required">*</span>
                                                    </label>
                                                    <select id="gender" name="gender" required>
                                                        <option value="">Select gender</option>
                                                        <option value="Male" <%=student !=null && "Male"
                                                            .equals(student.getGender()) ? "selected" : "" %>>Male
                                                        </option>
                                                        <option value="Female" <%=student !=null && "Female"
                                                            .equals(student.getGender()) ? "selected" : "" %>>Female
                                                        </option>
                                                        <option value="Other" <%=student !=null && "Other"
                                                            .equals(student.getGender()) ? "selected" : "" %>>Other
                                                        </option>
                                                    </select>
                                                    <span class="error-message" id="genderError"></span>
                                                </div>

                                                <div class="form-group">
                                                    <label for="dateOfBirth">
                                                        <i class="fas fa-calendar"></i> Date of Birth
                                                    </label>
                                                    <input type="date" id="dateOfBirth" name="dateOfBirth"
                                                        value="<%= student != null && student.getDateOfBirth() != null ? student.getDateOfBirth() : "" %>">
                                                </div>
                                            </div>

                                            <div class="form-actions">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-save"></i> Add Student
                                                </button>
                                                <a href="student?action=list" class="btn btn-secondary">
                                                    <i class="fas fa-times"></i> Cancel
                                                </a>
                                            </div>
                                        </form>
                    </div>
                </div>

                <footer class="footer">
                    <p>&copy; 2025 StudDesk. Built with <i class="fas fa-heart" style="color: #ef4444;"></i> using Java
                        &
                        JSP</p>
                </footer>
            </div>
            <script src="js/theme-switcher.js"></script>
            <script src="js/validation.js"></script>
        </body>

        </html>