<%@ page import="java.util.*" %>
<%
  Cookie[] cookies = request.getCookies();
  if (cookies == null)
    cookies = new Cookie[0];
  Date thisVisit = new Date();
  // add data cookie to session
  Cookie c = new Cookie("lastVisit",""+thisVisit);
  response.addCookie(c);
  // add cookie to session
  String name = request.getParameter("name");
  String value = request.getParameter("value");
  Cookie added = null;
  if (name!=null && value!=null && name.length()>0) {
    added = new Cookie(name,value);
    response.addCookie(added);
  }
%>
<HTML>
  <HEAD>
    <TITLE>Cookie List</TITLE>
  </HEAD>
  <BODY>
    <H1>Cookie List</H1>
    This visit: <%= thisVisit %><BR>
    Number of cookies: <%= cookies.length %><BR>
    <H2>Cookies</H2>
    <%
    for (int i=0; i<cookies.length; i++) {
      out.println(cookies[i].getName()+":\t"+
        cookies[i].getValue()+"<BR>");
      // check if added cookie already present
      if (added!=null && added.getName().equals(cookies[i].getName()))
        added = null;
    }
    if (added != null)
      out.println("new cookie: "+added.getName()+":\t"+
        added.getValue()+"<BR>");
    %>
    <H2>New cookie</H2>
    <FORM>
      <P>Name: <INPUT TYPE='TEXT' NAME='name'></P>
      <P>Value: <INPUT TYPE='TEXT' NAME='value'></P>
      <INPUT TYPE='SUBMIT' VALUE='Add new value'>
    </FORM>
  </BODY>
</HTML>