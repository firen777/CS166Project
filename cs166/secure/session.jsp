<!DOCTYPE html>
<html>
<head>
	<title>Session</title>
</head>
<body>
<fieldset>
<h1>Session Information</h1>
<td>User: </td>
<td><input type="text" value='<%= session.getAttribute("user") %>' /></td> <br>
<td>Username: </td>
<td><input type="text" value='<%= session.getAttribute("username") %>' /></td> <br>
<td>ROLE </td>
<td><input type="text" value='<%= session.getAttribute("DB_role") %>' /></td> <br>
<td>op1: </td>
<td><input type="text" value='<%= session.getAttribute("op1") %>' /></td><br>
<td>op2:</td>
<td><input type="text" value='<%= session.getAttribute("op2") %>' /></td><br>
<td>Captcha Answer: </td>
<td><input type="text" value='<%= session.getAttribute("cap_ans") %>' /></td><br>
<td>synchronized token pattern </td>
<td><input type="text" value='<%= session.getAttribute("form_token") %>' /></td><br>
<br>
<br>
<a href="logout_action.jsp">logout</a>
</fieldset>

</body>
</html>
