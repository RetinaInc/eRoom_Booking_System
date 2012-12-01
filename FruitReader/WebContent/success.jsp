<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder - Success!</title>
<link href="layout/register.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="container">
<div id="header"><img src=images/logom.png></div>
<div id="menu">
<table>
	<tr>
		<td width=5%></td>
		<td><font size="5">Congratulations!</font></td>
	</tr>
</table>
</div>

<div id="mainContent">
<div id="content">
<div id="incontent">
<p><font size="6">Congratulations!</font></p>

<p><font size="3">
Welcome to Freeder! <br>
Now you can keep going to user your own reader.<br>
But first, please remember you information to login.<br>
<font size=4><b>Email:<%out.println(request.getParameter("email"));%></b></font><br>
<font size=4><b>Password:<%out.println(request.getParameter("pwd"));%></b></font><br>
You can change your password in the future.<br>
</font></p>

<a href=home.jsp?email=<%out.println(request.getParameter("email")); %>><font size="4">Keep going!</font></a>



</div>
</div>
</div>
</div>
</body>
</html>