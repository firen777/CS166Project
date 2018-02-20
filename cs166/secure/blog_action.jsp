<%@include file="db.jsp" %>
<%@include file="csrfchecker.jsp" %>
<%@ page import = "org.apache.commons.text.StringEscapeUtils" %>
<%
	if (csrfCheck)
	{
		//Check user
		String blogtitle = request.getParameter( "blogtitle" );
		String blogcontent = request.getParameter( "blogcontent" );
		String user = (String) session.getAttribute( "user" );
	
		//String sqlStr = "insert into blog (`title`,`content`,`user`) values ('" + blogtitle + "', '" + blogcontent + "', '" + user + "')";
		String sqlStr = "insert into blog (`title`,`content`,`user`) values (?, ?, ?)";
		PreparedStatement prep = con.prepareStatement(sqlStr);
		prep.setString(1, StringEscapeUtils.escapeXml10(blogtitle));
		prep.setString(2, StringEscapeUtils.escapeXml10(blogcontent));
		prep.setString(3, StringEscapeUtils.escapeXml10(user));
		prep.executeUpdate();
		response.sendRedirect("blog_list.jsp"); 
	}
%>

<%
//SQL injection attack
// a ' OR '1'='1' -- 
//Users', (select GROUP_CONCAT(fullname) from login), 'hacker') -- 
%>
