<%@ page import="java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    boolean bPenSelect = false, bPencilSelect = false, bEraserSelect = false;
    String penQty = "1", pencilQty = "1", eraserQty = "1";
    double totalBill = 0.0; 
    String penSelect = request.getParameter("penSelect");
    
    if (penSelect != null && penSelect.equals("on"))
    {
        bPenSelect = true;
        penQty = request.getParameter("penQty");
        totalBill += Integer.parseInt(penQty) * 2.00;
    }
    
    String pencilSelect = request.getParameter("pencilSelect");
    
    if (pencilSelect != null && pencilSelect.equals("on"))
    {
        bPencilSelect = true;
        pencilQty = request.getParameter("pencilQty");
        totalBill += Integer.parseInt(pencilQty) * 1.00;
    }
    
    String eraserSelect = request.getParameter("eraserSelect");
    
    if (eraserSelect != null && eraserSelect.equals("on")) 
    {
        bEraserSelect = true;
        eraserQty = request.getParameter("eraserQty");
        totalBill += Integer.parseInt(eraserQty) * 0.50;
    }
    
    DecimalFormat df = new DecimalFormat("$#,##0.00");
%>

<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css"/>
        <SCRIPT>
        function handleCheckout(obj)
        {
            if (obj.value == "Update")
            {
                document.forms.main.action="SelectMore.jsp";
            }
            else if (obj.value == "Checkout")
            {
                document.forms.main.action="Checkout.jsp";
            }
            document.forms.main.submit();
        }
        </SCRIPT>

    <title>Select your items</title></HEAD>
    
    <BODY>
        <FORM NAME="main" METHOD="POST">
            <TABLE ALIGN="center">
                <TR CLASS="tableEvenRow">
                    <TD>&nbsp;</TD>
                    <TD>Item #</TD>
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
                        
                        <%
            				String valueStr = "";
            				if (itemId == 101)
            				{
            					valueStr = penQty;
        				%>
        					<TD><INPUT TYPE="checkbox" NAME="penSelect" <%= (bPenSelect? "CHECKED" : "") %>></INPUT></TD>
        				<%
            				}
            				else if (itemId == 102)
            				{
            					valueStr = pencilQty;
        				%>
        					<TD><INPUT TYPE="checkbox" NAME="pencilSelect" <%= (bPencilSelect? "CHECKED" : "") %>></INPUT></TD>
        				<%
            				}
            				else
            				{
            					valueStr = eraserQty;
        				%>
        					<TD><INPUT TYPE="checkbox" NAME="eraserSelect" <%= (bEraserSelect? "CHECKED" : "") %>></INPUT></TD>
        				<%
        				    }
        				%>
        			
                			<TD><%= itemId %></TD>
                			<TD><%= itemName %></TD>
                			<TD><%= df.format(itemPrice) %></TD>
                			<TD><INPUT TYPE="text" NAME="<%= itemName.toLowerCase() + "Qty"%>" size="3" value="<%= valueStr %>"></INPUT></TD>
                		</TR>
            			<%
                    }
    			%>             
                
                <TR>
                    <TD COLSPAN=5><HR></TD>
                </TR>
                <TR CLASS="defaultText">
                    <TD COLSPAN=5 ALIGN="center"> Total Bill: <%= df.format(totalBill) %></TD>
                </TR>
                <TR>
                    <TD COLSPAN=5><HR></TD>
                </TR>
                <TR>
                    <TD ALIGN="center" COLSPAN=3>
                        <INPUT TYPE="button" NAME="update" VALUE="Update" onclick="handleCheckout (this)"</INPUT>
                    </TD>
                    <TD ALIGN="center" COLSPAN=3>
                        <INPUT TYPE="button" NAME="checkout" VALUE="Checkout" onClick="handleCheckout(this)"></INPUT>
                    </TD>
                </TR>
            </TABLE>
        </FORM>
    </BODY>
</HTML>

