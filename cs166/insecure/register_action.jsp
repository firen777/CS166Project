<%@include file="db.jsp" %>
<%@include file="csrfchecker.jsp" %>
<%
	if (csrfCheck)
	{
		//get form input
		String fullname = request.getParameter( "fullname" );
		String user = request.getParameter( "user" );
		String pass = request.getParameter( "pass" );
		String role = request.getParameter( "role" );
		
		
		if (fullname.isEmpty()||user.isEmpty()||pass.isEmpty()||role.isEmpty()||
				fullname==null||user==null||pass==null||role==null) 
			response.sendRedirect("register_form.jsp"); 
		else
		{
			Random rand = new Random();
			int salt = rand.nextInt(10000000);
			int rolenum = 0;
			if (role.equalsIgnoreCase("admin")) rolenum = 1;
			
			String sqlStr = "insert into login(fullname,user, pass, role, salt) values ('" + 
				fullname + "', '" + user + "', sha2('"+ pass.concat(String.valueOf(salt)) + "', 256)," 
				+ rolenum + ", " + salt + ")";
			Statement stmt = con.createStatement();
			stmt.execute(sqlStr);
			response.sendRedirect("login_form.jsp");
		}
	}
	else {
		response.sendRedirect("register_form.jsp"); 
	}
		
	 
%>





<%
//Correct
/*
String sqlStr = "insert into login(fullname,user, pass) values (?,? sha2(?, 256))";
PreparedStatement stmt = con.prepareStatement(sqlStr);
stmt.setString(1,fullname);
stmt.setString(2,user);
stmt.setString(3,pass);
ResultSet rs = stmt.execute();
*/
//SQL injection attack
// a' OR 1=1 -- 
%>
