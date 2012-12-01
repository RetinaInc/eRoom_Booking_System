<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="conn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder - Register</title>
<link href="layout/register.css" rel="stylesheet" type="text/css" />
</head>


<script type='text/javascript'>

function formValidator(){
	// Make quick references to our fields
	var verpwd = document.getElementById('verpwder');
	var pwd = document.getElementById('pwder');
	var email = document.getElementById('emailer');
	
	// Check each input in the order that it appears in the form!
	if(emailValidator(email, "Please enter a valid email address")){
		if(notEmpty(pwd, "Please enter a password")){
			if(pwd.value==verpwd.value){
				return true;
			}
			else{
				alert("Please enter the same password");
				
		}
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


function emailValidator(elem, helperMsg){
	var emailExp = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
	if(elem.value.match(emailExp)){
		return true;
	}else{
		alert(helperMsg);
		elem.focus();
		return false;
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
    //submit to handler
    response.sendRedirect("handler.jsp?email="+C_username+"&pwd="+C_password+"&Sign_In=");
}

%>
<div id="container">
<div id="header"><a href="index.jsp"><img src=images/logom.png></a></div>
<div id="menu">
<table>
	<tr>
		<td width=5%></td>
		<td><font size="5">Register</font></td>
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
<p><font size="6">Create an Account</font></p>
<form id=signup method=get
	onsubmit="return formValidator();"
	action=handler.jsp>
<table>
	<tr>
		<td align=right><font size="3">Email:</font></td>
		<td><input type=text name=email id=emailer><br>
		</td>
	</tr>
	<tr>
		<td align=right><font size="3">Password:</font></td>
		<td><input type=password name=pwd id=pwder></td>
	</tr>
	<tr>
		<td align=right><font size="3">Verify Password:</font></td>
		<td><input type=password name=verpwd id=verpwder></td>
	</tr>
</table>

<input type=submit name=Sign_Up value="Join Us"
	style="font-size: 20px; height: 40px; width: 80px;"> <input
	type=reset value="Reset"
	style="font-size: 20px; height: 40px; width: 80px;"></form>



</div>
</div>
</div>
</div>
</body>
</html>