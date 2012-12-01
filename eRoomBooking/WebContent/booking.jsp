<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="com.erb.Handler"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking</title>

<script language="javascript" type="text/javascript" src="js/WdatePicker.js"></script>
<link rel="stylesheet" type="text/css" href="css/web.css">

<script type='text/javascript'>
function formValidator(){
	// Make quick references to our fields
	// Check each input in the order that it appears in the form!
	sf = document.frm.searchFrom.value;
	st = document.frm.searchTo.value;
	if(eval(sf) >= eval(st))
	{
		alert("Time \"To\" should LATER than Time \"From\"");
		return false;
	}
	else{
		return true;
	}
	
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
			response.sendRedirect("index.jsp");
		}
	} catch (Exception e) {
		e.printStackTrace();
		response.sendRedirect("index.jsp");
	}
	%>
</head>

<% 
Handler handler = new Handler(); 
int daysAdvance = handler.getDaysAdvance(Integer.parseInt(C_usertype));
String time;
time=handler.getLast30Days(daysAdvance);
%>

<body>
	<form name="frm" id="frm" action="searchresult.jsp" method="post" onsubmit="return formValidator();">
		<table border="0" align="center" class="tablestyle-10" style="font-size: 13px;">
        <thead>
			<tr>
				<th colspan="2" class=''>Set Search Qualifications</th>
			</tr>
            </thead>
			<tr>
				<td bgcolor='#ffffff' align="right"><font color="red">*</font>TIME:</td>

				<td bgcolor='#ffffff'>
				DATE:&nbsp;<input type="text"
					id="searchDate" name="searchDate"
					onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true, <% if(daysAdvance != 0){out.print("minDate:'%y-%M-{%d+"+daysAdvance+"}',");}%>isShowClear:false,readOnly:true})"
					title="YYYY-MM-DD" style="width: 150px;" readonly="readonly" value="<%= time %>" />
				&nbsp;FROM:&nbsp;<select id="searchFrom"
					name="searchFrom">
						<option value="800">08:00</option>
						<option value="900">09:00</option>
						<option value="1000">10:00</option>
						<option value="1100">11:00</option>
						<option value="1200">12:00</option>
						<option value="1300">13:00</option>						
						<option value="1400">14:00</option>
						<option value="1500">15:00</option>
						<option value="1600">16:00</option>
						<option value="1700">17:00</option>
						<option value="1800">18:00</option>
						<option value="1900">19:00</option>						
						<option value="2000">20:00</option>
						<option value="2100">21:00</option>
						<option value="2200">22:00</option>
						
				</select>&nbsp;TO:&nbsp;<select id="searchTo" name="searchTo">
						<option value="900">09:00</option>
						<option value="1000">10:00</option>
						<option value="1100">11:00</option>
						<option value="1200">12:00</option>
						<option value="1300">13:00</option>						
						<option value="1400">14:00</option>
						<option value="1500">15:00</option>
						<option value="1600">16:00</option>
						<option value="1700">17:00</option>
						<option value="1800">18:00</option>
						<option value="1900">19:00</option>						
						<option value="2000">20:00</option>
						<option value="2100">21:00</option>
						<option value="2200">22:00</option>
						<option value="2300">23:00</option>
				</select></td>
			</tr>
			<tr>

				<td bgcolor='#ffffff' align="right">Keyword:</td>
				<td bgcolor='#ffffff'>
				<input type="text" id="searchKeyword" name="searchKeyword" style="width: 215px;"/>
				<select id="searchType" name="searchType">
						<option value="ROOM_NUM">Search By Room Number</option>
						<option value="CAPACITY">Search By Capacity</option>
						<option value="ITEM">Search By ITEM</option>
				</select>
				</td>
			</tr>
			<tr>

				<td colspan="2" bgcolor='#ffffff' align="center"><input
					type="submit" value="Search" /> <input type="reset" value="Reset" />
				</td>
			</tr>
		</table>

	</form>


</body>

</html>