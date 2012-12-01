<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder</title>
<link href="layout/home.css" rel="stylesheet" type="text/css" />
</head>


<script type="text/javascript">
	function ctrlcontent() {
		window.frames["contentframe"].location.href = "http://www.cnbeta.com";
	}

	function prom(mail) {
		//var email = 
		var name = prompt("Enter a feed url.", "");
		if (name)
		{
			window.frames["sideframe"].location.href = "handler.jsp?email="
					+ mail + "&name=" + name + "&Add_Sub=";
		}
	}
	
	function changetitle(ntitle) {
		document.getElementById('ctitle').innerHTML = "&nbsp;&nbsp;"+ntitle;
	}
</script>
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
	if(!C_username.equals(request.getParameter("email")))
	{
		response.sendRedirect("index.jsp");
	}
} else {
	response.sendRedirect("index.jsp");
}

%>



<div id="container">
<div id="header">
<table width=100% height=100%>
	<tr>
		<td><a href="index.jsp"><img src=images/logosm.png></a></td>
		<td align=right><%=request.getParameter("email")%>&nbsp;|&nbsp;<a
			href="subscriptions.jsp?email=<%=request.getParameter("email") %>">Settings</a>&nbsp;|&nbsp;<a href="help.jsp">Help</a>&nbsp;|&nbsp;<a
			href="handler.jsp?Log_Out=">Sign Out</a></td>
	</tr>
</table>
</div>
<div id="mainContent">
<div id="sidebar">


<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
	<tr height=40>
		<td><img src=images/addbtn.png
			onclick="prom('<%=request.getParameter("email")%>');"></td>
	</tr>
	<tr height=30 bgcolor=#5599BB>
		<td><font size="4">&nbsp;&nbsp;<b>Subscriptions</b></font></td>
	</tr>


	<tr>
		<td>
		<table width=100% height=100% border="1" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height=100%><iframe name=sideframe frameborder=0 width=100%
					height=100%
					src="sidebar.jsp?email=<%=request.getParameter("email")%>"
					scrolling="auto"></iframe></td>
			</tr>
		</table>




		</td>
	</tr>
</table>



</div>



<div id="content">


<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
	<tr height=40 bgcolor=#5599BB>
		<td><font id="ctitle" size=5>&nbsp;&nbsp;All Items</font></td>
	</tr>
	<tr>
		<td>

		<table width=100% height=100% border="1" cellspacing="0"
			cellpadding="0">
			<tr>
				<td height=100% Valign=top><iframe name=contentframe
					frameborder=0 width=100% height=100%
					src="content.jsp?email=<%=request.getParameter("email")%>&subxml=all"
					scrolling="auto"></iframe></td>
			</tr>
		</table>
		</td>
	</tr>
</table>



</div>
</div>
</div>
</body>
</html>