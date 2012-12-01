package com.erb;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class User_data {
	ResultSet rs = null;
	java.sql.Connection conn=null;
	java.sql.Statement stmt=null;

	public User_data() {
		try {
			conn = new Conn().getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ResultSet userdata() {
		try {
			stmt=conn.createStatement();
			String sqlstmt="";
			sqlstmt="Select * from users";
			rs = stmt.executeQuery(sqlstmt);
			System.out.println("Userdata loaded");
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
