<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>StudDesk - Student Management System</title>
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
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
                        <a href="dashboard.jsp" class="active"><i class="fas fa-home"></i> Dashboard</a>
                        <a href="student?action=list"><i class="fas fa-users"></i> Students</a>

                        <a href="student?action=add"><i class="fas fa-user-plus"></i> Add Student</a>
                        <a href="student?action=search"><i class="fas fa-search"></i> Search</a>
                    </nav>
                </div>
            </header>


            <div class="dashboard-container">
                <div class="hero-card">
                    <h2>Welcome to StudDesk</h2>
                    <p>Manage student records efficiently with our comprehensive system</p>
                </div>

                <div class="stats-container">
                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-users" style="color: #6366f1;"></i></div>
                        <div class="stat-info">
                            <h3>Total Students</h3>
                            <p class="stat-number" id="totalStudents">
                                <span class="loading"></span>
                            </p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-user-plus" style="color: #10b981;"></i></div>
                        <div class="stat-info">
                            <h3>New This Month</h3>
                            <p class="stat-number" id="newStudents">
                                <span class="loading"></span>
                            </p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-graduation-cap" style="color: #f59e0b;"></i></div>
                        <div class="stat-info">
                            <h3>Total Grades</h3>
                            <p class="stat-number" id="totalGrades">
                                <span class="loading"></span>
                            </p>
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-icon"><i class="fas fa-chart-line" style="color: #8b5cf6;"></i></div>
                        <div class="stat-info">
                            <h3>Average Age</h3>
                            <p class="stat-number" id="averageAge">
                                <span class="loading"></span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="analytics-section">
                    <h2 class="section-title"><i class="fas fa-chart-bar"></i> Analytics Dashboard</h2>

                    <div class="charts-grid">
                        <div class="chart-card">
                            <h3><i class="fas fa-chart-pie"></i> Students by Grade</h3>
                            <canvas id="gradeChart"></canvas>
                        </div>

                        <div class="chart-card">
                            <h3><i class="fas fa-venus-mars"></i> Gender Distribution</h3>
                            <canvas id="genderChart"></canvas>
                        </div>

                        <div class="chart-card chart-card-wide">
                            <h3><i class="fas fa-chart-line"></i> Age Distribution</h3>
                            <canvas id="ageChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="actions-grid">
                    <a href="student?action=list" class="action-card">
                        <div class="action-icon"><i class="fas fa-list-ul" style="color: #6366f1;"></i></div>
                        <h3>View All Students</h3>
                        <p>Browse and manage student records</p>
                    </a>

                    <a href="student?action=add" class="action-card">
                        <div class="action-icon"><i class="fas fa-user-plus" style="color: #10b981;"></i></div>
                        <h3>Add New Student</h3>
                        <p>Register a new student in the system</p>
                    </a>
                </div>
            </div>

            <footer class="footer">
                <p>&copy; 2025 StudDesk. Built with <i class="fas fa-heart" style="color: #ef4444;"></i> using Java &
                    JSP
                </p>
            </footer>
        </div>

        <script src="js/theme-switcher.js"></script>
        <script src="js/dashboard-analytics.js"></script>
    </body>

    </html>