<%
	boolean csrfCheck = false;
	if (request.getParameter("csrftoken").equals(session.getAttribute("csrftoken")+"/")) 
		csrfCheck = true;
%>