package com.sakadream.test.model;

import java.net.URI;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;

import com.sakadream.test.bean.Employee;

public class Functions {
    Connection conn;
    Statement stmt;

    private void connect() throws Exception {
        Class.forName("org.postgresql.Driver");
        try {
            URI dbUri = new URI("postgres://abc:xxxxxxxxxxxxxxxxxxxx@qdjjtnkv.db.elephantsql.com:5432/fszreuhy");
            String username = dbUri.getUserInfo().split(":")[0];
            String password = dbUri.getUserInfo().split(":")[1];
            String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

            conn = DriverManager.getConnection(dbUrl, username, password);
        } catch(Exception e) {
            URI dbUri = new URI(System.getenv("DATABASE_URL"));
            String username = dbUri.getUserInfo().split(":")[0];
            String password = dbUri.getUserInfo().split(":")[1];
            String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ':' + dbUri.getPort() + dbUri.getPath();

            conn = DriverManager.getConnection(dbUrl, username, password);
        }
    }

    public Boolean checkLogin(String username, String password, HttpSession session) throws Exception {
        connect();
        stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM public.\"USERS\"" 
            + " WHERE \"USERNAME\" LIKE '" + username + "' AND \"PASSWORD\" LIKE '" + password + "'");
        while(rs.next()) {
            session.setAttribute("username", username);
            return true;
        }
        return false;
    }

    public List<Employee> showAllEmployees() throws Exception {
        List<Employee> list = new ArrayList<>();
        connect();
        stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM public.\"EMPLOYEES\" ORDER BY \"ID\" ASC");
        while (rs.next()) {
            Employee e = new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                    rs.getInt(6));
            list.add(e);
        }
        return list;
    }

    public Employee getEmployee(int id) throws Exception {
        connect();
        stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM public.\"EMPLOYEES\" WHERE \"ID\" = " + id);
        while(rs.next()) {
            return new Employee(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
        }
        throw new RuntimeException();
    }

    public void add(Employee e) throws Exception {
        connect();
        stmt = conn.createStatement();
        stmt.executeUpdate("INSERT INTO public.\"EMPLOYEES\" (\"FULLNAME\", \"ADDRESS\", \"EMAIL\", \"PHONE\", \"SALARY\") "
            + "VALUES " 
            + "('" + e.getFullName() + "', '" + e.getAddress() + "', '" + e.getEmail() + "', '" + e.getPhone() + "', '" + e.getSalary() + "')");
        cleanConnection();
    }

    public void edit(int id, Employee e) throws Exception {
        connect();
        stmt = conn.createStatement();
        stmt.executeUpdate("UPDATE \"EMPLOYEES\" "
            + "SET \"FULLNAME\" = '" + e.getFullName() + "', \"ADDRESS\" = '" + e.getAddress() + "', \"EMAIL\" = '" + e.getEmail() + "', "
            + "\"PHONE\" = '" + e.getPhone() + "', \"SALARY\" = " + e.getSalary() + " "
            + "WHERE \"ID\" = " + id);
        cleanConnection();
    }

    public void delete(int id) throws Exception {
        connect();
        stmt = conn.createStatement();
        stmt.executeUpdate("DELETE FROM public.\"EMPLOYEES\" WHERE \"ID\" = " + id);
        cleanConnection();
    }

    public void cleanConnection() throws Exception {
        conn.close();
        stmt.close();
    }

    public void echoQuery(String query) {
        System.out.println(query);
    }

    public Boolean checkSession(HttpSession session) {
        return (session.getAttribute("username") != null) ? true : false;
    }
}