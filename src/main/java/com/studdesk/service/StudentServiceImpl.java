package com.studdesk.service;

import com.studdesk.dao.StudentDAO;
import com.studdesk.dao.StudentDAOImpl;
import com.studdesk.model.Student;

import java.util.List;
import java.util.regex.Pattern;

// Implementation of StudentService interface.

public class StudentServiceImpl implements StudentService {

    private final StudentDAO studentDAO;

    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    // Phone validation pattern (10 digits)
    private static final Pattern PHONE_PATTERN = Pattern.compile("^[0-9]{10}$");

    public StudentServiceImpl() {
        this.studentDAO = new StudentDAOImpl();
    }

    @Override
    public boolean addStudent(Student student) {
        // Validate student data
        String validationError = validateStudent(student);
        if (validationError != null) {
            System.err.println("Validation error: " + validationError);
            return false;
        }

        // Check if roll number already exists
        if (studentDAO.rollNumberExists(student.getRollNumber())) {
            System.err.println("Roll number already exists: " + student.getRollNumber());
            return false;
        }

        return studentDAO.save(student);
    }

    @Override
    public boolean updateStudent(Student student) {

        String validationError = validateStudent(student);
        if (validationError != null) {
            System.err.println("Validation error: " + validationError);
            return false;
        }
        Student existingStudent = studentDAO.findById(student.getId());
        if (existingStudent == null) {
            System.err.println("Student not found with ID: " + student.getId());
            return false;
        }
        if (!existingStudent.getRollNumber().equals(student.getRollNumber())) {
            if (studentDAO.rollNumberExists(student.getRollNumber())) {
                System.err.println("Roll number already exists: " + student.getRollNumber());
                return false;
            }
        }
        return studentDAO.update(student);
    }

    @Override
    public boolean deleteStudent(int id) {
        return studentDAO.delete(id);
    }

    @Override
    public Student getStudentById(int id) {
        return studentDAO.findById(id);
    }

    @Override
    public Student getStudentByRollNumber(String rollNumber) {
        return studentDAO.findByRollNumber(rollNumber);
    }

    @Override
    public List<Student> searchStudentsByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return studentDAO.findAll();
        }
        return studentDAO.findByName(name.trim());
    }

    @Override
    public List<Student> getAllStudents() {
        return studentDAO.findAll();
    }

    @Override
    public String validateStudent(Student student) {
        if (student.getFullName() == null || student.getFullName().trim().isEmpty()) {
            return "Full name is required";
        }

        if (student.getRollNumber() == null || student.getRollNumber().trim().isEmpty()) {
            return "Roll number is required";
        }

        if (student.getGrade() == null || student.getGrade().trim().isEmpty()) {
            return "Grade is required";
        }

        if (student.getEmail() == null || student.getEmail().trim().isEmpty()) {
            return "Email is required";
        }

        if (student.getPhone() == null || student.getPhone().trim().isEmpty()) {
            return "Phone number is required";
        }

        if (!EMAIL_PATTERN.matcher(student.getEmail().trim()).matches()) {
            return "Invalid email format";
        }
        if (!PHONE_PATTERN.matcher(student.getPhone().trim()).matches()) {
            return "Phone number must be exactly 10 digits";
        }

        return null;
    }

    @Override
    public List<Student> getStudentsPaginated(int page, int pageSize) {
        int offset = (page - 1) * pageSize;
        return studentDAO.findAllPaginated(offset, pageSize);
    }

    @Override
    public int getTotalStudentCount() {
        return studentDAO.getTotalCount();
    }

    @Override
    public List<Student> searchStudents(com.studdesk.dto.StudentSearchCriteria criteria) {
        return studentDAO.searchStudents(criteria);
    }
}
