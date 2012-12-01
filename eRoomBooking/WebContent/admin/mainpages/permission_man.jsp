<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.erb.User_data"%>
	<%@ page import="com.erb.Handler"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Permission</title>
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
	<form method="post" action="../../controller" id="permission"
		name="permission">
		<%
			Handler handler = new Handler();
			User_data udata = new User_data();
			ResultSet rs = null;
			String uids = null;
			String utypes = null;
			String buts = null;
			String butsw = null;
			String type = null;
			int num = 1;

			rs = udata.userdata();
			if (rs.next()) {
				rs.previous();
		%>
		<table width="90%" align="center" class="tablestyle-10" >
        <caption>Permissions</caption>
        <thead>
			<tr>
				<th>ID</th>
				<th>Current Permission</th>
				<th>Change</th>
			</tr>
            </thead>
			<%
				while (rs.next()) {
					if(!rs.getString(3).equals("3"))
					{
						uids = "uid" + num;
						utypes = "utype" + num;
						if (rs.getString(3).equals("1")) {
							type = "Student";
							buts = "promote" + num;
							butsw = "Promote";
						}
						if (rs.getString(3).equals("2")) {
							type = "Staff";
							buts = "demote" + num;
							butsw = "Demote";
						}
			%>
			<tr>
				<td align="center" width="45%"><%=rs.getString(1)%><input type="hidden"
					name="<%=uids%>" style="width: 300px;" value="<%=rs.getString(1)%>" />
				</td>
				<td align="center" width="30%"><%=type%><input type="hidden"
					name="<%=utypes%>" style="width: 200px;" value="<%=type%>" /></td>
				<td align="center"><input type="submit" name="<%=buts%>"
					value="<%= butsw %>" /></td>
			</tr>

			<%
				num++;
					}}
			%>
		</table>
	  <%
			} else {
		%>
		<table align="center" width="800" border="1">
			<tr align="center">
				<td>No User found</td>
			</tr>
		</table>
		<%
			}
			udata.connclose();
		%>
	</form>


</body>

</html>