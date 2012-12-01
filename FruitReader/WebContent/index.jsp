<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome to Freeder!</title>
<link href="layout/index.css" rel="stylesheet" type="text/css" />
</head>
<body>


<%

int i;
//init email and pwd from cookies
String C_username="";
String C_password="";
//get Cookie
Cookie c[]=request.getCookies();
for(i=0;i<c.length;i++)
{
    //if get cookies
    if("username".equals(c[i].getName()))
        C_username=c[i].getValue();
    if("password".equals(c[i].getName()))
        C_password=c[i].getValue();
}
if(!"".equals(C_username) && !"".equals(C_password))
{
    //submit to handler
    response.sendRedirect("handler.jsp?email="+C_username+"&pwd="+C_password+"&Sign_In=");
}

%>


<div id="container">
<div id="header">

<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="images/logobg.png"></td>
	</tr>

</table>
</div>


<div id="mainContent">


<div id="sidebar">
<table width=100% height=100%>
	<tr>
		<td align=center>
		<p><font size=50px>Sign In!</font></p>
		<form id=signin method=get action=handler.jsp>Email<br>
		<input type=text name=email>
		<p></p>
		Password<br>
		<input type=password name=pwd>
		<p></p>
		<input type=submit name=Sign_In value="Sign In!"> <input
			type=checkbox name=savecookies value="remember">Remember Me!</form>
		</td>
	</tr>
</table>
</div>




<div id="content" align=center>
<div id="incontent">
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<p><font size="5">&nbsp;&nbsp;&nbsp;&nbsp;Have <font
			size=10>trouble</font> keeping up with the sites you visit?</font></p>
		<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Read them in
		one place with <font size="4">Freeder</font>, where keeping up
		with your favorite websites is as easy as checking your email. <font
			size="4">Freeder</font> constantly checks your favorite news
		sites and blogs for new content.</p>
		</td>
	</tr>
	<tr>
		<td align=center>
		<a href=register.jsp><img src="images/hat.png"/></a>
		</td>
</table>
</div>

</div>



</div>


<div id="footer">
<table width=100% height=100% border="1" cellspacing="0" cellpadding="0"
	rules="rows" frame="hsides">
	<tr>
		<td align=center><font size="4">©2010 Freeder</font></td>
		<td width=8% align=center>About Us</td>
		<td width=8% align=center>Contact</td>
		<td width=8% align=center>Blog</td>
		<td width=8% align=center>Status</td>
		<td width=8% align=center>Help</td>
		<td width=8% align=center>Jobs</td>
		<td width=8% align=center>Privacy</td>
		<td width=8% align=center></td>

	</tr>
</table>

</div>
</div>
</body>
</html>