<%
    String state = request.getParameter("state");
%>
<HTML>
    <HEAD>
        <LINK REL="stylesheet" TYPE="text/css" HREF="styles/styles.css"/>
        <SCRIPT LANGUAGE="JAVASCRIPT">
            function validate()
            {
                if (document.forms.main.username.value == "")
                {
                    alert("Username cannot be empty.");
                    return false;
                }
                else if (document.forms.main.password.value == "")
                {
                    alert("Password cannot be empty.");
                    return false;
                }
                else if (document.forms.main.password.value.length <= 3)
                {
                    alert("Password must be at least 4 characters.");
                    return false;
                }
                return true;
            }
        </SCRIPT>
    
    <title>Log In</title></HEAD>

    <BODY>
        <FORM NAME="main" ACTION="Validate.jsp" METHOD="POST">
        <%
            if (state != null && state.equals("error"))
            {
        %>
                <TABLE>
                    <TR CLASS="redStyle">
                        <TD COLSPAN=2>Username / password combination is incorrect.  Please try again.</TD>
                    </TR>
                </TABLE>
        <%
            }   // if (state != null ..
        %>
            <TABLE>
                <TR CLASS="defaultText">
                    <TD>Username:</TD>
                    <TD><INPUT TYPE="text" NAME="username"></INPUT></TD>
                </TR>
                <TR CLASS="defaultText">
                    <TD>Password:</TD>
                    <TD><INPUT TYPE="password" NAME="password"></INPUT></TD>
                </TR>
                <TR>
                    <TD COLSPAN=2 ALIGN="center">
                        <INPUT TYPE="submit" VALUE="Submit" onClick="return validate()"></INPUT>
                    </TD>
                </TR>
            </TABLE>
        </FORM>
    </BODY>
</HTML>

