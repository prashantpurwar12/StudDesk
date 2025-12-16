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
import java.io.PrintWriter;
import java.util.List;

/**
 * API endpoint for dashboard analytics data
 */
@WebServlet("/api/students")
public class StudentAPIController extends HttpServlet {

    private StudentService studentService;

    @Override
    public void init() throws ServletException {
        studentService = new StudentServiceImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            List<Student> students = studentService.getAllStudents();

            StringBuilder json = new StringBuilder();
            json.append("{");
            json.append("\"total\":").append(students.size()).append(",");
            json.append("\"students\":[");

            for (int i = 0; i < students.size(); i++) {
                Student student = students.get(i);
                if (i > 0)
                    json.append(",");

                json.append("{");
                json.append("\"id\":").append(student.getId()).append(",");
                json.append("\"name\":\"").append(escapeJson(student.getFullName())).append("\",");
                json.append("\"rollNumber\":\"").append(escapeJson(student.getRollNumber())).append("\",");
                json.append("\"grade\":\"").append(escapeJson(student.getGrade())).append("\",");
                json.append("\"gender\":\"").append(escapeJson(student.getGender())).append("\",");
                json.append("\"email\":\"").append(escapeJson(student.getEmail())).append("\",");
                json.append("\"phone\":\"").append(escapeJson(student.getPhone())).append("\"");

                if (student.getDateOfBirth() != null) {
                    json.append(",\"dateOfBirth\":\"").append(student.getDateOfBirth().toString()).append("\"");
                }

                json.append("}");
            }

            json.append("]");
            json.append("}");

            PrintWriter out = response.getWriter();
            out.print(json.toString());
            out.flush();

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            PrintWriter out = response.getWriter();
            out.print("{\"error\":\"Failed to fetch student data\"}");
            out.flush();
        }
    }

    private String escapeJson(String str) {
        if (str == null)
            return "";
        return str.replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}
