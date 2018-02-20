<%@ page import = "java.sql.*, java.util.*, java.io.*" %><%		
    Connection con=null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cs166db_s", "cs166db", "y5vYT9U8SNiqRezkBnp6");
	}
	catch(Exception e) {
		out.print("Try again");
		return;
	}
%>