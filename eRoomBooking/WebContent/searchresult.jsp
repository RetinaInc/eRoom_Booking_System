<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.erb.Handler"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>
</head>
<link rel="stylesheet" type="text/css" href="css/web.css">
<script>
function prom(baseurl) {
	//var email = 
	var remark = prompt("Enter Remarks.(Required)", "");
	if (remark)
	{
		this.location.href = baseurl + "&remark=" + remark + "&addorder=";
	}
}
</script>
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




	<%
	Handler handler = new Handler();
	ResultSet rs = null;
	if("".equals(request.getParameter("searchKeyword")))
	{
		rs = handler.searchWithoutKeyword(request.getParameter("searchDate"),request.getParameter("searchFrom"),request.getParameter("searchTo"));
	}
	else
	{
		rs = handler.searchWithKeyword(request.getParameter("searchDate"),request.getParameter("searchFrom"),request.getParameter("searchTo"),request.getParameter("searchType"),request.getParameter("searchKeyword"));
	}
	
	if (rs.next())
	{
		rs.previous();
		
		%>
	<table width="90%" align="center" class="tablestyle-10" >
    <caption>Search Result</caption>
    <thead>
		<tr align="center">
			<th>Room</th>
			<th>Date</th>
			<th>Time From</th>
			<th>Time To</th>
			<th>Capacity</th>
			<th>Item</th>
			<th>Book</th>
		</tr>
      </thead>
		<%
		String uri = null;
		while (rs.next())
		{
			String tF = request.getParameter("searchFrom");
			tF = tF.substring(0,tF.length()-2);
			String tT = request.getParameter("searchTo");
			tT = tT.substring(0,tT.length()-2);
			%>
			
			
			<tr align="center">
				<td><input type="hidden" name="ROOM_NUM" value="<%= rs.getString("ROOM_NUM") %>" > <%= rs.getString("ROOM_NUM") %></td>
				<td><input type="hidden" name="searchDate" value="<%= request.getParameter("searchDate") %>" ><%= request.getParameter("searchDate") %></td>
				<td><input type="hidden" name="searchFrom" value="<%= request.getParameter("searchFrom") %>" ><%= tF+":00" %></td>
				<td><input type="hidden" name="searchTo" value="<%= request.getParameter("searchTo") %>" ><%= tT+":00" %></td>
				<td><input type="hidden" name="CAPACITY" value="<%= rs.getString("CAPACITY") %>" ><%= rs.getString("CAPACITY") %></td>
				<td><input type="hidden" name="ITEM" value="<%= rs.getString("ITEM") %>" ><%= rs.getString("ITEM") %></td>
				<% uri = "controller.jsp?ROOM_NUM="+rs.getString("ROOM_NUM")+"&searchDate="+request.getParameter("searchDate")+"&searchFrom="+request.getParameter("searchFrom")+"&searchTo="+request.getParameter("searchTo"); %>
				<td><a href=# onclick="prom('<%= uri %>');" >Order</a></td>
			</tr>
			
			
			<%
		}
		
		%>
	</table>
<%
	}
	else
	{
		%>
	<table width="90%" align="center" class="tablestyle-10" >
    <caption>Search Result</caption>
    <thead>
		<tr align="center">
			<th>Cannot Find Any Room.</th>
		</tr>
        </thead>
	</table>
	<%
	}
	
	
	
	%>
</body>
</html>