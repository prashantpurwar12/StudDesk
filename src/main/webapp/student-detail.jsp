<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="com.studdesk.model.Student" %>
        <%@ page import="java.time.format.DateTimeFormatter" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Student Details - EduDesk</title>
                <link rel="stylesheet" href="css/style.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <div class="container">
                    <header class="header">
                        <div>
                            <h1 class="brand"><i class="fas fa-graduation-cap"></i> EduDesk</h1>
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

                    <% Student student=(Student) request.getAttribute("student"); DateTimeFormatter
                        dateFormatter=DateTimeFormatter.ofPattern("dd MMM yyyy"); %>

                        <div class="detail-container">
                            <nav class="breadcrumb">
                                <a href="dashboard.jsp"><i class="fas fa-home"></i> Home</a>
                                <span class="separator">/</span>
                                <a href="student?action=list">Students</a>
                                <span class="separator">/</span>
                                <span class="current">
                                    <%= student.getFullName() %>
                                </span>
                            </nav>

                            <div class="action-buttons">
                                <a href="student?action=edit&id=<%= student.getId() %>" class="btn btn-primary">
                                    <i class="fas fa-edit"></i> Edit Profile
                                </a>
                                <button onclick="printDetails()" class="btn btn-secondary">
                                    <i class="fas fa-print"></i> Print
                                </button>
                                <a href="student?action=list" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left"></i> Back
                                </a>
                            </div>
                        </div>

                        <div class="detail-grid">
                            <div class="left-column">
                                <div class="info-card">
                                    <h3><i class="fas fa-user"></i> Personal Details</h3>
                                    <div class="info-content">
                                        <div class="info-row">
                                            <span class="label">Full Name:</span>
                                            <span class="value">
                                                <%= student.getFullName() %>
                                            </span>
                                        </div>
                                        <div class="info-row">
                                            <span class="label">Gender:</span>
                                            <span class="value">
                                                <%= student.getGender() %>
                                            </span>
                                        </div>
                                        <div class="info-row">
                                            <span class="label">Date of Birth:</span>
                                            <span class="value">
                                                <%= student.getDateOfBirth() !=null ?
                                                    student.getDateOfBirth().format(dateFormatter) : "Not provided" %>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="info-card">
                                    <h3><i class="fas fa-graduation-cap"></i> Academic Records</h3>
                                    <div class="info-content">
                                        <div class="info-row">
                                            <span class="label">Current Grade:</span>
                                            <span class="value"><span class="badge">Grade <%= student.getGrade() %>
                                                </span></span>
                                        </div>
                                        <div class="info-row">
                                            <span class="label">Roll Number:</span>
                                            <span class="value">
                                                <%= student.getRollNumber() %>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="right-column">
                                <div class="info-card">
                                    <h3><i class="fas fa-address-book"></i> Contact Info</h3>
                                    <div class="info-content">
                                        <div class="info-row">
                                            <span class="label">Email Address:</span>
                                            <span class="value">
                                                <a href="mailto:<%= student.getEmail() %>" class="contact-link">
                                                    <%= student.getEmail() %>
                                                </a>
                                            </span>
                                        </div>
                                        <div class="info-row">
                                            <span class="label">Phone Number:</span>
                                            <span class="value">
                                                <a href="tel:<%= student.getPhone() %>" class="contact-link">
                                                    <%= student.getPhone() %>
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="info-card">
                                    <h3><i class="fas fa-info-circle"></i> System Data</h3>
                                    <div class="info-content">
                                        <div class="info-row">
                                            <span class="label">Student ID:</span>
                                            <span class="value">#<%= student.getId() %></span>
                                        </div>
                                        <div class="info-row">
                                            <span class="label">Created:</span>
                                            <span class="value">
                                                <%= student.getCreatedAt() !=null ?
                                                    student.getCreatedAt().format(dateFormatter) : "N/A" %>
                                            </span>
                                        </div>
                                        <div class="info-row">
                                            <span class="label">Last Updated:</span>
                                            <span class="value">
                                                <%= student.getUpdatedAt() !=null ?
                                                    student.getUpdatedAt().format(dateFormatter) : "N/A" %>
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <div class="danger-zone">
                                    <h3><i class="fas fa-exclamation-triangle"></i> Danger Zone</h3>
                                    <p>Deleting a student is permanent.</p>
                                    <button onclick="confirmDelete('<%= student.getId() %>')"
                                        class="btn btn-danger btn-sm" style="width: 100%;">
                                        <i class="fas fa-trash"></i> Delete Student
                                    </button>
                                </div>
                            </div>
                        </div>


                        <footer class="footer">
                            <p>&copy; 2025 EduDesk. Built with <i class="fas fa-heart" style="color: #ef4444;"></i>
                                using Java & JSP</p>
                        </footer>
                </div>

                <script src="js/theme-switcher.js"></script>
                <script>
                    function confirmDelete(id) {
                        if (confirm('Are you sure you want to delete this student? This action cannot be undone.')) {
                            window.location.href = 'student?action=delete&id=' + id;
                        }
                    }

                    function printDetails() {
                        window.print();
                    }
                </script>
            </body>

            </html>