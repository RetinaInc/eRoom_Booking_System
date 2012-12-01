<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Header</title>
<link rel="stylesheet" type="text/css" href="css/layout.css">
<link rel="stylesheet" type="text/css" href="css/base.css">
</head>
<script>
function lo()
{
	self.parent.location="controller.jsp?logout=";
	
	}

</script>
<body>
    <div id="header">

		<div class="topbar">
			<ul class="ui">
				<li class="item2"><a href="#" onclick="lo();">Logout</a></li>
			</ul>
		</div></div>
</body>
</html>