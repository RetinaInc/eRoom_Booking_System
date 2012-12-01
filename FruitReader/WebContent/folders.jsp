<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder - Setting - Folders</title>
<link href="layout/setting.css" rel="stylesheet" type="text/css" />
</head>


<script type="text/javascript">
	function checkAll(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = true;
			}
		}
	}

	function uncheckAll(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = false;
			}
		}
	}

	function $(s) {
		return document.getElementById(s);
	}
</script>

<script type="text/javascript">
	function prom(mail) {
		//var email = 
		var name = prompt("Enter a folder name.", "");
		if (name) {
			this.location.href = "handler.jsp?email=" + mail + "&fname=" + name
					+ "&Add_Fold=";
		}
	}
</script>

<script type="text/javascript">
	function prom2(mail, oldfname) {
		//var email = 
		var name = prompt("Enter a folder name.", "");
		if (name) {
			this.location.href = "handler.jsp?email=" + mail + "&oldfname="
					+ oldfname + "&newfname=" + name + "&RN_Fold=";
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
	if(!C_username.equals(request.getParameter("email")))
	{
		response.sendRedirect("index.jsp");
	}
} else {
	response.sendRedirect("index.jsp");
}

%>


<div id="container">
<div id="header">
<table width=100% height=100%>
	<tr>
		<td><a href="index.jsp"><img src=images/logosm.png></a></td>
		<td align=right><%=request.getParameter("email")%>&nbsp;|&nbsp;<a
			href="subscriptions.jsp?email=<%=request.getParameter("email")%>">Settings</a>&nbsp;|&nbsp;<a
			href="help.jsp?email=<%=request.getParameter("email")%>">Help</a>&nbsp;|&nbsp;<a
			href="handler.jsp?Log_Out=">Sign Out</a></td>
	</tr>
</table>

</div>
<div id="menu">
<table>
	<tr>
		<td width=5%></td>
		<td><font size="5">Setting <a class="men"
			href="home.jsp?email=<%=request.getParameter("email")%>&subxml=all"><font
			size="2">&lt;&lt;Back to Freeder</font></a></font></td>
	</tr>
</table>
</div>
<div id="submenu">
<table height=100%>
	<tr>
		<td width=5%></td>
		<td><font size="4"><a
			href="subscriptions.jsp?email=<%=request.getParameter("email")%>">Subscriptions</a>&nbsp;&nbsp;|&nbsp;&nbsp;<b>Folders</b>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="imexport.jsp?email=<%=request.getParameter("email")%>">Import/Export</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="profile.jsp?email=<%=request.getParameter("email")%>">Change
		Password</a></font></td>
	</tr>
</table>

</div>
<div id="mainContent">
<div id="incontent">
<form id=mod_fold method=get action=handler.jsp><font size="3">Select:
<a href=# onclick="checkAll('mod_fold');">All</a>, <a href=#
	onclick="uncheckAll('mod_fold');">None</a></font> &nbsp;&nbsp; <input
	type="submit" name="Del_Fold" value="Delete Selected">
&nbsp;&nbsp; <input type="button" name="add_folder" value="Add Folder"
	onclick="prom('<%=request.getParameter("email")%>');">

<p></p>



<table>

	<%
		try {
			String email = request.getParameter("email");
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager
					.getConnection(url, user, passwd);
			Statement sta = conn.createStatement();
			ResultSet resultSet = sta
					.executeQuery("select * from freeder.userfold where uemail='"
							+ email + "' order by fname");
			if (resultSet.next()) {
				resultSet.previous();

				while (resultSet.next()) {
	%>
	<tr>
		<td width=20%><input type="checkbox" name="fname"
			value="<%=resultSet.getString("fname")%>" /><font size=4><%=resultSet.getString("fname")%></font>
		</td>
		<td width=10%><a href=#
			onclick="prom2('<%=request.getParameter("email")%>','<%=resultSet.getString("fname")%>');">Rename</a></td>
		<td width=5%><a
			href="handler.jsp?email=<%=request.getParameter("email")%>&fname=<%=resultSet.getString("fname")%>&deleteonefolder=")>X</a></td>
	</tr>
	<%
		}
			} else {
	%>
	<tr>
		<td>Please Add at least one folder</td>
	</tr>
	<%
		}

			resultSet.close();
			sta.close();
			conn.close();
		} catch (SQLException ex) {
			out.println(ex.toString());
		}
	%>
</table>

<input type="hidden" name="email"
	value=<%=request.getParameter("email")%> /></form>

</div>



</div>
</div>
</body>
</html>