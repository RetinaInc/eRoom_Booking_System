<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.freeder.GetSubscriptions"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
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
function display(y){
	$(y).style.display=($(y).style.display=="none")?"":"none";
	}
function $(s){return document.getElementById(s);}

function changecontent(url){
	location.href = url;
}
 </script>







<body>
<table height=100% width=100% border="1" cellspacing="0" cellpadding="0"
	rules="rows" frame="hsides">
	<%
		if (request.getParameter("subxml").equals("all")) {
			String email = request.getParameter("email");
			String subxml = request.getParameter("subxml");
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection(url, user,
						passwd);
				Statement sta = conn.createStatement();
				String allxml = " ";
				ResultSet resultSet = sta
						.executeQuery("select subxml from freeder.usersub where uemail='" + email + "'");
				while(resultSet.next()){
					allxml = allxml+"subxml = '"+resultSet.getString("subxml")+"' || ";
				}
				if (!allxml.equals(" ")) {
					allxml = allxml.substring(0,allxml.length()-4);
				}
				resultSet = sta
						.executeQuery("select * from freeder.itemlib where "+allxml+" order by itempubdate desc");
				if (resultSet.next()) {
					resultSet.previous();
					while (resultSet.next()) {
	%>
	<tr>
		<td>

		<table onmouseover="this.bgColor='#BDDFFF'" onmouseout=mouserout(this)
			onclick=trclick(this);display('<%=resultSet.getString("itemid")%>'); width=100% style="table-layout:fixed">
			<tr>
				<td width=15% style="white-space: nowrap; overflow:hidden">
				<%
					Statement tmpsta = conn.createStatement();
									ResultSet tmpset = tmpsta
											.executeQuery("select * from freeder.usersub where subxml='"
													+ resultSet.getString("subxml")
													+ "'");
									while (tmpset.next()) {
				%> <font size=2><%= tmpset.getString("subname")%></font> <%
 	break;
 					}
 					tmpsta.close();
 					tmpset.close();
 %>
				</td>
				<td width=1%>
				</td>
				<td style="white-space: nowrap; overflow:hidden" width=70%>
				<font size=2><%= resultSet.getString("itemtitle")%></font>
				</td>
				<td width=1%>
				</td>
				<td>
				<font size=2><% String pt =  resultSet.getString("itempubdate").substring(0,10);
				out.println(pt);%></font>
				</td>
			</tr>
		</table>

		</td>
	</tr>

	<tr style="display: none;" id="<%=resultSet.getString("itemid")%>">
		<td>
		<table cellpadding=30>
		<tr>
		<td>
		<p><font size=4><b><a href=<%= resultSet.getString("itemlink") %> target="_blank"><%= resultSet.getString("itemtitle") %></a></b></font></p>
		<% String tmpa = resultSet.getString("itemauthor");
		if (!tmpa.equals("")){
		out.println("<p><font size=2>Author: "+tmpa+"</font></p>");
		}%>
		<%=resultSet.getString("itemdescription")%>
		<br><br><br>
		
		</td>
		</tr>
		
		</table>
		
		</td>
		
	</tr>
	<%
		}
					
				} else {
	%>
	<tr>
		<td>No Item!</td>
	</tr>
	<%
		}
				sta.close();
				resultSet.close();
				conn.close();

			} catch (SQLException ex) {
				%><tr>
				<td>No Item!</td>
			</tr><%
			}
		} else {
			String email = request.getParameter("email");
			String subxml = request.getParameter("subxml");
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection conn = DriverManager.getConnection(url, user,
						passwd);
				Statement sta = conn.createStatement();

				ResultSet resultSet = sta
						.executeQuery("select * from freeder.itemlib where subxml='"
								+ subxml + "' order by itempubdate desc");
				
				
				
				

					while (resultSet.next()) {
	%>
	<tr>
		<td>

		<table onmouseover="this.bgColor='#BDDFFF'" onmouseout=mouserout(this)
			onclick=trclick(this);display('<%=resultSet.getString("itemid")%>'); width=100% style="table-layout:fixed">
			<tr>
				<td width=1%>
				</td>
				<td style="white-space: nowrap; overflow:hidden" width=85%>
				<font size=2><%= resultSet.getString("itemtitle")%></font>
				</td>
				<td width=1%>
				</td>
				<td>
				<font size=2><% String pt =  resultSet.getString("itempubdate").substring(0,10);
				out.println(pt);%></font>
				</td>
			</tr>
		</table>

		</td>
	</tr>

	<tr style="display: none;" id="<%=resultSet.getString("itemid")%>">
		<td>
		<table cellpadding=30>
		<tr>
		<td>
		<p><font size=4><b><a href=<%= resultSet.getString("itemlink") %> target="_blank"><%= resultSet.getString("itemtitle") %></a></b></font></p>
		<% String tmpa = resultSet.getString("itemauthor");
		if (!tmpa.equals("")){
		out.println("<p><font size=2>Author: "+tmpa+"</font></p>");
		}%>
		<%=resultSet.getString("itemdescription")%>
		<br><br><br>
		
		</td>
		</tr>
		
		</table>
		
		</td>
		
	</tr>
	<%
		}
				
				

				sta.close();
				resultSet.close();
				conn.close();
			} catch (SQLException ex) {
				//out.println(ex.toString());
				%><tr>
				<td>No Item!</td>
			</tr><%
			}

		}
	%>
</table>


</body>
</html>