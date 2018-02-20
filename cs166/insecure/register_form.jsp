<%@include file="csrftoken.jsp" %>

<html>
<head>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1>My Information Security Blog</h1>
<h2>Please register</h2>
<form action="register_action.jsp" method="post">
	<label>Your Name:</label><input name="fullname" /><br>
	<label>Login ID:</label><input name="user" /><br>
	<label>Password:</label> <input name="pass" type="password" /><br>
	<input name="role" type="radio" value="normal" checked> Normal
	<input name="role" type="radio" value="admin"> Admin
	<br>
	<input type="submit" value="Register"/>
	<input type="hidden" name="csrftoken" value=<% out.print(csrftoken); %>/>
</form>

<jsp:include page= "priv_foot.html"/>
</body>
</html>