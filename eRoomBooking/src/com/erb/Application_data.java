package com.erb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Application_data {
	Connection conn=null;


	public Application_data() {
		try {
			conn = new Conn().getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ResultSet applicationdata() {
		ResultSet rs = null;
		Statement stmt=null;
		try {
			stmt=conn.createStatement();
			String sqlstmt="";
			sqlstmt="Select * from orders ORDER BY ORDER_ID DESC";
			rs = stmt.executeQuery(sqlstmt);
			System.out.println("application data loaded");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
		
	}
	
	public void connclose()
	{
		try {
			conn.close();
			System.out.println("connection closed");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
