<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Main</title>
</head>
	<%
		int i;
		//init email and pwd from cookies
		String C_username = "";
		String C_usertype = "";
		//get Cookie
		Cookie c[] = request.getCookies();
		try {
			for (i = 0; i < c.length; i++) {
				//if get cookies
				if ("username".equals(c[i].getName()))
					C_username = c[i].getValue();
				if ("usertype".equals(c[i].getName()))
					C_usertype = c[i].getValue();
			}
			if ("".equals(C_username)) {
				response.sendRedirect("../index.jsp");
			}
			else if(!"3".equals(C_usertype))
			{
				response.sendRedirect("../main.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("../index.jsp");
		}
	%>
<frameset rows="120,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="../header.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset cols="220,*" frameborder="no" border="0" framespacing="0">
    <frame src="left.jsp" name="leftFrame" scrolling="no" noresize="noresize" id="leftFrame" title="leftFrame" />
    <frame src="mainpages/application.jsp" name="mainFrame" id="mainFrame" title="mainFrame" />
  </frameset>
</frameset><noframes></noframes>

<body>
</body>
</html>