<%@page import="java.security.SecureRandom"%>
<%@include file="db.jsp" %>
<%@include file="csrfchecker.jsp" %>
<%
	
	if (csrfCheck) 
	{
		//Check user
		String user = request.getParameter( "user" );
		String pass = request.getParameter( "pass" );
		
		if (user.isEmpty()||pass.isEmpty()||
				user==null||pass==null) 
			response.sendRedirect("login_form.jsp"); 
		else
		{
			//String fetchSaltStr = "SELECT * FROM login WHERE user = '" + user + "';";
			String fetchSaltStr = "SELECT * FROM login WHERE user = ? ";
			PreparedStatement fetchSaltStmt = con.prepareStatement(fetchSaltStr);
			fetchSaltStmt.setString(1, user);
			ResultSet saltResult = fetchSaltStmt.executeQuery();
		
			if ( !saltResult.next() ) response.sendRedirect("login_form.jsp");  //no such user
			else 
			{
				int salt = saltResult.getInt("salt");
				
				//String sqlStr = "SELECT * FROM login WHERE user='" + user + "' and pass = sha2('"+ pass.concat(String.valueOf(salt)) + "', 256)";
				String sqlStr = "SELECT * FROM login WHERE user = ? and pass = sha2(?, 256);";
				pass.concat(String.valueOf(salt));
				//String sqlStr = "SELECT fullname FROM login WHERE user=? and pass = sha2(?, 256)";
				PreparedStatement stmt = con.prepareStatement(sqlStr);
				stmt.setString(1,user);
				stmt.setString(2,pass.concat(String.valueOf(salt)));
				ResultSet rs = stmt.executeQuery();
				//Statement stmt = con.createStatement();
				//ResultSet rs = stmt.executeQuery(sqlStr);
				
				if ( rs.next() ) {
					session.setAttribute( "user", rs.getString("user") );
					session.setAttribute( "fullname", rs.getString("fullname") );
					session.setAttribute("role", rs.getInt("role"));
					session.setMaxInactiveInterval(60*20);
					response.sendRedirect("blog_list.jsp");	
				} else {
					response.sendRedirect("login_form.jsp");
				}
			}
		}
		
		
	}
	else {
		response.sendRedirect("login_form.jsp"); 
	}
	
%>




<%
//Correct
/*
String sqlStr = "SELECT count(*) FROM login WHERE user=? and pass = sha2(?, 256)";
PreparedStatement stmt = con.prepareStatement(sqlStr);
stmt.setString(1,name);
stmt.setString(2,pwd);
ResultSet rs = stmt.executeQuery();
rs.next();
if ( rs.getInt(1) == 1 ) isAuth=true;
*/

//SQL injection attack
// a ' OR '1'='1' -- 

%>
