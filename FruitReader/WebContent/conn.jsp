<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.ResultSetMetaData" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.SQLException" %>

<%  
	String drv = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost/freeder";
    //String url1 = "jdbc:mysql://localhost/bookstore?digitgulf?useUnicode=true&characterEncoding=utf-8";
	String user = "rokeer";
	String passwd = "enjoylove";
%>