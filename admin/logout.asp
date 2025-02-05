
<%
    Response.Cookies("emp_no") = ""
    Response.Cookies("emp_no").expires = now()
    Response.Cookies("em_pass") = ""
    Response.Cookies("em_pass").expires = now()
    Response.Cookies("nm") = ""
    Response.Cookies("nm").expires = now()
    Response.Cookies("dept_cd") = ""
    Response.Cookies("dept_cd").expires = now() 
%>

<script>
<!--
    location.href = "login.asp";
// -->
</script>
