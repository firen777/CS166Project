<%@include file="csrftoken.jsp" %>
<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<h1>Note: This page is vulnerable to SQL injection attack!</h1>
	<p>To execute the attack, type:</p>
	 <p><code>a' OR '1'='1'; -- a</code></p>
	 <p>and type anything on the password. (Website redirect back to login_form if field is empty.)</p>
	 <p>
		The -- will comment out the rest of the code in the supposed query. <br/>
		This unsanitized code will be evaluated as TRUE, thus you can login as the first user created in the database, <br/>
		most likely an admin account. <br/>
	</p>
	<form method="post" action="login_action.jsp">
	<label>Login ID:</label><input name="user" /><br>
	<label>Password:</label> <input name="pass" type="password" /><br>
	<input type="submit" value="login"/>
	<input type="hidden" name="csrftoken" value=<% out.print(csrftoken); %>/>
	</form>
<jsp:include page= "priv_foot.html"/>
</body>
</html>