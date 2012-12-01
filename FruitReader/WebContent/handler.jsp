<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ include file="conn.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.BufferedWriter"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.FileWriter"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="com.freeder.GetSubscriptions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
</head>
<body>
<%
	Map parameters = request.getParameterMap();
	if (parameters.containsKey("Sign_Up")) {
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(url, user,
					passwd);
			Statement sta = conn.createStatement();

			ResultSet resultSet = sta
					.executeQuery("select * from freeder.users where uemail = '"
							+ email + "'");

			if (resultSet.next()) {
				resultSet.close();
				sta.close();
				conn.close();
				response.sendRedirect("error.jsp?msg=This username is already registered");
			} else {
				sta.execute("insert into users values(default, '"
						+ email + "', '" + pwd + "')");
				resultSet.close();
				sta.close();
				conn.close();
				Cookie c1=new Cookie("username",email);
                Cookie c2=new Cookie("password",pwd);
                response.addCookie(c1);
                response.addCookie(c2);
				response.sendRedirect("success.jsp?email=" + email
						+ "&pwd=" + pwd);
			}

		} catch (SQLException ex) {
			out.println(ex.toString());
		}
	} else if (parameters.containsKey("Sign_In")) {
		String email = request.getParameter("email");
		String pwd = request.getParameter("pwd");

		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			ResultSet resultSet = sta
					.executeQuery("select * from freeder.users where uemail = '"
							+ email + "'");

			while (resultSet.next()) {
				// It is possible to get the columns via name
				// also possible to get the columns via the column number
				// which starts at 1
				// e.g. resultSet.getSTring(2);
				if (resultSet.getString("upwd").equals(pwd)) {
					sta.close();
					conn.close();
					if (parameters.containsKey("savecookies")){
		                Cookie c1=new Cookie("username",email);
		                Cookie c2=new Cookie("password",pwd);
		                // set cookie time to 14 days
		                c1.setMaxAge(60 * 60 * 24 * 14);
		                c2.setMaxAge(60 * 60 * 24 * 14);
		                response.addCookie(c1);
		                response.addCookie(c2);
					} else {
		                Cookie c1=new Cookie("username",email);
		                Cookie c2=new Cookie("password",pwd);
		                response.addCookie(c1);
		                response.addCookie(c2);
					}
					response.sendRedirect("home.jsp?email=" + email);
					break;
				}
			}
			resultSet.close();
			sta.close();
			conn.close();
			response.sendRedirect("error.jsp?msg=Unregisted username or wrong password!");

		} catch (Exception e) {

		}
	} else if (parameters.containsKey("Add_Sub")) {
		String email = request.getParameter("email");
		String feedurl = request.getParameter("name").trim();
		String subname, sublink;
		if (!feedurl.startsWith("http://")) {
			feedurl = "http://" + feedurl;
		}
		ResultSet resultSet;
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			resultSet = sta
					.executeQuery("select * from freeder.usersub where subxml='"
							+ feedurl + "' && uemail = '"+email+"'");
			if (!resultSet.next()) {
				resultSet = sta
						.executeQuery("select * from freeder.subscriptionslib where subxml='"
								+ feedurl + "'");
				if (!resultSet.next()) {
					new GetSubscriptions(feedurl);
					resultSet = sta
							.executeQuery("select * from freeder.subscriptionslib where subxml='"
									+ feedurl + "'");
				}

				resultSet = sta
				.executeQuery("select * from freeder.subscriptionslib where subxml='"
						+ feedurl + "'");
				while (resultSet.next()) {
					// It is possible to get the columns via name
					// also possible to get the columns via the column number
					// which starts at 1
					// e.g. resultSet.getSTring(2);
					if (resultSet.getString("subxml").equals(feedurl)) {
						subname = resultSet.getString("subname");
						sublink = resultSet.getString("sublink");
						sta.execute("insert into freeder.usersub values('"
								+ email
								+ "', '"
								+ subname
								+ "', '"
								+ feedurl
								+ "', '"
								+ sublink
								+ "', 'unassigned')");
						resultSet.close();
						sta.close();
						conn.close();
						break;
					}
				}
			}
			response.sendRedirect("sidebar.jsp?email=" + email);

			//response.sendRedirect("http://colinzhang.com");

		} catch (Exception e) {
			out.println(e.toString());
		}
	} else if (parameters.containsKey("changepwd")) {
		String email = request.getParameter("email");
		String oldpwd = request.getParameter("oldpwd");
		String newpwd = request.getParameter("pwd");
		ResultSet resultSet;
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			resultSet = sta
					.executeQuery("select * from freeder.users where uemail='" + email + "'");
			resultSet.next();
			if (!oldpwd.equals(resultSet.getString("upwd"))){
				resultSet.close();
				sta.close();
				conn.close();
				response.sendRedirect("profile.jsp?email=" + email+"&status=error");
			} else{
				sta.execute("update freeder.users set upwd='"+newpwd+"' where uemail='"+email+"'");
				resultSet.close();
				sta.close();
				conn.close();
				response.sendRedirect("profile.jsp?email=" + email+"&status=success");
			}

		} catch (Exception e) {

		}
	} else if (parameters.containsKey("deleteonefolder")) {
		String email = request.getParameter("email");
		String fname = request.getParameter("fname");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			ResultSet resultSet=null;
			resultSet = sta.executeQuery("select * from freeder.userfold where uemail='"+email+"' && fname = '"+fname+"'");
			while(resultSet.next()){
				String tmpfid = resultSet.getString("fid");
				sta.execute("update freeder.usersub set fname='unassigned' where fname='"+tmpfid+"'");
				break;
			}
			sta.execute("delete from freeder.userfold where uemail='"+email+"' && fname = '"+fname+"'");
			
			resultSet.close();
			sta.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("folders.jsp?email=" + email);
	} else if (parameters.containsKey("Add_Fold")) {
		String email = request.getParameter("email");
		String fname = request.getParameter("fname");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			ResultSet resultSet;
			resultSet = sta.executeQuery("select * from freeder.userfold where uemail='"+email+"' && fname = '"+fname+"'");
			if (!resultSet.next() && !fname.equals("unassigned")){
				sta.execute("insert into freeder.userfold values (default, '"+email+"', '"+fname+"')");
			}
			resultSet.close();
			sta.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("folders.jsp?email=" + email);
	} else if (parameters.containsKey("Del_Fold")) {
		String email = request.getParameter("email");
		String fname[] = request.getParameterValues("fname");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			Statement sta2 = conn.createStatement();
			// Result set get the result of the SQL query
			ResultSet resultSet = null;
			String tmpfid;
			for(int i=0;i<fname.length;i++){
				resultSet = sta.executeQuery("select * from freeder.userfold where uemail='"+email+"' && fname = '"+fname[i]+"'");
				while (resultSet.next()){
					tmpfid = resultSet.getString("fid");
					sta2.execute("update freeder.usersub set fname='unassigned' where fname='"+tmpfid+"'");
				}
				sta2.execute("delete from freeder.userfold where uemail='"+email+"' && fname = '"+fname[i]+"'");
			}
			resultSet.close();
			sta.close();
			sta2.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("folders.jsp?email=" + email);
	} else if (parameters.containsKey("RN_Fold")) {
		String email = request.getParameter("email");
		String newfname = request.getParameter("newfname");
		String oldfname = request.getParameter("oldfname");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			sta.execute("update freeder.userfold set fname='"+newfname+"' where uemail='"+email+"' && fname = '"+oldfname+"'");
			sta.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("folders.jsp?email=" + email);
	} else if (parameters.containsKey("Un_Sub")) {
		String email = request.getParameter("email");
		String subxml[] = request.getParameterValues("subxml");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			for(int i=0;i<subxml.length;i++){
				sta.execute("delete from freeder.usersub where uemail='"+email+"' && subxml = '"+subxml[i]+"'");
			}
			sta.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("subscriptions.jsp?email=" + email);
	} else if (parameters.containsKey("unsubone")) {
		String email = request.getParameter("email");
		String subxml = request.getParameter("subxml");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			sta.execute("delete from freeder.usersub where uemail='"+email+"' && subxml = '"+subxml+"'");
			sta.close();
			conn.close();
			
		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("subscriptions.jsp?email=" + email);
	} else if (parameters.containsKey("Change_Sub_Name")) {
		String email = request.getParameter("email");
		String subxml = request.getParameter("subxml");
		String subname = request.getParameter("subname");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			sta.execute("update freeder.usersub set subname='"+subname+"' where uemail='"+email+"' && subxml='"+subxml+"'");
			sta.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("subscriptions.jsp?email=" + email);
	} else if (parameters.containsKey("changeonefolder")) {
		String email = request.getParameter("email");
		String subxml = request.getParameter("subxml");
		String fname = request.getParameter("fname");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			sta.execute("update freeder.usersub set fname = '"+fname+"' where uemail='"+email+"' && subxml='"+subxml+"'");
			sta.close();
			conn.close();
			//response.sendRedirect("subscriptions.jsp");
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("subscriptions.jsp?email=" + email);
	} else if (parameters.containsKey("Change_Selected")) {
		String email = request.getParameter("email");
		String subxml[] = request.getParameterValues("subxml");
		String fname = request.getParameter("Change_Selected");
		try {
			// This will load the MySQL driver, each DB has its own driver
			Class.forName("com.mysql.jdbc.Driver");
			// Setup the connection with the DB
			Connection conn = DriverManager.getConnection(url, user,
					passwd);

			// Statements allow to issue SQL queries to the database
			Statement sta = conn.createStatement();
			// Result set get the result of the SQL query
			String tmpfid;
			for(int i=0;i<subxml.length;i++){
				sta.execute("update freeder.usersub set fname = '"+fname+"' where uemail='"+email+"' && subxml='"+subxml[i]+"'");
			}
			sta.close();
			conn.close();
			

		} catch (Exception e) {
			out.println(e.toString());
		}
		response.sendRedirect("subscriptions.jsp?email=" + email);
	} else if (parameters.containsKey("EXPT")){
		String path = request.getRealPath("/");
		String uemail = request.getParameter("email");
		String f = "unassigned";
		String tmpf = "unassigned";
		try {
			File file = new File(path+"OPML.xml");
			if (file.exists()) {

				file.delete();
			}

			System.out.println(file.getPath());
			file.createNewFile();

			BufferedWriter output = new BufferedWriter(new FileWriter(file));
			output.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
			output.newLine();
			output.write("<opml version=\"1.0\">");
			output.newLine();
			output.write("<body>");
			output.newLine();
			Class.forName("com.mysql.jdbc.Driver");
			Connection connect = DriverManager.getConnection(
					"jdbc:mysql://localhost/freeder", "rokeer", "enjoylove");
			Statement tmpsta = connect.createStatement(
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			ResultSet tmpSet = tmpsta
					.executeQuery("select * from freeder.userfold where uemail = '"
							+ uemail + "'");
			Statement statement2 = connect.createStatement();
			ResultSet rs2;
			rs2 = statement2
					.executeQuery("select * from freeder.usersub where uemail='"
							+ uemail + "' and fname='unassigned'");
			while (rs2.next()) {
				output.write("<outline text=\"");
				output.write(rs2.getString("subname"));
				output.write("\"");
				output.write(" title=\"");
				output.write(rs2.getString("subname"));
				output.write("\"");
				output.write(" type=\"rss\"");
				output.write(" xmlUrl=\"");
				output.write(rs2.getString("subxml"));
				output.write("\"");
				output.write(" htmlUrl=\"");
				output.write(rs2.getString("sublink"));
				output.write("\"/>");
				output.newLine();

			}
			Statement statement = connect.createStatement();
			ResultSet rs;
			rs = statement
					.executeQuery("select * from freeder.usersub where uemail='"
							+ uemail + "' and fname<>'unassigned'");

			while (rs.next()) {
				// write each record
				tmpf = rs.getString("fname");
				if (!tmpf.equals(f)){
					tmpSet.first();
					while (!tmpSet.isAfterLast()){
						if (tmpSet.getString("fid").equals(tmpf))
						{
							f = tmpSet.getString("fname");
							break;
						}
						tmpSet.next();
					}
				}
				output.write("<outline title=\"");
				output.write(f);
				output.write("\"");
				output.write(" text=\"");
				output.write(f);
				output.write("\">");
				output.newLine();
				output.write("<outline text=\"");
				output.write(rs.getString("subname"));
				output.write("\"");
				output.write(" title=\"");
				output.write(rs.getString("subname"));
				output.write("\"");
				output.write(" type=\"rss\"");
				output.write(" xmlUrl=\"");
				output.write(rs.getString("subxml"));
				output.write("\"");
				output.write(" htmlUrl=\"");
				output.write(rs.getString("sublink"));
				output.write("\"/>");
				output.newLine();
				output.write("</outline>");
				output.newLine();
			}
			output.write("</body>");
			output.newLine();
			output.write("</opml>");
			System.out.println("OK");
			// close the file
			output.flush();
			statement.close();
			rs.close();
			statement2.close();
			rs2.close();

			output.close();
			out.clear();
			out = pageContext.pushBody();
			
			
			// let user to download opml
			
			OutputStream o = response.getOutputStream();
       byte b[] = new byte[1024];
       // the file to download.
       File fileLoad = new File(path, "OPML.xml");
       // the dialogbox of download file.
       response.setHeader("Content-disposition", "attachment;filename="
              + "OPML.xml");
       // set the MIME type.
       response.setContentType("application/xml");
       // get the file length.
       long fileLength = fileLoad.length();
       String length = String.valueOf(fileLength);
       response.setHeader("Content_Length", length);
       // download the file.
       FileInputStream in = new FileInputStream(fileLoad);
       int n = 0;
       while ((n = in.read(b)) != -1) {
           o.write(b, 0, n);
       }
			
			
			
			
			
			
			
			
			
			
			
		} catch (Exception ex) {
			System.out.println(ex);
		}
	} else if (parameters.containsKey("Log_Out")) {
		
		
		int i;
		//init email and pwd from cookies
		//get Cookie
		Cookie c[]=request.getCookies();
		for(i=0;i<c.length;i++)
		{
		    //if get cookies
		    if("username".equals(c[i].getName()))
		    {
		    	c[i].setMaxAge(0);
		    	response.addCookie(c[i]);
		    }
		        
		    if("password".equals(c[i].getName()))
		    {
		    	c[i].setMaxAge(0);
		    	response.addCookie(c[i]);
		    }
		}
		response.sendRedirect("index.jsp");
		
		
		
		
		
	} 

	//response.sendRedirect("index.jsp?username="+email);
%>

</body>
</html>