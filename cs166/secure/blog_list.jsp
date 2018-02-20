<%@include file="db.jsp" %>
<%@include file="csrftoken.jsp" %>

<%@ page import = "com.github.rjeschke.txtmark.*" %>
<%
	
	String user = (String) session.getAttribute( "user" );
	String fullname = (String) session.getAttribute( "fullname" );
	if (null == user || null == fullname) {
		response.sendRedirect("index.jsp"); 
	}
	
	//Check user
	Statement stmt = con.createStatement();
	ResultSet rs = stmt.executeQuery("SELECT * from blog");
%>
<html>
	<head>
		<link rel="stylesheet" href="style.css">
	</head>
	<body>
		<h1>My CS166 Blog Site <span style="float:right"> Welcome <%= fullname %> &nbsp;&nbsp;&nbsp;&nbsp;<a href="logout_action.jsp">logout</a> &nbsp;&nbsp;&nbsp;&nbsp;</span></h1>
		
		<hr>
		<h1>Blog entries</h1>
		<%	
		//=================Display code=====================//
		while ( rs.next() ) {
			out.print("<div class='blogitem'> <h4>ID:" +  rs.getInt("id") +  "</h4>");
			out.print("<h2>" + rs.getString("title") + "</h2>");
			out.print("<h3>by " + rs.getString("user") + "</h3>");
			//out.print(rs.getString(2) + "</div>");
			out.print(Processor.process(rs.getString("content")) + "</div>");
		}
		%>
		
		<hr>
		<h3>Add a blog item</h3>
		<h4>Note: this page support <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet">Markdown formatting</a></h4>
		<form  method="post" action="blog_action.jsp">
		Blog Title: <input name="blogtitle" size=100/><br>
		<textarea name="blogcontent" rows="10" cols="100"></textarea><br>
		<input type="submit" value="Add Blog"/>
		<input type="hidden" name="csrftoken" value=<% out.print(csrftoken); %>/>
		</form>
		
		<hr>
		<h3>Delete a blog item</h3>
		<form action="blog_delete.jsp" method="post">
			Blog ID: <input name="blogid"/> <br>
			<input type="submit" name="delete" value="Delete Blog"/> 
			<input type="hidden" name="csrftoken" value=<% out.print(csrftoken); %>/>
		</form>
		
		
	</body>
	<jsp:include page= "priv_foot.html"/>
</html>

