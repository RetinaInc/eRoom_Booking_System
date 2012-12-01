<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" 
	import="java.util.*,com.jspsmart.upload.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function isNotEmpty(){
	var elem = document.getElementById('uploadurl');
	if(elem.value.length == 0){
		alert("Please select a file");
		return false;
	}
	return true;
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Import</title>
       <link rel="stylesheet" type="text/css" href="../../css/web.css">
</head>
	<%
		int i;
		//init email and pwd from cookies
		String C_username = "";
		String C_usertype = "";
		//get Cookie
		Cookie c[] = request.getCookies();
		try {
			for (i = 0; i < c.length; i++) {
				//if get cookies
				if ("username".equals(c[i].getName()))
					C_username = c[i].getValue();
				if ("usertype".equals(c[i].getName()))
					C_usertype = c[i].getValue();
			}
			if ("".equals(C_username)) {
				response.sendRedirect("../../index.jsp");
			}
			else if(!"3".equals(C_usertype))
			{
				response.sendRedirect("../../main.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("../../index.jsp");
		}
	%>
<body>
	<form  action="upload.jsp" method="post" enctype="multipart/form-data" name="form1" id="fomr1" onsubmit="return isNotEmpty()">

<table align="center" class="tablestyle-10">
<caption>Import</caption>
<tr>
<th>
Select File
</th>
</tr>
<tr>
<td>
<input type="FILE" name="uploadurl" id="uploadurl" size="30">
</td>
</tr>
<tr>
<td align="center">
<input name="import" type="submit" value="Upload" />
</td>
</tr>
</table>
	</form>



</body>

</html>