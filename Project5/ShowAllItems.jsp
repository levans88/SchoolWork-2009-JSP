<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<% DecimalFormat df = new DecimalFormat("$#,##0.00"); %>

<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css"/>
    <title>Select your items</title></HEAD>
    <BODY>
        <FORM NAME="main" ACTION="SelectMore.jsp" METHOD="POST">
            <TABLE ALIGN="center">
                <TR CLASS="tableEvenRow">
                    <TD></TD> <TD>Item #</td>
                    <TD>Item Name</TD>
                    <TD>Price</TD>
                    <TD>Quantity</TD>
                </TR>
                <%
                	Class.forName("com.mysql.jdbc.Driver").newInstance();
                	Connection connection = 
                	DriverManager.getConnection("jdbc:mysql://localhost:3306/salesdatabase?user=java&password=java");
                	Statement statement = connection.createStatement();
                	String sqlGetItem = "select item_id, item_name, item_price from item";
                	ResultSet rs = statement.executeQuery(sqlGetItem);
                	
                	int itemId;
                	double itemPrice;
                	String itemName;
                	String strClass = "tableEvenRow";
                	
                	while (rs.next())
                	{
                		itemId = rs.getInt("item_id");
                		itemName = rs.getString("item_name");
                		itemPrice = rs.getDouble("item_price");
                		
                		if (strClass.equals("tableEvenRow")) strClass = "tableOddRow";
                		else strClass = "tableEvenRow";
                %>
		
        		<TR CLASS="<%= strClass%>">
        			<TD><INPUT TYPE="checkbox" NAME="<%=itemName.toLowerCase() + "Select" %>"></INPUT></TD>
        			<TD><%= itemId %></TD>
        			<TD><%= itemName %></TD>
        			<TD><%= df.format(itemPrice) %></TD>
        			<TD><INPUT TYPE="text" NAME="<%= itemName.toLowerCase() + "Qty"%>" size="3" value="1"></INPUT></TD>
        		</TR>
                
    			<%
    				}
    			%>

                <TR>
                    <TD ALIGN="center" COLSPAN=5>
                        <INPUT TYPE="submit" VALUE="Submit"</INPUT>
                    </TD>
                </TR>
            </TABLE>
        </FORM>
    </BODY>
</HTML>

