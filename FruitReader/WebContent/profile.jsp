<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder - Setting - Change Password</title>
<link href="layout/setting.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/javascript">
function formValidator(){
	// Make quick references to our fields
	var verpwd = document.getElementById('verpwder');
	var pwd = document.getElementById('pwder');
	
	// Check each input in the order that it appears in the form!
	if(notEmpty(pwd, "Please enter a password")){
		if(pwd.value==verpwd.value){
			return true;
		}
		else{
			alert("Please enter the same password");
			
			}
	}
	
	
	
	return false;
	
}

function notEmpty(elem, helperMsg){
	if(elem.value.length == 0){
		alert(helperMsg);
		elem.focus(); // set the focus to this input
		return false;
	}
	return true;
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
		<td><font size="4"><a
			href="subscriptions.jsp?email=<%=request.getParameter("email")%>">Subscriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="folders.jsp?email=<%=request.getParameter("email")%>">Folders</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="imexport.jsp?email=<%=request.getParameter("email")%>">Import/Export</a>&nbsp;&nbsp;|&nbsp;&nbsp;<b>Change
		Password</b></font></td>
	</tr>

</table>

</div>
<div id="mainContent">
<div id="content" align=center>
<p><font size="6">Change Password</font></p>
<form id=changepwd onsubmit="return formValidator();" method=get action=handler.jsp>
<table>
<% try{
	if(request.getParameter("status").equals("success")){
		%>
		<tr>
		<td>
		<font color="#FF0000">Change password Success!</font>
		</td>
		</tr>
		<%
	} else {
		%>
		<tr>
		<td>
		<font color="#FF0000">Wrong password!</font>
		</td>
		</tr>
		<%
	}
} catch (Exception e){
	//System.out.println(e.toString());
}
	%>
	<tr>
		<td align=right><font size="3">Old Password</font></td>
		<td><input type=password name=oldpwd><br>
		</td>
	</tr>
	<tr>
		<td align=right><font size="3">Password:</font></td>
		<td><input type=password name=pwd></td>
	</tr>
	<tr>
		<td align=right><font size="3">Verify Password:</font></td>
		<td><input type=password name=verpwd></td>
	</tr>
</table>
<input type="hidden" name="email" value=<%= request.getParameter("email") %> />
<input type=submit name=changepwd value="Confirm"> <input
	type=reset value="Reset"></form>
</div>

</div>
</div>
</body>
</html>