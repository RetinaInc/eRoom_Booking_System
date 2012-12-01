<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="../../css/web.css">
<title>Error</title>
</head>
<body>
<%
	response.setHeader("Refresh","3;URL=import.jsp");
%>
<table width="90%" align="center" class="tablestyle-10">
<thead>
<tr>
<th>
Failed. Auto redirect <a href="import">Import</a> page in 3s.
</th>
</tr>
</thead>
</table>
</body>
</html>