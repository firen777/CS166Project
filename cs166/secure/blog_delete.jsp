<%@include file="db.jsp" %>
<%@include file="csrfchecker.jsp" %>
<%
	if (csrfCheck)
	{
		//Check user
		String user = (String) session.getAttribute( "user" );
		String blogid = request.getParameter("blogid");

		String role = session.getAttribute("role").toString() ;
		//if normal
		if (role.equals("0")) {
			//String delete_query = "delete from blog where id=" + blogid + " and user='" + user + "';";
			String delete_query = "delete from blog where id=? and user=?;";
			PreparedStatement prep = con.prepareStatement(delete_query);
			prep.setString(1, blogid);
			prep.setString(2, user);
			prep.executeUpdate();
			response.sendRedirect("blog_list.jsp");	
		}
		//if admin
		else if (role.equals("1")) {
			String delete_query = "delete from blog where id=?;";
			PreparedStatement prep = con.prepareStatement(delete_query);
			prep.setString(1, blogid);
			prep.executeUpdate();
			response.sendRedirect("blog_list.jsp");	
		} 
		else {
			response.sendRedirect("blog_list.jsp");	
		}
	}
	else {
		response.sendRedirect("register_form.jsp"); 
	}

%>