<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.erb.Handler"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="../../css/web.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Result</title>
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
		} else if (!"3".equals(C_usertype)) {
			response.sendRedirect("../../main.jsp");
		}
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("../../index.jsp");
	}
%>
<body>
<table width="90%" align="center" class="tablestyle-10">
<caption>Statistics</caption>
<tr>
<td>
<%
String type=request.getParameter("type");
String timeyear=request.getParameter("select_year");
String timemonth=request.getParameter("select_month");
String keyword=request.getParameter("roomid");
%>

	<form name="statisticsform" method="post" action="statistics.jsp">
		<b>Select period:&nbsp;</b> <input type="radio" name="type"
			value="tweek" <% if(type==null||type.equals("tweek")){out.print("checked");} %> >This Week&nbsp; <input type="radio" name="type"
			value="lweek" <% if(type!=null&&type.equals("lweek")){out.print("checked");} %>>Last Week&nbsp; <input type="radio" name="type"
			value="tmonth" <% if(type!=null&&type.equals("tmonth")){out.print("checked");} %>>This Month&nbsp; <input type="radio"
			name="type" value="l30days" <% if(type!=null&&type.equals("l30days")){out.print("checked");} %> >Last 30 Days&nbsp; <input
			type="radio" name="type" value="amonth" <% if(type!=null&&type.equals("amonth")){out.print("checked");} %>>Any Month <select
			name=select_year>
			<option value="2011" <% if(type==null||timeyear.equals("2011")){out.print("selected");} %>>2011
			<option value="2010" <% if(type!=null&&timeyear.equals("2010")){out.print("selected");} %>>2010
			<option value="2009" <% if(type!=null&&timeyear.equals("2009")){out.print("selected");} %>>2009
			<option value="2008" <% if(type!=null&&timeyear.equals("2008")){out.print("selected");} %>>2008
			<option value="2007" <% if(type!=null&&timeyear.equals("2007")){out.print("selected");} %>>2007
			<option value="2006" <% if(type!=null&&timeyear.equals("2006")){out.print("selected");} %>>2006
			<option value="2005" <% if(type!=null&&timeyear.equals("2005")){out.print("selected");} %>>2005
		</select> <select name=select_month>
			<option value="0" <% if(type!=null&&timemonth.equals("0")){out.print("selected");} %>>1</option>
			<option value="1" <% if(type!=null&&timemonth.equals("1")){out.print("selected");} %>>2</option>
			<option value="2" <% if(type!=null&&timemonth.equals("2")){out.print("selected");} %>>3</option>
			<option value="3" <% if(type!=null&&timemonth.equals("3")){out.print("selected");} %>>4</option>
			<option value="4" <% if(type==null||timemonth.equals("4")){out.print("selected");} %>>5</option>
			<option value="5" <% if(type!=null&&timemonth.equals("5")){out.print("selected");} %>>6</option>
			<option value="6" <% if(type!=null&&timemonth.equals("6")){out.print("selected");} %>>7</option>
			<option value="7" <% if(type!=null&&timemonth.equals("7")){out.print("selected");} %>>8</option>
			<option value="8" <% if(type!=null&&timemonth.equals("8")){out.print("selected");} %>>9</option>
			<option value="9" <% if(type!=null&&timemonth.equals("9")){out.print("selected");} %>>10</option>
			<option value="10" <% if(type!=null&&timemonth.equals("10")){out.print("selected");} %>>11</option>
			<option value="11" <% if(type!=null&&timemonth.equals("11")){out.print("selected");} %>>12</option>
		</select> <br> <b>Room Number</b>(Optional)<b>:&nbsp;</b> 
		<input type="text" name=roomid <%if (keyword!=null) {out.print("value=\""+keyword+"\"");} %>>
		 <input type="submit" name="sub_form"
			value="GO">
	</form>
</td>
</tr>

<tr>
<td>
	<%
		Map parameters = request.getParameterMap();
		Handler handler = new Handler();
		TreeMap resultTree = new TreeMap();
		String dateFrom = null;
		String dateTo = null;
		if (request.getParameter("type")==null||request.getParameter("type").equals("tweek")) {
			dateFrom = handler.getDateInWeek(0, 1);
			dateTo = handler.getDateInWeek(0, 7);
		} else if (request.getParameter("type").equals("lweek")) {
			dateFrom = handler.getDateInWeek(-1, 1);
			dateTo = handler.getDateInWeek(-1, 7);
		} else if (request.getParameter("type").equals("tmonth")) {
			dateFrom = handler.getMonthFirstDay(0, 0, 0);
			dateTo = handler.getMonthFirstDay(0, 0, 1);
		} else if (request.getParameter("type").equals("l30days")) {
			dateFrom = handler.getLast30Days(-30);
			dateTo = handler.getLast30Days(0);
		} else {
			dateFrom = handler.getMonthFirstDay(
					Integer.parseInt(request.getParameter("select_year")),
					Integer.parseInt(request.getParameter("select_month")),
					0);
			dateTo = handler.getMonthFirstDay(
					Integer.parseInt(request.getParameter("select_year")),
					Integer.parseInt(request.getParameter("select_month")),
					1);
		}
		
		if (request.getParameter("roomid")==null||request.getParameter("roomid").equals("")) {
			resultTree = handler.getStatisticsWithoutKeyword(dateFrom,
					dateTo);
		} else {
			resultTree = handler.getStatisticsWithKeyword(dateFrom,
					dateTo, request.getParameter("roomid"));
		}

		Iterator it2 = resultTree.keySet().iterator();
		if(!resultTree.containsKey("null"))
		{
		
		
	%>
	<table width="300" align="center" class="tablestyle-10">
    <thead>
		<tr align="center">
			<th>Room</th>
			<th>Usage Rate</th>
		</tr>
        </thead>
		<%
		for (;it2.hasNext();) {
			String key = (String) it2.next();
			%>
			<tr align="center">
			<td><%= key %></td>
			<td><%= resultTree.get(key) %></td>
			</tr>
			
			
			<%
			
		}
		
		
		%>
	</table>
	<%
	
	
	
	}else{%>
	<table align="center" width="300">
    <thead>
		<tr align="center">
			<th>Cannot Find Any Data.</th>
		</tr>
        </thead>
	</table>
	<%} %>
    </td>
    </tr>
    </table>
</body>
</html>