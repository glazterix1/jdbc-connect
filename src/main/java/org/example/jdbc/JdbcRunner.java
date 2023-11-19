package org.example.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JdbcRunner {
    public static final String URL = "jdbc:postgresql://localhost:5432/company_repository";
    public static final String USER = "postgres";
    public static final String PASSWORD = "postgres";
    public static final String GET_ALL_EMPLOYEE = """
            SELECT *
            FROM company_storage.employee;
            """;

    public static void main(String[] args) throws SQLException {
        try (Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement statement = connection.createStatement()) {

            System.out.println(connection.getSchema());
            System.out.println(connection);

            ResultSet resultSet = statement.executeQuery(GET_ALL_EMPLOYEE);
            while (resultSet.next()) {
                System.out.println(resultSet.getInt("id"));
                System.out.println(resultSet.getString("first_name"));
                System.out.println(resultSet.getInt("salary"));

                System.out.println("________________________________________");
            }
        }
    }
}
