<%@include file="db.jsp" %>
<%@include file="csrftoken.jsp" %>
<%@ page import = "com.github.rjeschke.txtmark.*" %>

<%@include file="xsscookie.jsp" %>
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
		<h4>Note: this page is vulnerable to XSS</h4>
		<p>Try type the following in the title/content field: </p>
		<p><code>&lt;script&gt;document.write("XSS cookie stealing:&lt;br/&gt;"+document.cookie);&lt;/script&gt;</code></p>
		<p>This also simultaneously demonstrated how cookie can be stolen via xss. <br/>
		Note that the actual session cookie "JSESSIONID" is flagged as HttpOnly, <br/>
		XSS will be infeasible in stealing such Session.</p>
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
	</body>
	<jsp:include page= "priv_foot.html"/>
</html>
