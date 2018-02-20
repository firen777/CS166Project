<%
	//Search if cart cookie is found
	String cookieVal = null;
	
	if ( null==cookieVal ) {
		cookieVal = (String) session.getAttribute("fullname");
		System.out.println(cookieVal);
		Cookie cartCookie  = new Cookie("fullname", (cookieVal == null) ? "unknown" : cookieVal);
		cartCookie.setMaxAge(1800);
		response.addCookie(cartCookie);
	}
%>


<%
// from console -  document.cookie="keyofcookie=valueofcookie"
%>