package com.studdesk.dao;

import com.studdesk.model.Student;
import com.studdesk.dto.StudentSearchCriteria;
import java.util.List;

//Data Access Object interface for Student entity.

public interface StudentDAO {

    /**
     * Save a new student to the database
     * 
     * @param student Student object to save
     * @return true if successful, false otherwise
     */
    boolean save(Student student);

    /**
     * Update an existing student record
     * 
     * @param student Student object with updated data
     * @return true if successful, false otherwise
     */
    boolean update(Student student);

    /**
     * Delete a student by ID
     * 
     * @param id Student ID
     * @return true if successful, false otherwise
     */
    boolean delete(int id);

    /**
     * Find a student by ID
     * 
     * @param id Student ID
     * @return Student object if found, null otherwise
     */
    Student findById(int id);

    /**
     * Find a student by roll number
     * 
     * @param rollNumber Student roll number
     * @return Student object if found, null otherwise
     */
    Student findByRollNumber(String rollNumber);

    /**
     * Find students by name (partial match)
     * 
     * @param name Student name or partial name
     * @return List of matching students
     */
    List<Student> findByName(String name);

    /**
     * Get all students
     * 
     * @return List of all students
     */
    List<Student> findAll();

    /**
     * Check if a roll number already exists
     * 
     * @param rollNumber Roll number to check
     * @return true if exists, false otherwise
     */
    boolean rollNumberExists(String rollNumber);

    /**
     * Get paginated list of students
     * 
     * @param offset Starting index (0-based)
     * @param limit  Number of records to fetch
     * @return List of students for the requested page
     */
    List<Student> findAllPaginated(int offset, int limit);

    /**
     * Get total count of students
     * 
     * @return Total number of students in database
     */
    int getTotalCount();

    /**
     * Search students based on multiple criteria
     * 
     * @param criteria Search criteria object
     * @return List of matching students
     */
    List<Student> searchStudents(StudentSearchCriteria criteria);
}
