<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Fruit Reader - Setting - Import/Export</title>
<link href="layout/setting.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">



function submitform()
{
  document.mod_sub.submit();
}
	
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
			href="subscriptions.jsp?email=<%=request.getParameter("email")%>">Settings</a>&nbsp;|&nbsp;<a
			href="help.jsp?email=<%=request.getParameter("email")%>">Help</a>&nbsp;|&nbsp;<a
			href="handler.jsp?Log_Out=">Sign Out</a></td>
	</tr>
</table>

</div>
<div id="menu">
<table>
	<tr>
		<td width=5%></td>
		<td><font size="5">Setting <a class="men"
			href="home.jsp?email=<%=request.getParameter("email")%>&subxml=all"><font
			size="2">&lt;&lt;Back to Freeder</font></a></font></td>
	</tr>
</table>
</div>
<div id="submenu">
<table height=100%>
	<tr>
		<td width=5%></td>
		<td><font size="4"><a href="subscriptions.jsp?email=<%=request.getParameter("email")%>">Subscriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="folders.jsp?email=<%=request.getParameter("email")%>">Folders</a>&nbsp;&nbsp;|&nbsp;&nbsp; <b>Import/Export</b>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="profile.jsp?email=<%=request.getParameter("email")%>">Change Password</a></font></td>
	</tr>
</table>

</div>
<div id="mainContent">
<div id="incontent">
<p><b>Import your subscriptions</b></p>

<p>If you are switching from another feed reader, you can import
your existing subscriptions into Freeder. To do this, you first
have to export your subscriptions in a standard format called OPML.</p>
<p></p>
<b>This feature is not open yet.</b><br>
<form id=import method=get action=FirstPage>
<table>
	<tr>
		<td>Select an OPML file:</td>
		<td><input type=file name=Bro_Fil /></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" name="upload" value="Upload" disabled></td>
	</tr>
</table>
</form>
<p></p>
<hr>
<p></p>
<p><b>Export your subscriptions</b></p>
<p>
<a href="handler.jsp?email=<%= request.getParameter("email") %>&EXPT=">Export your subscriptions as an OPML file.</a>
</p>


</div>



</div>
</div>
</body>
</html>