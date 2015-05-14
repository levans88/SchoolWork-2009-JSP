<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    boolean bPenSelect = false, bPencilSelect = false, bEraserSelect = false;
    String penQty = "1", pencilQty = "1", eraserQty = "1";
    double totalBill = 0.0; String penSelect = request.getParameter("penSelect");

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

    DecimalFormat df = new DecimalFormat("#,##0.00");
%>


<%
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection connection = 
    DriverManager.getConnection("jdbc:mysql://localhost:3306/salesdatabase?user=java&password=java");
    Statement statement = connection.createStatement();

    ResultSet rsMaxOrderId = statement.executeQuery("select max( order_id ) as \"maxOrderId\" from order_submitted");
    int maxOrderIdVar = 0;
    int writeOrderId = 0;

    while (rsMaxOrderId.next())
    {
    	maxOrderIdVar = rsMaxOrderId.getInt("maxOrderId");
    }
    writeOrderId = maxOrderIdVar + 1;

    String sqlInsertOrder =
        "insert into order_submitted (order_id, user_id, submit_date) values " +
        "(" + writeOrderId + ", " + session.getAttribute("USER_ID") + ", current_timestamp)";
    statement.executeUpdate(sqlInsertOrder);
%>


<%
    ResultSet rsMaxOrderDetailId = statement.executeQuery("select max( order_detail_id ) as \"maxOrderDetailId\" from order_detail");
    int maxOrderDetailIdVar = 0;
    int writeOrderDetailId = 0;

    while (rsMaxOrderDetailId.next())
    {
    	maxOrderDetailIdVar = rsMaxOrderDetailId.getInt("maxOrderDetailId");
    }
    writeOrderDetailId = maxOrderDetailIdVar;

    int itemId = 0;
    int itemQty = 0;
%>


<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css"/>
    <title>Thank you for your order</title></HEAD>
    <BODY>
        <SPAN CLASS="defaultText">Thank you, <%= session.getAttribute("FULL_NAME") %>, for your order!  The details of your order are as follows:</SPAN><br><br>
        <TABLE>
            <TR CLASS="tableEvenRow">
                <TD>Item #</TD>
                <TD>Item Name</TD>
                <TD>Price</TD>
                <TD>Quantity</TD>
            </TR>
            <% 
                if (bPenSelect) 
                {
                    writeOrderDetailId = writeOrderDetailId + 1;
                    itemId = 101;
                    itemQty = Integer.parseInt(penQty);
                    
                    String sqlInsertOrderDetail = 
        		    "insert into order_detail (order_detail_id, order_id, item_id, item_qty) values (" + writeOrderDetailId + ", " + writeOrderId + ", " + itemId + ", " + itemQty + ")";               
                    statement.executeUpdate(sqlInsertOrderDetail);
                
            %> 
                <TR CLASS="tableOddRow">
                    <TD>101</TD>
                    <TD>Pen</TD>
                    <TD>$2.00</TD>
                    <TD ALIGN="CENTER"><%= penQty %></TD>
                </TR>
            <% 
                }
                
                if (bPencilSelect) 
                {
                    writeOrderDetailId = writeOrderDetailId + 1;
                    itemId = 102;
                    itemQty = Integer.parseInt(pencilQty);
    		
                    String sqlInsertOrderDetail = 
        		        "insert into order_detail (order_detail_id, order_id, item_id, item_qty) values (" + writeOrderDetailId + ", " + writeOrderId + ", " + itemId + ", " + itemQty + ")"; 
                    statement.executeUpdate(sqlInsertOrderDetail);
            %>
                <TR CLASS="tableEvenRow">
                    <TD>102</TD>
                    <TD>Pencil</TD>
                    <TD>$1.00</TD>
                    <TD ALIGN="CENTER"><%= pencilQty %></TD>
                </TR>
            <% 
                }

                if (bEraserSelect)
                {
                    writeOrderDetailId = writeOrderDetailId + 1;
                    itemId = 103;
                    itemQty = Integer.parseInt(eraserQty);
    		
                    String sqlInsertOrderDetail = 
                        "insert into order_detail (order_detail_id, order_id, item_id, item_qty) values (" + writeOrderDetailId + ", " + writeOrderId + ", " + itemId + ", " + itemQty + ")"; 
                    statement.executeUpdate(sqlInsertOrderDetail);
            %>
                <TR CLASS="tableOddRow">
                    <TD>103</TD>
                    <TD>Eraser</TD>
                    <TD>$0.50</TD>
                    <TD ALIGN="CENTER"><%= eraserQty %></TD>
                </TR>
            <%
                }
            %>
            <TR><TD COLSPAN=4><HR></TD></TR>
            
            <TR CLASS="defaultText">
                <TD COLSPAN=4 ALIGN="center"> Total Bill: $<%= df.format(totalBill) %></TD>
            </TR>
            <TR>
                <TD COLSPAN=4> <HR></TD>
            </TR>
        </TABLE>
    </BODY>
</HTML>

