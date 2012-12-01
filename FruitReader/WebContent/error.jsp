<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder - Oops!</title>
<link href="layout/register.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="container">
<div id="header"><img src=images/logom.png></div>
<div id="menu">
<table>
	<tr>
		<td width=5%></td>
		<td><font size="5">Oops! Error!</font></td>
	</tr>
</table>
</div>

<div id="mainContent">
<div id="content" align=center>
<div id="incontent">
<p><font size="6">Oops! Error!</font></p>

<p><font size="3">
<%out.println(request.getParameter("msg")); %>
</font></p>

<a href=register.jsp><font size="3">Back</font></a>



</div>
</div>
</div>
</div>
</body>
</html>