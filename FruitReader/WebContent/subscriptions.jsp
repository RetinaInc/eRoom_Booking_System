<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Freeder - Setting - Subscriptions</title>
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
	
	
	function checkUn(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = false;
			}
		}
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox' && theForm[z].title == 'unassigned') {
				theForm[z].checked = true;
			}
		}
	}
	
	function changeselected(mail, value, theElement) {
		var theForm = $(theElement), z = 0;
		var str = null;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox' && theForm[z].title == 'unassigned') {
				// str = thrForm[z].text;
				str = value;
				theForm[z].checked = true;
				this.location.href = str;
			}
		}
		/*
		var str = null;

		if (value==("Change to folder...")){
		} else {
			var theForm = $(theElement), z = 0;
			for (z = 0; z < theForm.length; z++) {
				
				if (theForm[z].type == 'checkbox') {
					str = str + "&subxml="+thrForm[z].value;
					this.location.href = "http://colinzhang.com";
				}
			//this.location.href = "handler.jsp?email="+mail+str+"&fname="+value+"&Chage_Selected=";
			//this.location.href = value;
		}
		}
		*/
	}
	
	function testCheckbox(oCheckbox) {
		var checkbox_val = oCheckbox.value;

		if(oCheckbox.checked == true) {
		alert("Checkbox with name = " + oCheckbox.name + " and value =" + checkbox_val + " is checked");

		} else {

		alert("Checkbox with name = " + oCheckbox.name + " and value =" + checkbox_val + " is not checked");

		}

		}
	
	function submitform()
	{
	  document.mod_sub.submit();
	}


	function $(s) {
		return document.getElementById(s);
	}
</script>

<script type="text/javascript">
	function prom(mail, subxml) {
		//var email = 
		var name = prompt("Enter a folder name.", "");
		if (name) {
			this.location.href = "handler.jsp?email=" + mail + "&subxml=" + subxml + "&subname=" + name + "&Change_Sub_Name=";
		}
	}
	
	function changeone(mail, value, subxml){
		if (value==("Change to folder...")){
		} else {
			this.location.href = "handler.jsp?email="+mail+"&subxml="+subxml+"&fname="+value+"&changeonefolder=";
			//this.location.href = value;
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
		<td><font size="4"><b>Subscriptions</b>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="folders.jsp?email=<%=request.getParameter("email")%>">Folders</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="imexport.jsp?email=<%=request.getParameter("email")%>">Import/Export</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a
			href="profile.jsp?email=<%=request.getParameter("email")%>">Change
		Password</a></font></td>
	</tr>
</table>
<%
		try {
			String email = request.getParameter("email");
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager
					.getConnection(url, user, passwd);
			Statement sta = conn.createStatement();
			Statement sta2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			ResultSet resultSet2 = sta2.executeQuery("select * from freeder.userfold where uemail='"+email+"' order by fname");
			ResultSet resultSet = sta
					.executeQuery("select * from freeder.usersub where uemail='"
							+ email + "' order by subname"); %>

</div>
<div id="mainContent">
<div id="incontent">
<form id=mod_sub name=mod_sub method=get action=handler.jsp><font size="3">Select:
<a href=# onclick="checkAll('mod_sub');">All</a>, <a href=#
	onclick="uncheckAll('mod_sub');">None</a>, <a href=#
	onclick="checkUn('mod_sub');">Unassigned</a></font> &nbsp;&nbsp; 
	<select name=Change_Selected onchange="submitform();">
			<option value="Change to folder..." selected>Change to folder...
			<option value="unassigned">Unassigned
			<%
			try{
				resultSet2.first();
				while (!resultSet2.isAfterLast()){
					String tmpname = resultSet2.getString("fname");
					if (!tmpname.equals("")){
						%>
						<option value="<%= resultSet2.getString("fid") %>"><%= resultSet2.getString("fname") %>
						<%
					}
				resultSet2.next();
				}
			} catch (Exception e){
				
			}
			%>
</select> &nbsp;&nbsp; <input type="submit" name="Un_Sub" value="Unsubscribe">

<table>

	<%
			if (resultSet.next()) {
				resultSet.previous();

				while (resultSet.next()) {
	%>
	<% if(resultSet.getString("fname").equals("unassigned")) {%>
	<tr>
		<td width=20%><input type="checkbox" name="subxml"
			title="unassigned" value="<%=resultSet.getString("subxml")%>" /><font
			size=4><%=resultSet.getString("subname")%></font></td>
		<td width=10%><a href=#
			onclick="prom('<%=request.getParameter("email")%>','<%=resultSet.getString("subxml")%>');">Rename</a></td>
		<td width=5%><a
			href="handler.jsp?email=<%=request.getParameter("email")%>&subxml=<%=resultSet.getString("subxml")%>&unsubone=")>X</a></td>
		<td width=10%><select name=more_act_one onchange="changeone('<%=request.getParameter("email")%>',this.value,'<%=resultSet.getString("subxml")%>');">
			<option value="Change to folder..." selected>Change to folder...
			<option value="unassigned">Unassigned
			<%
			try{
				resultSet2.first();
				while (!resultSet2.isAfterLast()){
					String tmpname = resultSet2.getString("fname");
					if (!tmpname.equals("")){
						%>
						<option value="<%= resultSet2.getString("fid") %>"><%= resultSet2.getString("fname") %>
						<%
					}
				resultSet2.next();
				}
			} catch (Exception e){
				
			}
			%>
		</select></td>
	</tr>
	<tr>
		<td>
		<%= resultSet.getString("subxml") %>
		</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		Unassigned
		</td>
	</tr>
	<%} else { %>
	<tr>
		<td width=20%><input type="checkbox" name="subxml" value="<%=resultSet.getString("subxml")%>" /><font
			size=4><%=resultSet.getString("subname")%></font></td>
		<td width=10%><a href=#
			onclick="prom('<%=request.getParameter("email")%>','<%=resultSet.getString("subxml")%>');">Rename</a></td>
		<td width=5%><a
			href="handler.jsp?email=<%=request.getParameter("email")%>&subxml=<%=resultSet.getString("subxml")%>&unsubone=")>X</a></td>
		<td width=10%><select name=more_act_one onchange="changeone('<%=request.getParameter("email")%>',this.value,'<%=resultSet.getString("subxml")%>');">
			<option value="Change to folder..." selected>Change to folder...
			<option value="unassigned">Unassigned
			<%
			try{
				resultSet2.first();
				while (!resultSet2.isAfterLast()){
					String tmpname = resultSet2.getString("fname");
					if (!tmpname.equals("")){
						%>
						<option value="<%= resultSet2.getString("fid") %>"><%= resultSet2.getString("fname") %>
						<%
					}
				resultSet2.next();
				}
			} catch (Exception e){
				
			}
			%>
		</select></td>
	</tr>
	<tr>
		<td>
		<%= resultSet.getString("subxml") %>
		</td>
		<td>
		</td>
		<td>
		</td>
		<td>
		<% resultSet2.first();
		while (!resultSet2.isAfterLast()){
		if(resultSet2.getString("fid").equals(resultSet.getString("fname")))
		{
			%>
			<%= resultSet2.getString("fname") %>
			<%
			break;
		}
		
		resultSet2.next();
		}%>
		</td>
	</tr>
	
	
	
	
	
	
	<%}
		}
			} else {
	%>
	<tr>
		<td>Please Add at least one subscription</td>
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
	value=<%= request.getParameter("email")%> /></form>


</div>



</div>
</div>
</body>
</html>