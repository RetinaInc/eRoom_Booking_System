<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="com.erb.Application_data"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<link rel="stylesheet" type="text/css" href="../../css/web.css">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Application</title>
</head>
<script>
	function submitform() {
		document.application.submit();
	}

	function checkAll(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = true;
			}
		}
	}

	function unCheckAll(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = false;
			}
		}
	}

	function checkWaiting(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = false;
			}
		}
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox' && theForm[z].title == 'Waiting') {
				theForm[z].checked = true;
			}
		}
	}

	function checkApproval(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = false;
			}
		}
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox' && theForm[z].title == 'Accept') {
				theForm[z].checked = true;
			}
		}
	}

	function checkReject(theElement) {
		var theForm = $(theElement), z = 0;
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox') {
				theForm[z].checked = false;
			}
		}
		for (z = 0; z < theForm.length; z++) {
			if (theForm[z].type == 'checkbox' && theForm[z].title == 'Reject') {
				theForm[z].checked = true;
			}
		}
	}

	function $(s) {
		return document.getElementById(s);
	}
</script>
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
		} else if (!"3".equals(C_usertype)) {
			response.sendRedirect("../../main.jsp");
		}
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("../../index.jsp");
	}
%>
<body>
	<form method="post" action="../../controller" name="application"
		id="application">
		<table width="90%" align="center" class="tablestyle-10">
			<caption>Applications Queuing</caption>
			<tr>
				<td><a href=# onclick="checkAll('application');">All</a>, <a
					href=# onclick="unCheckAll('application');">None</a>, <a href=#
					onclick="checkWaiting('application');">Waiting</a>, <a href=#
					onclick="checkApproval('application');">Approval</a>, <a href=#
					onclick="checkReject('application');">Reject</a>&nbsp; <select
					name="dowhat">
						<option value="nothing" selected>Change to...</option>
						<option value="Accept">Approval</option>
						<option value="Reject">Reject</option>
				</select> <input type="submit" name="do_all" value="Action" />
				</td>
			</tr>
			<tr>
				<td>
					<%
						Application_data adata = new Application_data();
						ResultSet rs = null;
						String uids = null;
						String apprs = null;
						String rejes = null;
						String buts = null;
						String butsw = null;
						int detect = 0;
						int num = 1;
						int ptemp;
						int intPageSize = 10;
						int intRowCount;  
						int intPageCount; 
						int intPage;
						String strPage = "1";
						rs = adata.applicationdata();
						strPage = request.getParameter("page");
							if(strPage==null){  
								intPage = 1;  
								} else{ 
								intPage = java.lang.Integer.parseInt(strPage);  
								if(intPage< 1) intPage = 1;  
								}  
						rs.last();
						intRowCount = rs.getRow();
						intPageCount = (intRowCount+intPageSize-1) / intPageSize;
						if(intPage>intPageCount) intPage = intPageCount;
						
						if (intRowCount!=0) {
					%>

					<table width="100%" align="center" class="tablestyle-10">
						<thead>
							<tr>
								<th><input type="hidden" name="page" value="<%= intPage%>"/></th>
								<th>Order ID</th>
								<th>User ID</th>
								<th>Room</th>
								<th>Date</th>
								<th>Start time</th>
								<th>End time</th>
								<th>Remark</th>
								<th>Status</th>
								<th colspan="2" align="center">Operation</th>
							</tr>
						</thead>
						<%
						ptemp = 0;
						rs.first();
						rs.absolute((intPage-1) * intPageSize + 1);  
							while (ptemp < intPageSize && !rs.isAfterLast()) {
									uids = "uid" + num;
									apprs = "approval" + num;
									rejes = "reject" + num;
									String tF = rs.getString("TIME_FROM");
									tF = tF.substring(0, tF.length() - 2);
									String tT = rs.getString("TIME_TO");
									tT = tT.substring(0, tT.length() - 2);
						%>

						<tr>
							<td align="center">
								<%
									Date tD = rs.getDate("DATEA");
											if (tD.compareTo(new Date()) >= 0) {
								%><input type="checkbox" name="act_select"
								value="<%=rs.getString(1)%>" title="<%=rs.getString(7)%>" /> <%
									}
								%>
							</td>
							<td align="center" width="10%"><%=rs.getString(1)%></td>
							<td align="center" width="10%"><%=rs.getString(2)%> <input
								type="hidden" name="<%=uids%>" style="width: 150px;"
								value="<%=rs.getString(1)%>" /></td>
							<td align="center" width="10%"><%=rs.getString(3)%></td>
							<td align="center" width="10%"><%=rs.getString(4)%></td>
							<td align="center" width="10%"><%=tF + ":00"%></td>
							<td align="center" width="10%"><%=tT + ":00"%></td>
							<td align="center" width="5%"><%= rs.getString("REMARK") %></td>
							<td align="center" width="10%"><%=rs.getString(7)%></td>
							<%
								if (rs.getString(7).equals("Waiting")) {
							%>
							<td align="center" width="15%"><input name="<%=apprs%>"
								type="submit" value="Approval" /></td>
							<td align="center" width="15%"><input name="<%=rejes%>"
								type="submit" value="Reject" /></td>
							<%
								} else {
											if (tD.compareTo(new Date()) >= 0) {
												if (rs.getString(7).equals("Reject")) {
													buts = "approval" + num;
													butsw = "Approval";
												} else {
													buts = "reject" + num;
													butsw = "Reject";
												}
							%>
							<td align="center" colspan=2 width="30%"><input
								name="<%=buts%>" type="submit" value="<%=butsw%>" /></td>
							<%
								} else {
							%>
							<td align="center" colspan=2 width="30%">Cannot be changed.</td>
							<%
								}
										}
							%>

						</tr>

						<%
						rs.next();
							num++;
							ptemp++;
								}
						%>
					</table>
					
					<div style="margin-top:5px;">
					 <table  align="center" class="tablestyle-10">
						<tr>
							<%
					int curPage=1;
							System.out.println(intRowCount);
					while(curPage<=intPageCount){
						
					if(curPage == intPage){%>
							<td><%=curPage %></td>
							<%}
					else
					{%>
							<th><a href="application.jsp?page=<%=curPage%>"><%= curPage %></a>
							</th>
							<%}
					curPage++;
					}%>
						</tr>
					</table>
					</div>
					
					
					
					<%
					
 	} else {
 %>
					<table width="100%" align="center" class="tablestyle-10">
						<thead>
							<tr align="center">
								<th>No Application Queuing</th>
							</tr>
						</thead>
					</table> <%
 	}
 	adata.connclose();
 %>
				</td>
			</tr>
		</table>
	</form>

</body>

</html>