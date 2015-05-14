<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<% DecimalFormat df = new DecimalFormat("$#,##0.00"); %>

<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css"/>
    <title>View Orders</title></HEAD>
    <BODY>
    
    <%
	    String userId = request.getParameter("userid");
	    int customerId = 0;
	    String firstName, lastName, wholeName, userName;
	    
	    int orderId = 0;
	    double orderValue = 0.0;
	    String submitDate = "";
	    
	    int orderIdForDet = 0;
	    double orderValueForDet = 0;
	    String orderSubmitDateForDet = "";
	    
	    String strClass = "tableOddRow";
	    
	    boolean found;
	    
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection connection = 
			DriverManager.getConnection("jdbc:mysql://localhost:3306/salesdatabase?user=java&password=java");
			Statement statement = connection.createStatement();
			
			String sqlGetUserInfo = 
				"select cs.customer_id, cs.first_name, cs.last_name, u.username, u.user_id from customer cs left outer join " +
				"user u on cs.customer_id = u.customer_id where u.user_id = " + userId + "";
			
			ResultSet rsUserInfo = statement.executeQuery(sqlGetUserInfo);
	
			while (rsUserInfo.next())
			{
				customerId = rsUserInfo.getInt("customer_id");
				firstName = rsUserInfo.getString("first_name");
				lastName = rsUserInfo.getString("last_name");
				userName = rsUserInfo.getString("username");
				wholeName = firstName + " " + lastName;	
    %>
    
    	<TABLE ALIGN="left">
    		<TR CLASS="defaultText">
    			<TD>Customer Id:</TD>
    			<TD><%= customerId %></TD>
    		</TR>
    		<TR CLASS="defaultText">
    			<TD>User Id:</TD>
    			<TD><%= userId %></TD>
    		</TR>
    		<TR CLASS="defaultText">
    			<TD>Username:</TD>
    			<TD><%= userName %></TD>
    		</TR>
    		<TR CLASS="defaultText">
    			<TD>Name:</TD>
    			<TD><%= wholeName %></TD>
    		</TR>
    	
    	</TABLE>
    	
    <%
    	
    %>
    	
    	<BR>
    	<BR>
    	<BR>
    	<BR>
    	<BR>
    	
    <%
    	Statement getOrders = connection.createStatement();
		
			String sqlGetOrders = "select os.submit_date, od.order_id, sum(i.item_price * od.item_qty) as order_value " +
				"from order_submitted os left outer join order_detail od on os.order_id = od.order_id right outer join " +
				"item i on i.item_id = od.item_id where os.user_id = " + userId + " group by order_id";

			ResultSet rsGetOrders = getOrders.executeQuery(sqlGetOrders);
		%>
	
			<TABLE ALIGN="left">
				<TR><TD COLSPAN=5><HR></TD></TR>
				<TR CLASS="defaultText">
				    <TD>Order ID</TD>
				    <TD>Order Value</TD>
				    <TD>Submit Date</TD>
				    <TD>&nbsp</TD>
				</TR>
			<TR><TD COLSPAN=5><HR></TD></TR>
	
		<%	
			while (rsGetOrders.next())
			{
				// Toggle style class for next row:
				if (strClass.equals("tableEvenRow")) strClass = "tableOddRow";
				else strClass = "tableEvenRow";
				
				orderId = rsGetOrders.getInt("order_id");
				orderValue = rsGetOrders.getDouble("order_value");
				submitDate = rsGetOrders.getString("submit_date");
		%>
		    	
		  <TR CLASS="<%= strClass %>">
		  <TD><%= orderId %></TD>
		  <TD><%= df.format(orderValue) %></TD>
		  <TD><%= submitDate %></TD>
  	
  <!-- marker -->             
  	
  	<%
			Statement statementCheckForOrderDetails = connection.createStatement();
			String sqlCheckForOrderDetails
			    = "select os.submit_date, od.order_id, od.item_qty, i.item_id, i.item_name, i.item_price, " +
			      "sum(i.item_price * od.item_qty) as order_value from item i left join order_detail od on " +
			      "i.item_id = od.item_id right join order_submitted os on os.order_id = od.order_id " +
			      "where od.order_id = " + orderId + "";
			      
			ResultSet rsCheckForOrderDetails = statementCheckForOrderDetails.executeQuery(sqlCheckForOrderDetails);
			
			found = rsCheckForOrderDetails.next();
			
			if (found)
			{	
				orderIdForDet = rsCheckForOrderDetails.getInt("order_id");
				orderValueForDet = rsCheckForOrderDetails.getDouble("order_value");
				orderSubmitDateForDet = rsCheckForOrderDetails.getString("submit_date");
		%>
			
			<TD>
					<SCRIPT LANGUAGE="JAVASCRIPT">
						function setFormParmsSubmit<%= orderIdForDet %>()
						{
							//alert("test");
							document.write('<HTML><BODY><FORM NAME ="main" ACTION="ViewOrderDetails.jsp" METHOD="POST">\
							<INPUT TYPE="hidden" NAME="orderid" value ="<%= orderIdForDet %>"><\/INPUT>\
							<INPUT TYPE="hidden" NAME="ordervalue" value ="<%= orderValueForDet %>"><\/INPUT>\
							<INPUT TYPE="hidden" NAME="submitdate" value ="<%= orderSubmitDateForDet %>"><\/INPUT>\
							<INPUT TYPE="hidden" NAME="customerid" value ="<%= customerId %>"><\/INPUT>\
							<INPUT TYPE="hidden" NAME="userid" value ="<%= userId %>"><\/INPUT>\
							<INPUT TYPE="hidden" NAME="username" value ="<%= userName %>"><\/INPUT>\
							<INPUT TYPE="hidden" NAME="wholename" value ="<%= wholeName %>"><\/INPUT>\
							<\/FORM>\
							<\/BODY><SCRIPT LANGUAGE="JAVASCRIPT>document.main.submit()<\/SCRIPT><\/HTML>');
						}
					</SCRIPT>					
					
					<A HREF="#" onClick="setFormParmsSubmit<%= orderIdForDet %>()";>View Details</A>
			
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

  <!-- end marker -->              

      </TR>
    <%
			}
		}
		%>
	
        </TABLE>
    </BODY>
</HTML>