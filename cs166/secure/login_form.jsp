<%@include file="csrftoken.jsp" %>
<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>

	<form method="post" action="login_action.jsp">
	<label>Login ID:</label><input name="user" /><br>
	<label>Password:</label> <input name="pass" type="password" /><br>
	<input type="submit" value="login"/>
	<input type="hidden" name="csrftoken" value=<% out.print(csrftoken); %>/>
	</form>
	<jsp:include page= "priv_foot.html"/>

</body>
</html>