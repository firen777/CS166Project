<%@page import="java.util.*" %>
<%@include file="csrftoken.jsp" %>
	<%
		Random rand = new Random();
		int op1 = rand.nextInt(10) + 1;
		int op2 = rand.nextInt(10) + 1;
		int optRand = rand.nextInt(3) + 1;
		char opter;
		int cap_ans;
		switch (optRand) 
		{
			case 1: opter = '+';
			        cap_ans = op1 + op2; 
					break;
			case 2: opter = '-';
					cap_ans = op1 - op2; 
					break;
			case 3: opter = '*';
					cap_ans = op1 * op2; 
					break;
			default: opter = '+';
			         cap_ans = op1 + op2;
			         break;
		}
		 
		//set session values for captcha
		session.setAttribute("op1",op1);
		session.setAttribute("opter" ,opter);		
		session.setAttribute("op2", op2);
		session.setAttribute("cap_ans", cap_ans);	
	%>

<html>
	<head>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<h1>My Information Security Blog</h1>
		<h2>Please register</h2>
		
		<form action="register_action.jsp" method="POST">
			<label>Your Name:</label><input name="fullname" /><br>
			<label>Login ID:</label><input name="user" /><br>
			<label>Password:</label> <input name="pass" type="password" /><br>
			<input name="role" type="radio" value="normal" checked> Normal
			<input name="role" type="radio" value="admin"> Admin
			<br>
			<input type="hidden" name="csrftoken" value=<% out.print(csrftoken); %>/>
			<br>
			<h2>primitive CAPTCHA</h2>
			<h3>Solve the following:</h3><br>
			<h4><%= session.getAttribute("op1") %> 
			 <%= session.getAttribute("opter") %>
			 <%=session.getAttribute("op2") %> </h4>
			<input name="captcha" />  <br>
			<input type="submit" value="Register"/>
		</form>
		
		<jsp:include page= "priv_foot.html"/>
	</body>
</html>
