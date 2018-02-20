<%@include file="db.jsp" %>
<%@include file="csrfchecker.jsp" %>
<%
	if (csrfCheck)
	{
		//Check user
		String blogtitle = request.getParameter( "blogtitle" );
		String blogcontent = request.getParameter( "blogcontent" );
		String user = (String) session.getAttribute( "user" );
	
		String sqlStr = "insert into blog (`title`,`content`,`user`) values ('" + blogtitle + "', '" + blogcontent + "', '" + user + "')";
		Statement stmt = con.createStatement();
		stmt.execute(sqlStr);
		response.sendRedirect("blog_list.jsp"); 
	}
%>

<%
//SQL injection attack
// a ' OR '1'='1' -- 
//Users', (select GROUP_CONCAT(fullname) from login), 'hacker') -- 
%>
