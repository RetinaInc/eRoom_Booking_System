<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.erb.Handler"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/web.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<%
		int i;
		//init email and pwd from cookies
		String C_username = "";
		String C_usertype = "";
		//get Cookie
		Cookie c[] = request.getCookies();
		for (i = 0; i < c.length; i++) {
			//if get cookies
			if ("username".equals(c[i].getName()))
				C_username = c[i].getValue();
			if ("password".equals(c[i].getName()))
				C_usertype = c[i].getValue();
		}
	%>
				<table width="90%" align="center" class="tablestyle-10">
		<caption>Orders History</caption>

		<%
			Handler handler = new Handler();
			ResultSet rs = handler.getOrders(C_username);
			
			if (rs.next())
			{
				rs.previous();
			%>

		<thead>
			<tr align="center">
				<th>ORDER ID</th>
				<th>Room</th>
				<th>Date</th>
				<th>Time From</th>
				<th>Time To</th>
				<th>Remark</th>
				<th>Status</th>
				<th>Cancel</th>
			</tr>
		</thead>
			<%
			while (rs.next())
			{
				String tF = rs.getString("TIME_FROM");
				tF = tF.substring(0,tF.length()-2);
				String tT = rs.getString("TIME_TO");
				tT = tT.substring(0,tT.length()-2);
				%>

		<tr align="center">
			<td><%= rs.getString("ORDER_ID") %></td>
			<td><%= rs.getString("ROOM_NUM") %></td>
			<td><%= rs.getString("DATEA") %></td>
			<td><%= tF+":00" %></td>
			<td><%= tT+":00" %></td>
			<td width="5%"><%= rs.getString("REMARK") %></td>
			<td><%= rs.getString("STAT") %></td>
			<% if (rs.getString("STAT").equals("Waiting"))
					{
						%>
			<td><a href=controller.jsp?deleteorder=<%= rs.getString("ORDER_ID") %>>X</a>
			</td>
			<%
					}
					else
					{
						%>
			<td>Cannot be canceled.</td>
			<%
					}%>

		</tr>
		<%
				
			}
			}
			else
			{
				%>
						<thead>
			<tr align="center">
				<th>No Orders History</th>
			</tr>
		</thead>
				<%
			}
		%>

	</table>

</body>
</html>