package com.studdesk.dao;

import com.studdesk.model.Student;
import com.studdesk.dto.StudentSearchCriteria;
import com.studdesk.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Implementation of StudentDAO interface using JDBC.

public class StudentDAOImpl implements StudentDAO {

    @Override
    public boolean save(Student student) {
        String sql = "INSERT INTO students (full_name, roll_number, grade, email, phone, gender, date_of_birth) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getFullName());
            stmt.setString(2, student.getRollNumber());
            stmt.setString(3, student.getGrade());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, student.getPhone());
            stmt.setString(6, student.getGender());
            stmt.setDate(7, student.getDateOfBirth() != null ? Date.valueOf(student.getDateOfBirth()) : null);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error saving student: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(Student student) {
        String sql = "UPDATE students SET full_name = ?, roll_number = ?, grade = ?, email = ?, phone = ?, gender = ?, date_of_birth = ? WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, student.getFullName());
            stmt.setString(2, student.getRollNumber());
            stmt.setString(3, student.getGrade());
            stmt.setString(4, student.getEmail());
            stmt.setString(5, student.getPhone());
            stmt.setString(6, student.getGender());
            stmt.setDate(7, student.getDateOfBirth() != null ? Date.valueOf(student.getDateOfBirth()) : null);
            stmt.setInt(8, student.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating student: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM students WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting student: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Student findById(int id) {
        String sql = "SELECT * FROM students WHERE id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error finding student by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public Student findByRollNumber(String rollNumber) {
        String sql = "SELECT * FROM students WHERE roll_number = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, rollNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }

        } catch (SQLException e) {
            System.err.println("Error finding student by roll number: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public List<Student> findByName(String name) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE full_name LIKE ? ORDER BY full_name";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + name + "%");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error finding students by name: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    @Override
    public List<Student> findAll() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY CAST(roll_number AS UNSIGNED) ASC";

        try (Connection conn = DatabaseUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error finding all students: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    @Override
    public boolean rollNumberExists(String rollNumber) {
        String sql = "SELECT COUNT(*) FROM students WHERE roll_number = ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, rollNumber);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("Error checking roll number existence: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Student> findAllPaginated(int offset, int limit) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY CAST(roll_number AS UNSIGNED) ASC LIMIT ? OFFSET ?";

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error finding paginated students: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    @Override
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) FROM students";

        try (Connection conn = DatabaseUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            System.err.println("Error getting total student count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    @Override
    public List<Student> searchStudents(StudentSearchCriteria criteria) {
        List<Student> students = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM students WHERE 1=1");
        List<Object> parameters = new ArrayList<>();

        if (criteria.getName() != null && !criteria.getName().trim().isEmpty()) {
            sql.append(" AND full_name LIKE ?");
            parameters.add("%" + criteria.getName().trim() + "%");
        }

        if (criteria.getRollNumber() != null && !criteria.getRollNumber().trim().isEmpty()) {
            sql.append(" AND roll_number LIKE ?");
            parameters.add("%" + criteria.getRollNumber().trim() + "%");
        }

        if (criteria.getGrade() != null && !criteria.getGrade().trim().isEmpty()) {
            sql.append(" AND grade = ?");
            parameters.add(criteria.getGrade().trim());
        }

        if (criteria.getEmail() != null && !criteria.getEmail().trim().isEmpty()) {
            sql.append(" AND email LIKE ?");
            parameters.add("%" + criteria.getEmail().trim() + "%");
        }

        if (criteria.getGender() != null && !criteria.getGender().trim().isEmpty()) {
            sql.append(" AND gender = ?");
            parameters.add(criteria.getGender().trim());
        }

        String sortBy = criteria.getSortBy();
        String sortOrder = criteria.getSortOrder();

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy.toLowerCase()) {
                case "name":
                case "full_name":
                    sql.append(" ORDER BY full_name");
                    break;
                case "rollnumber":
                case "roll_number":
                    sql.append(" ORDER BY CAST(roll_number AS UNSIGNED)");
                    break;
                case "grade":
                    sql.append(" ORDER BY grade");
                    break;
                case "email":
                    sql.append(" ORDER BY email");
                    break;
                case "gender":
                    sql.append(" ORDER BY gender");
                    break;
                default:
                    sql.append(" ORDER BY CAST(roll_number AS UNSIGNED)");
            }

            if (sortOrder != null && sortOrder.trim().equalsIgnoreCase("DESC")) {
                sql.append(" DESC");
            } else {
                sql.append(" ASC");
            }
        } else {
            sql.append(" ORDER BY CAST(roll_number AS UNSIGNED) ASC");
        }

        try (Connection conn = DatabaseUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < parameters.size(); i++) {
                stmt.setObject(i + 1, parameters.get(i));
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error searching students: " + e.getMessage());
            e.printStackTrace();
        }

        return students;
    }

    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setFullName(rs.getString("full_name"));
        student.setRollNumber(rs.getString("roll_number"));
        student.setGrade(rs.getString("grade"));
        student.setEmail(rs.getString("email"));
        student.setPhone(rs.getString("phone"));
        student.setGender(rs.getString("gender"));

        Date dob = rs.getDate("date_of_birth");
        if (dob != null) {
            student.setDateOfBirth(dob.toLocalDate());
        }

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            student.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            student.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return student;
    }
}
