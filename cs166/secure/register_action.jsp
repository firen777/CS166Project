<%@page import="java.util.*" %>
<%@include file="db.jsp" %>
<%@include file="csrfchecker.jsp" %>
<%@ page import = "org.apache.commons.text.StringEscapeUtils" %>
<%
	if (csrfCheck)
	{
		//check captcha 
		String user_ans = request.getParameter("captcha");
		String cap_ans = String.valueOf(session.getAttribute("cap_ans"));
		if(user_ans!=null && user_ans.equals(cap_ans))
		{
			//ensured that registration is done by human beings.
			//get form input
			String fullname = request.getParameter( "fullname" );
			String user = request.getParameter( "user" );
			String pass = request.getParameter( "pass" );
			String role = request.getParameter("role");
			
			if (fullname.isEmpty()||user.isEmpty()||pass.isEmpty()||role.isEmpty()||
					fullname==null||user==null||pass==null||role==null) 
				response.sendRedirect("register_form.jsp"); 
			else
			{
				Random rand = new Random();
				int salt = rand.nextInt(10000000);
				int rolenum = 0;
				if (role.equalsIgnoreCase("admin")) rolenum = 1;
				
				String sqlStr = "INSERT INTO login(fullname,user, pass, role, salt) values (?, ?, sha2(?, 256), ?, ?)";
				//String sqlStr = "insert into login(fullname,user, pass) values (?,? sha2(?, 256))";
				PreparedStatement prepstmt = con.prepareStatement(sqlStr);
				prepstmt.setString(1, StringEscapeUtils.escapeXml10(fullname)); //xss
				prepstmt.setString(2, StringEscapeUtils.escapeXml10(user));     //xss
				prepstmt.setString(3, pass.concat(String.valueOf(salt)));
				prepstmt.setInt(4, rolenum);
				prepstmt.setInt(5, salt);
				prepstmt.executeUpdate();
				response.sendRedirect("login_form.jsp");
			}
		}
		else
		{
			response.sendRedirect("register_form.jsp");
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
