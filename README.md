# 🎓 StudDesk - Student Management System

> A modern, feature-rich student management system built with Java, focusing on simplicity and efficiency.

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()
[![Java](https://img.shields.io/badge/Java-17+-orange.svg)]()

## ✨ Overview

StudDesk is a comprehensive student management platform designed for schools and educational institutions. It provides an intuitive interface for managing student records, tracking academic performance, and generating insightful analytics—all wrapped in a beautiful, modern UI with both light and dark mode support.

## 🚀 Features

### 📋 Core Functionality
- **Student Management** - Complete CRUD operations for student records
- **Advanced Search** - Multi-criteria search with filters (Name, Roll Number, Grade)
- **Pagination** - Efficient browsing through large student databases
- **Print Support** - Clean, professional printouts of student lists and details

### 🎨 User Experience
- **Dark Mode** - Eye-friendly dark theme with seamless switching
- **Responsive Design** - Works beautifully on desktop, tablet, and mobile
- **Modern UI** - Clean, intuitive interface with smooth animations
- **Accessibility** - WCAG-compliant design for inclusive access

### 📊 Analytics & Reporting
- **Dashboard Analytics** - Visual charts showing grade distribution and gender statistics
- **Performance Metrics** - Quick stats on total students and growth trends
- **Export Options** - CSV export for data analysis in external tools

### 🔍 Search & Filter
- **Smart Search** - Find students by name, roll number, or grade instantly
- **Filter Combinations** - Mix multiple criteria for precise results
- **Active Filter Display** - Clear visibility of applied search filters

## 🛠️ Tech Stack

### Backend
- **Java 17+** - Core programming language
- **Servlets & JSP** - Web application framework
- **JDBC** - Database connectivity
- **MySQL** - Relational database

### Frontend
- **HTML5 & CSS3** - Modern web standards
- **JavaScript (ES6+)** - Interactive functionality
- **Chart.js** - Data visualization
- **Font Awesome** - Icon library

### Build & Tools
- **Maven** - Dependency management and build automation
- **Tomcat 7** - Application server
- **Git** - Version control

## 📦 Installation

### Prerequisites
- Java Development Kit (JDK) 17 or higher
- Apache Maven 3.6+
- MySQL Server 8.0+
- Apache Tomcat 7+

### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/StudDesk.git
   cd StudDesk
   ```

2. **Configure Database**
   ```bash
   # Create database
   mysql -u root -p
   CREATE DATABASE edudesk;
   
   # Import schema
   mysql -u root -p edudesk < database/schema.sql
   ```

3. **Update Database Configuration**
   Edit `src/main/java/com/studdesk/util/DatabaseUtil.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/studdesk";
   private static final String USER = "your_username";
   private static final String PASSWORD = "your_password";
   ```

4. **Build the Project**
   ```bash
   mvn clean package
   ```

5. **Run the Application**
   ```bash
   mvn tomcat7:run
   ```

6. **Access the Application**
   Open your browser and navigate to:
   ```
   http://localhost:8081/StudDesk
   ```

## 📖 Usage Guide

### Adding a Student
1. Click **"Add New Student"** button on the dashboard or student list
2. Fill in the student details (Name, Roll Number, Grade, Email, Phone, Gender, DOB)
3. Click **"Submit"** to save

### Searching for Students
1. Navigate to the **Search** page from the navigation menu
2. Enter search criteria (name, roll number, or grade)
3. Click **"Search Students"** to view results
4. Use **"Reset All Filters"** to clear search

### Viewing Student Details
1. Click the **eye icon** (👁️) next to any student in the list
2. View complete student information
3. Use **"Edit Profile"** or **"Delete Student"** as needed

### Printing Student Lists
1. Go to the **Student List** page
2. Click **"Print List"** button
3. All students will be loaded and print dialog will open automatically
4. Configure print settings and print

## 📁 Project Structure

```
StudDesk/
├── src/
│   ├── main/
│   │   ├── java/com/studdesk/
│   │   │   ├── controller/     # Servlets handling requests
│   │   │   ├── dao/           # Data Access Objects
│   │   │   ├── model/         # Entity classes
│   │   │   ├── service/       # Business logic layer
│   │   │   ├── dto/           # Data Transfer Objects
│   │   │   └── util/          # Utility classes
│   │   └── webapp/
│   │       ├── css/           # Stylesheets
│   │       ├── js/            # JavaScript files
│   │       ├── WEB-INF/       # Configuration files
│   │       └── *.jsp          # JSP pages
├── database/                  # Database schema
├── pom.xml                    # Maven configuration
└── README.md                  # Project documentation
```

## 🎨 Screenshots

### Dashboard
![Dashboard](screenshots/dashboard.png)

### Student List
![Student List](screenshots/student-list.png)

### Search Students
![Search](screenshots/search.png)

### Dark Mode
![Dark Mode](screenshots/dark-mode.png)

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines
- Follow Java coding conventions
- Write clean, documented code
- Test thoroughly before submitting PR
- Update README if adding new features

## 🐛 Known Issues

- Select dropdown options may have limited styling on some Windows browsers (native browser limitations)

## 🗺️ Roadmap

- [ ] Bulk student import from CSV
- [ ] Student photo uploads
- [ ] Attendance tracking system
- [ ] Parent portal
- [ ] Report card generation
- [ ] SMS/Email notifications

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/prashantpurwar12)
- LinkedIn: [Your LinkedIn]([https://linkedin.com/in/yourprofile](https://www.linkedin.com/in/prashant-purwar-230966264/))

## 🙏 Acknowledgments

- Font Awesome for the icon library
- Chart.js for beautiful data visualizations
- The Java community for excellent documentation and support

---

<div align="center">
  Made with ❤️ for education
  <br/>
  ⭐ Star this repo if you find it helpful!
</div>
