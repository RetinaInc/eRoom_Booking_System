<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.util.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="css/web.css">
<style type="text/css">
.login_bg{
	background-image:url(pics/login_header.png);
	background-repeat:no-repeat;
	background-position:inherit;
	}
.fontid {
	font-family: "Comic Sans MS", cursive;
	font-size: 20px;
	font-style: normal;
	font-weight: bold;
	color: #00C;
	line-height: 20px;
}
.textfield{
background-image:url(pics/textfield.png);
background-repeat:no-repeat;
padding: 0px 0px 5px 0px;
	}
.textfieldin{
	padding:5px 0px 0px 0px;
	background-image:url(pics/textfield_in.png);
	background-repeat:repeat;
	}
.radiofont{
	font-family: Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-style: normal;
	font-weight: normal;
	color: #000;
	line-height: 20px;
	}
</style>



<script>
	    function doSubmit() {
	        var form = $('loginform');
        	form.submit();
	    }
	    
	    function formValidator(){
	    	// Make quick references to our fields
	    	var uname = document.getElementById('username');
	    	var pwd = document.getElementById('password');
	    	// Check each input in the order that it appears in the form!
	    	if(uname.value.length == 0){
	    		alert("Please input username!");
	    		uname.focus(); // set the focus to this input
	    		return false;
	    	} else if (pwd.value.length == 0)
	    		{
	    		alert("Please input password!");
	    		pwd.focus();
	    		return false;
	    		}
	    	return true;
		}
	    </script>
</head>

<body>

	<%
		int i;
		//init email and pwd from cookies
		String C_username = "";
		String C_usertype = "";
		//get Cookie
		try {
		Cookie c[] = request.getCookies();
		
			for (i = 0; i < c.length; i++) {
				//if get cookies
				if ("username".equals(c[i].getName()))
					C_username = c[i].getValue();
				if ("usertype".equals(c[i].getName()))
					C_usertype = c[i].getValue();
			} 
			if("3".equals(C_usertype)&&!C_username.equals(""))
			{
				response.sendRedirect("admin/main.jsp");
			} else if (!"3".equals(C_usertype)&&!C_username.equals("")) {
				response.sendRedirect("main.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
<br>
<br>
<br>
<br>
<form name="loginform" action="Login" id="loginform" method="post" onSubmit="return formValidator();">
<table align="center" class="login_bg" width="420" height="368">
<tr>
<td rowspan="2"></td>
<td colspan="2" height="120">
		
        </td>
<td rowspan="2"></td>
</tr>
<tr>
  <td height="35" colspan="2" class="color2" align="center"><% 
  Map parameters = request.getParameterMap();
  if(parameters.containsKey("word"))
  {
	  String word = request.getParameter("word");
	  %>
      <%= word %>
      <%
  }else{
	  out.print("Please Login");
  }
  
  
  %></td>
</tr>
<tr>
<td colspan="4"></td>
</tr>
<tr>
<td></td>
<td align="left"><img src="pics/lable_name.png" width="62" height="32" alt="UserName"></td>
<td width="250" height="32" class="textfield">&nbsp;&nbsp;&nbsp;&nbsp;<input id="username" name="username" height="24" type="text" class="textfieldin" style="width:210px;border-style:none"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td align="left"><img src="pics/label_pw.png" width="62" height="32" alt="Password"></td>
<td width="250" height="32" class="textfield">&nbsp;&nbsp;&nbsp;&nbsp;<input id="password" name="password" height="24" type="password" class="textfieldin" style="width:210px;border-style:none" /></td>
         <td></td>
    </tr>
<tr>
<td></td>
<td colspan="2" align="center">
		<input name="button" type="image" src="pics/login_btn.png" onClick="doSubmit()"/>&nbsp;</td>
        <td></td>
    </tr>
</table>
</form>
</body>
</html>