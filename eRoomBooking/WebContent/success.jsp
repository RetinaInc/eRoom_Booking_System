<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/web.css">
<title>Error</title>
</head>
<body>
<%
Map parameters = request.getParameterMap();
String url= request.getParameter("type");
String word;
if(!url.equals("3"))
{
	response.setHeader("Refresh","3;URL=history.jsp");
	url="history.jsp";
	word="Orders History";
}
else
{
	response.setHeader("Refresh","3;URL=admin/mainpages/application.jsp");
	url="admin/mainpages/application.jsp";
	word="Application";
}
%>
<table width="90%" align="center" class="tablestyle-10">
<thead>
<tr>
<th>
Order Room Success. Auto redirect <a href="<%= url%>"><%= word %></a> page in 3s.
</th>
</tr>
</thead>
</table>
</body>
</html>