<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Main</title>

</head>
	<%
		int i;
		//init email and pwd from cookies
		String C_username = "";
		//get Cookie
		Cookie c[] = request.getCookies();
		try {
			for (i = 0; i < c.length; i++) {
				//if get cookies
				if ("username".equals(c[i].getName()))
					C_username = c[i].getValue();
			}
			if ("".equals(C_username)) {
				response.sendRedirect("index.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("index.jsp");
		}
	%>





<frameset rows="120,60,*" cols="*" frameborder="no" border="0"
	framespacing="0">
     <frame src="header.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" title="topFrame" />
	<frame src="Menu_header.jsp" name="top2Frame" id="top2Frame"
		title="mtop2Frame" />
	<frame src="booking.jsp" name="mainFrame" id="mainFrame"
		title="mainFrame" />
</frameset><noframes></noframes>
<body>



</body>
</html>