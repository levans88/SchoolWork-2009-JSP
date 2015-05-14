<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<% DecimalFormat df = new DecimalFormat("$#,##0.00"); %>

<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css"/>
    <title>View Order Details</title></HEAD>
    <BODY>   
    
    <%
	    String orderId = request.getParameter("orderid");
	    String orderValue = request.getParameter("ordervalue");
	    String submitDate = request.getParameter("submitdate");
	    String customerId = request.getParameter("customerid");
	    String userId = request.getParameter("userid");
	    String userName = request.getParameter("username");
	    String wholeName = request.getParameter("wholename");
	    
	    int itemId = 0;
	    String itemName = "";
	    int itemQty = 0;
	    double itemPrice = 0.0;
	    double itemValue = 0.0;   
	    double orderValueDbl = Double.parseDouble(orderValue);
	    
	    String strClass = "tableOddRow";
    %>
    
	<TABLE ALIGN="left">
		<TR><TD COLSPAN=5><HR></TD></TR>
		<TR CLASS="defaultText">
			<TD>Customer Id:</TD>
			<TD><%= customerId %></TD>
		</TR>
		<TR CLASS="defaultText">
			<TD>User Id:</TD>
			<TD><%= userId %></TD>
		</TR>
		<TR CLASS="defaultText">
			<TD>User Name:</TD>
			<TD><%= userName %></TD>
		</TR>
		<TR CLASS="defaultText">
			<TD>Name:</TD>
			<TD><%= wholeName %></TD>
		</TR>
		<TR CLASS="defaultText">
			<TD>Order Id:</TD>
			<TD><%= orderId %></TD>
		</TR>
		<TR CLASS="defaultText">
			<TD>Order Value:</TD>
			<TD><%= df.format(orderValueDbl) %></TD>
		</TR>
		<TR CLASS="defaultText">
			<TD>Submit Date:</TD>
			<TD><%= submitDate %></TD>
		</TR>
		
		<TR><TD COLSPAN=5><HR></TD></TR>
		
		<TR CLASS="defaultText">
			<TD>Order details:</TD>
		</TR>
		
		<TR><TD COLSPAN=5><HR></TD></TR>
		
		<TR CLASS="defaultText" align=center>
			<TD>Item ID</TD>
			<TD>Item Name</TD>
			<TD>Qty</TD>
			<TD>Price</TD>
			<TD>Value</TD>
		</TR>
		
		<TR><TD COLSPAN=5><HR></TD></TR>
		
		<%
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection connection = 
			DriverManager.getConnection("jdbc:mysql://localhost:3306/salesdatabase?user=java&password=java");
			Statement statement = connection.createStatement();

			String sqlGetOrderDetails =
				"select od.order_id, od.item_qty, i.item_id, i.item_name, i.item_price, " +
				"sum(i.item_price * od.item_qty) as item_value from item i left join order_detail od on " +
				"i.item_id = od.item_id	where order_id = " + orderId + " group by i.item_id";

			ResultSet rsOrderDetails = statement.executeQuery(sqlGetOrderDetails);

			while (rsOrderDetails.next())
			{	
				// Toggle style class for next row:
				if (strClass.equals("tableEvenRow")) strClass = "tableOddRow";
				else strClass = "tableEvenRow";
				
				itemId = rsOrderDetails.getInt("item_id");
				itemName = rsOrderDetails.getString("item_name");
				itemQty = rsOrderDetails.getInt("item_qty");
				itemPrice = rsOrderDetails.getDouble("item_price");
				itemValue = rsOrderDetails.getDouble("item_value");	
    %>
    
				<TR CLASS="<%= strClass %>">
					<TD><%= itemId %></TD>
					<TD><%= itemName %></TD>
					<TD><%= itemQty %></TD>
					<TD><%= df.format(itemPrice) %></TD>
					<TD><%= df.format(itemValue) %></TD>
				</TR>
				
		<%
			}
		%>

		<TR><TD COLSPAN=5><HR></TD></TR>
		<TR CLASS="defaultText">
			<TD>&nbsp</TD>
			<TD>Total Order Value:</TD>
			<TD>&nbsp</TD>
			<TD>&nbsp</TD>
			<TD><%= df.format(orderValueDbl) %></TD>
		</TR>
		<TR><TD COLSPAN=5><HR></TD></TR>
		
    	</TABLE>
    </BODY>
</HTML>