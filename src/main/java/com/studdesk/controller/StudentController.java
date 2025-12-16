package com.studdesk.controller;

import com.studdesk.model.Student;
import com.studdesk.service.StudentService;
import com.studdesk.service.StudentServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

/**
 * Controller servlet handling all student management operations.
 */
@WebServlet("/student")
public class StudentController extends HttpServlet {

    private StudentService studentService;

    @Override
    public void init() throws ServletException {
        studentService = new StudentServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    listStudents(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "view":
                    viewStudent(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteStudent(request, response);
                    break;
                case "printList":
                    printAllStudents(request, response);
                    break;
                case "search":
                    showSearchForm(request, response);
                    break;
                default:
                    listStudents(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    addStudent(request, response);
                    break;
                case "update":
                    updateStudent(request, response);
                    break;
                case "search":
                    searchStudents(request, response);
                    break;
                default:
                    listStudents(request, response);
            }
        } catch (Exception e) {
            throw new ServletException("Error processing request", e);
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        int pageSize = 10;

        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        try {
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        try {
            if (pageSizeParam != null && !pageSizeParam.isEmpty()) {
                pageSize = Integer.parseInt(pageSizeParam);
                if (pageSize != 10 && pageSize != 25 && pageSize != 50) {
                    pageSize = 10;
                }
            }
        } catch (NumberFormatException e) {
            pageSize = 10;
        }

        List<Student> students = studentService.getStudentsPaginated(page, pageSize);
        int totalStudents = studentService.getTotalStudentCount();
        int totalPages = (int) Math.ceil((double) totalStudents / pageSize);
        if (page > totalPages && totalPages > 0) {
            page = totalPages;
            students = studentService.getStudentsPaginated(page, pageSize);
        }

        request.setAttribute("students", students);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalStudents", totalStudents);

        request.getRequestDispatcher("/student-list.jsp").forward(request, response);
    }

    private void printAllStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentService.getAllStudents();
        int totalStudents = students.size();
        request.setAttribute("students", students);
        request.setAttribute("totalStudents", totalStudents);
        request.setAttribute("printMode", true);
        request.getRequestDispatcher("/student-list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/add-student.jsp").forward(request, response);
    }

    private void viewStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Student student = studentService.getStudentById(id);

            if (student != null) {
                request.setAttribute("student", student);
                request.getRequestDispatcher("/student-detail.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Student not found");
                listStudents(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid student ID");
            listStudents(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentService.getStudentById(id);

        if (student != null) {
            request.setAttribute("student", student);
            request.getRequestDispatcher("/edit-student.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Student not found");
            listStudents(request, response);
        }
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Student student = extractStudentFromRequest(request);
            String validationError = studentService.validateStudent(student);
            if (validationError != null) {
                request.setAttribute("errorMessage", validationError);
                request.setAttribute("student", student);
                request.getRequestDispatcher("/add-student.jsp").forward(request, response);
                return;
            }

            boolean success = studentService.addStudent(student);

            if (success) {
                request.setAttribute("successMessage", "Student added successfully!");
                listStudents(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to add student. Roll number may already exist.");
                request.setAttribute("student", student);
                request.getRequestDispatcher("/add-student.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("/add-student.jsp").forward(request, response);
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Student student = extractStudentFromRequest(request);
            student.setId(Integer.parseInt(request.getParameter("id")));

            String validationError = studentService.validateStudent(student);
            if (validationError != null) {
                request.setAttribute("errorMessage", validationError);
                request.setAttribute("student", student);
                request.getRequestDispatcher("/edit-student.jsp").forward(request, response);
                return;
            }

            boolean success = studentService.updateStudent(student);

            if (success) {
                request.setAttribute("successMessage", "Student updated successfully!");
                listStudents(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to update student");
                request.setAttribute("student", student);
                request.getRequestDispatcher("/edit-student.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("/edit-student.jsp").forward(request, response);
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = studentService.deleteStudent(id);

        if (success) {
            request.setAttribute("successMessage", "Student deleted successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to delete student");
        }

        listStudents(request, response);
    }

    private void showSearchForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/search-student.jsp").forward(request, response);
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        com.studdesk.dto.StudentSearchCriteria criteria = new com.studdesk.dto.StudentSearchCriteria();
        criteria.setName(request.getParameter("searchName"));
        criteria.setRollNumber(request.getParameter("searchRollNumber"));
        criteria.setGrade(request.getParameter("searchGrade"));
        criteria.setEmail(request.getParameter("searchEmail"));
        criteria.setGender(request.getParameter("searchGender"));
        criteria.setSortBy(request.getParameter("sortBy"));
        criteria.setSortOrder(request.getParameter("sortOrder"));

        List<Student> students = studentService.searchStudents(criteria);

        request.setAttribute("students", students);
        request.getRequestDispatcher("/search-student.jsp").forward(request, response);
    }

    private Student extractStudentFromRequest(HttpServletRequest request) {
        Student student = new Student();
        student.setFullName(request.getParameter("fullName"));
        student.setRollNumber(request.getParameter("rollNumber"));
        student.setGrade(request.getParameter("grade"));
        student.setEmail(request.getParameter("email"));
        student.setPhone(request.getParameter("phone"));
        student.setGender(request.getParameter("gender"));

        String dobString = request.getParameter("dateOfBirth");
        if (dobString != null && !dobString.trim().isEmpty()) {
            try {
                student.setDateOfBirth(LocalDate.parse(dobString));
            } catch (Exception e) {
            }
        }
        return student;
    }
}
