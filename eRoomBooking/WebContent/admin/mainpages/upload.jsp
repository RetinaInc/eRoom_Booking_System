<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" 
	import="java.util.*,java.io.*,com.jspsmart.upload.*,com.erb.Upload" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Import</title>
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
<%
SmartUpload mySmartUpload =new SmartUpload();

mySmartUpload.initialize(pageContext);

mySmartUpload.upload();

com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);

String myFileName=myFile.getFileName();

String uploadDir = request.getRealPath("/"); 

myFile.saveAs(uploadDir+"importdata.xml",SmartUpload.SAVE_PHYSICAL); 

%>

	<form method="post" action="../../Upload" name="importx" enctype="multipart/form-data">
	
	<script language="JavaScript">
	document.importx.submit();
	</script>
	
	</form>


</body>

</html>