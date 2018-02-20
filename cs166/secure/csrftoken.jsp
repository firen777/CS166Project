<%
	//header that take cares of csrftoken generation.
	String csrftoken = "" + System.currentTimeMillis() + Math.random() * 10000000;
	session.setAttribute("csrftoken", csrftoken);
%>