package com.studdesk.service;

import com.studdesk.model.Student;
import java.util.List;

// Service interface for Student business logic.

public interface StudentService {

    /**
     * Add a new student with validation
     * 
     * @param student Student object to add
     * @return true if successful, false otherwise
     */
    boolean addStudent(Student student);

    /**
     * Update student with validation
     * 
     * @param student Student object with updated data
     * @return true if successful, false otherwise
     */
    boolean updateStudent(Student student);

    /**
     * Delete a student
     * 
     * @param id Student ID
     * @return true if successful, false otherwise
     */
    boolean deleteStudent(int id);

    /**
     * Get student by ID
     * 
     * @param id Student ID
     * @return Student object if found, null otherwise
     */
    Student getStudentById(int id);

    /**
     * Get student by roll number
     * 
     * @param rollNumber Student roll number
     * @return Student object if found, null otherwise
     */
    Student getStudentByRollNumber(String rollNumber);

    /**
     * Search students by name
     * 
     * @param name Student name or partial name
     * @return List of matching students
     */
    List<Student> searchStudentsByName(String name);

    /**
     * Get all students
     * 
     * @return List of all students
     */
    List<Student> getAllStudents();

    /**
     * Validate student data
     * 
     * @param student Student object to validate
     * @return Error message if validation fails, null if valid
     */
    String validateStudent(Student student);

    /**
     * Get paginated list of students
     * 
     * @param page     Page number (1-based)
     * @param pageSize Number of students per page
     * @return List of students for the requested page
     */
    List<Student> getStudentsPaginated(int page, int pageSize);

    /**
     * Get total count of students
     * 
     * @return Total number of students
     */
    int getTotalStudentCount();

    /**
     * Search students based on multiple criteria
     * 
     * @param criteria Search criteria object
     * @return List of matching students
     */
    List<Student> searchStudents(com.studdesk.dto.StudentSearchCriteria criteria);
}
