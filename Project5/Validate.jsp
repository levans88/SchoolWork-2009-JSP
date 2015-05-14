<%@ page import="java.util.*, java.sql.*" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/salesdatabase?user=java&password=java");
    Statement statement = connection.createStatement();
    
    ResultSet rsUser = statement.executeQuery(
        "select c.first_name, c.last_name, u.user_id from user u, customer c where u.customer_id = c.customer_id and u.username = '"
		+ username + "' and u.password = '" + password + "'");

    boolean found = false;
    String name = "";
    String userId = "";
    
    while (rsUser.next())
    {
        name = rsUser.getString("first_name") + " " + rsUser.getString("last_name");
        userId = rsUser.getString("user_id");
        found = true;
    }

    if (found)
    {
        session.setAttribute("FULL_NAME", name);
        session.setAttribute("USER_ID", userId);
        response.sendRedirect("ShowAllItems.jsp");
    }
    else response.sendRedirect("Login.jsp?state=error");
%>
