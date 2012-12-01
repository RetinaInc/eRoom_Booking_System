<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
body {
	height: 100%;
	font-family: Verdana;
	font-size: 12px;
	margin: 0;
}
</style>

<script type="text/javascript">
	var oldobj;
	function trclick(obj) {
		if (oldobj != null) {
			oldobj.bgColor = "#FFFFFF";
		}
		oldobj = obj;
		obj.bgColor = '#BDDFFF';
	}
	function mouserout(obj) {
		if (oldobj == obj) {
			return;
		}
		obj.bgColor = '#FFFFFF';
	}
</script>

<script type="text/javascript">
var oldy;
function display(y){
	$(y).style.display=($(y).style.display=="none")?"":"none";
	}
function $(s){return document.getElementById(s);}
 </script>

<body>
<table width=100%>

	<tr onmouseover="this.bgColor='#BDDFFF'" onmouseout=mouserout(this)
	onclick=trclick(this);>
	<td>
	</td>
<td onclick="parent.contentframe.changecontent('content.jsp?email=<%= request.getParameter("email") %>&subxml=all'); parent.changetitle('All Items');">
<b>All Items</b>
</td>
</tr>

	<%
		String email = request.getParameter("email");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager
					.getConnection(url, user, passwd);
			Statement tmpsta = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			Statement sta = conn.createStatement();
			Statement sta2 = conn.createStatement();

			ResultSet tmpSet = tmpsta
					.executeQuery("select * from freeder.usersub where uemail = '"
							+ email + "'");
			ResultSet resultSet = sta
					.executeQuery("select * from freeder.usersub where uemail = '"
							+ email
							+ "' && fname != 'unassigned' order by fname");
			ResultSet resultSet2 = sta2
					.executeQuery("select * from freeder.usersub where uemail = '"
							+ email
							+ "' && fname = 'unassigned' order by subname");

			if (!tmpSet.next()) {
	%>
	<tr>
		<td>
		<p>Please add a Feed.</p>
		</td>
	</tr>
	<%
		} else {
			int count = 1;
			tmpSet = tmpsta.executeQuery("select * from freeder.userfold where uemail = '"
					+ email + "'");
				String fname = "unassigned";
				String tmpfname = "unassigned";
				while (resultSet.next()) {
					tmpfname = resultSet.getString("fname");
					if (!fname.equals(tmpfname)) {
						if(count != 1){
							%>
</table>
</td>
</tr>
<%
						}
						count = 0;
						
	%>
	

	
	
	
<tr onmouseover="this.bgColor='#BDDFFF'" onmouseout=mouserout(this)
	onclick=trclick(this);display('<%=resultSet.getString("fname")%>');>
	<td width=1%>+</td>
	<td><b> <% 
		tmpSet.first();
		while (!tmpSet.isAfterLast()){
			if (tmpSet.getString("fid").equals(resultSet.getString("fname")))
			{
				out.println(tmpSet.getString("fname"));
				break;
			}
			tmpSet.next();
		}
			%> </b></td>
</tr>

<tr style="display: none;" id="<%=resultSet.getString("fname")%>">
	<td></td>
	<td>
	<table>
		<%
			
					}

					fname = tmpfname;
		%>
		<tr>
			<td
				onclick="parent.contentframe.changecontent('content.jsp?email=<%= request.getParameter("email") %>&subxml=<%=resultSet.getString("subxml")%>'); parent.changetitle('<%=resultSet.getString("subname")%>');">-
			<%=resultSet.getString("subname")%></td>
		</tr>
		<%

				}
				if (count != 1){
					%>
	</table>
	</td>
</tr>
<%
				}
				while (resultSet2.next()) {
	%>
<tr>
	<td>+</td>
	<td onclick="parent.contentframe.changecontent('content.jsp?email=<%= request.getParameter("email") %>&subxml=<%=resultSet2.getString("subxml")%>'); parent.changetitle('<%=resultSet2.getString("subname")%>');"><%=resultSet2.getString("subname")%></td>
</tr>
<%
		}

			}
			tmpSet.close();
			resultSet.close();
			resultSet2.close();
			tmpsta.close();
			sta.close();
			sta2.close();
			conn.close();
		} catch (SQLException ex) {
			out.println(ex.toString());
		}
	%>



</table>
</body>
</html>