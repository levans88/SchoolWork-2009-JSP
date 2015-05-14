<%@ page import="java.sql.*" %>
<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css" />
    <title>Customer List</title></HEAD>
    <BODY>
        
        <TABLE>
            <TR><TD COLSPAN=5><HR></TD></TR>
            <TR CLASS="defaultText">
                <TD>Customer ID</TD>
                <TD>Customer Name</TD>
                <TD>Username</TD>
                <TD>&nbsp</TD>
            </TR>
            <TR><TD COLSPAN=5><HR></TD></TR>
            
    	<%
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        Connection connection =
        DriverManager.getConnection("jdbc:mysql://localhost:3306/salesdatabase?user=java&password=java");
        Statement statement = connection.createStatement();
        String sqlGetCustomerUserList
            = "select cs.customer_id, cs.first_name, cs.last_name, u.username, u.user_id from customer cs " +
              "left outer join user u on cs.customer_id = u.customer_id";
        ResultSet rs = statement.executeQuery(sqlGetCustomerUserList);

        int customerId = 0;
        int userId = 0;
        String firstName, lastName, wholeName, userName;
        String strClass = "tableOddRow";
        boolean found;

				while (rs.next())
				{
					customerId = rs.getInt("customer_id");
					firstName= rs.getString("first_name");
					lastName = rs.getString("last_name");
					wholeName = firstName + " " + lastName;
					userName = rs.getString("username");

					// Toggle style class for next row:
					if (strClass.equals("tableEvenRow")) strClass = "tableOddRow";
					else strClass = "tableEvenRow";
			%>

					  <TR CLASS="<%= strClass%>"> 
						<TD align=center><%= customerId %></TD>
						<TD><%= wholeName %></TD>
			
			<%
				if (userName !=null)
				{
			%>
						<TD><%= userName%></TD>
			<%
				}
				else
				{
			%>
						<TD>&nbsp</TD>
			<%
				}
			%>
			
			<%
				Statement statementCheckForOrders = connection.createStatement();
				String sqlCheckForOrders
				    = "select distinct c.customer_id, u.user_id from customer c, order_submitted os, user u " +
				      "where os.user_id = u.user_id and u.customer_id = c.customer_id and c.customer_id = " + customerId + "";
				ResultSet rsCheckForOrders = statementCheckForOrders.executeQuery(sqlCheckForOrders);
			
				found = rsCheckForOrders.next();
				
				if (found)
				{
					userId = rsCheckForOrders.getInt("user_id");	
				%>	
						<TD>
							<SCRIPT LANGUAGE="JAVASCRIPT">
								function setUseridSubmit<%= userId %>()
								{
									//alert("test");
									document.write('<HTML><BODY><FORM NAME ="main" ACTION="ViewOrders.jsp" METHOD="POST">\
									<INPUT TYPE="hidden" NAME="userid" value ="<%= userId %>"><\/INPUT><\/FORM>\
									<\/BODY><SCRIPT LANGUAGE="JAVASCRIPT>document.main.submit()<\/SCRIPT><\/HTML>');
								}
							</SCRIPT>					
							
							<A HREF="#" onClick="setUseridSubmit<%= userId %>()";>View Orders</A>
						</TD>					
				<%
				}
				else
				{
				%>
					<TD>&nbsp</TD>
				<%
				}
			%>
			
		    	</TR>
		    
			<%
			
		}
			%>

					<TR><TD COLSPAN=5><HR></TD></TR>
        </TABLE>
    </BODY>
</HTML>

