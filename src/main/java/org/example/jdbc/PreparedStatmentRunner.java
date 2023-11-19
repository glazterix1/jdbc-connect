package org.example.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PreparedStatmentRunner {
    public static final String URL = "jdbc:postgresql://localhost:5432/company_repository";
    public static final String USER = "postgres";
    public static final String PASSWORD = "postgres";
    public static final String GET_EMPLOYEE_BY_ID = """
            SELECT *
            FROM company_storage.employee
            WHERE id = ?
            """;

    public static void main(String[] args) throws SQLException {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(GET_EMPLOYEE_BY_ID)) {

            preparedStatement.setInt(1, 4);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                System.out.println(resultSet.getInt("id"));
                System.out.println(resultSet.getString("first_name"));
                System.out.println(resultSet.getInt("salary"));

                System.out.println("________________________________________");
            }
        }
    }
}
