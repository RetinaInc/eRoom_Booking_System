<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*"%>
    <%@ page import="java.util.*"%>
<%@ page import="com.erb.Handler"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Controller</title>
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
			if ("usertype".equals(c[i].getName()))
				C_usertype = c[i].getValue();
		}
	
	
		Map parameters = request.getParameterMap();
		if (parameters.containsKey("deleteorder")) {
			Handler handler = new Handler();
			if(handler.deleteOrder(C_username, request.getParameter("deleteorder")))
			{
				response.sendRedirect("history.jsp");
			}
			else
			{
				response.sendRedirect("error.jsp?type=1");
			}
		}
		else if (parameters.containsKey("addorder")) {
			Handler handler = new Handler();
			String ROOM_NUM = request.getParameter("ROOM_NUM");
			String sDate = request.getParameter("searchDate");
			String sFrom = request.getParameter("searchFrom");
			String sTo = request.getParameter("searchTo");
			String sRemark = request.getParameter("remark");
			if(handler.addOrder(C_username, ROOM_NUM, sDate, sFrom, sTo, sRemark))
			{
				response.sendRedirect("success.jsp?type="+C_usertype);
			}
			else
			{
				response.sendRedirect("error.jsp?type=2");
			}
		}
		else if (parameters.containsKey("logout")) {
			
			
			int ic;
			//init email and pwd from cookies
			//get Cookie
			Cookie co[]=request.getCookies();
			for(ic=0;ic<co.length;ic++)
			{
			    //if get cookies
			    if("username".equals(co[ic].getName()))
			    {
			    	co[ic].setMaxAge(0);
			    	response.addCookie(co[ic]);
			    }
			        
			    if("usertype".equals(co[ic].getName()))
			    {
			    	co[ic].setMaxAge(0);
			    	response.addCookie(co[ic]);
			    }
			}
			response.sendRedirect("index.jsp");
		}
		
	%>



</body>
</html>