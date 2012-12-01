package com.erb;

import java.io.*;
import java.util.*;
import org.w3c.dom.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class controller
 */
public class controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String PERMISSION = "admin/mainpages/permission_man.jsp";
	private static String APPLICATION = "admin/mainpages/application.jsp";
	public ResultSet resultSet;
	public int id_num = 1;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Map parameters = request.getParameterMap();
		String forward = "";
		int permission_num = 0;
		int application_num = 0;

		// THE DATABASE INITICALIZATION
		java.sql.Connection conn = null;
		java.sql.Statement stmt = null;

		System.out.println("database connected");

		// THE PAGE KEYS SELECT
		if (!parameters.containsKey("dowhat")||request.getParameter("dowhat").equals("nothing")) {
			while (!((parameters.containsKey("promote" + permission_num))
					|| (parameters.containsKey("demote" + permission_num))
					|| (parameters.containsKey("approval" + application_num)) || (parameters
					.containsKey("reject" + application_num)))) {
				permission_num++;
				application_num++;
				// System.out.println(permission_num+"||"+application_num);
			}

			if (parameters.containsKey("promote" + permission_num)) {
				String uid = request.getParameter("uid" + permission_num);
				System.out.println(uid);
				// DATABASE PROGRAM FOR PREMISSION
				try {

					conn = new Conn().getConnection();
					stmt = conn.createStatement();
					String sqlstmt = "";
					String utypes = "";
					int utype = 0;

					sqlstmt = "select USER_TYPE from users where USER_ID='"
							+ uid + "'";
					resultSet = stmt.executeQuery(sqlstmt);

					// if(sqlstmt!=null){System.out.println("User data loaded");}

					while (resultSet.next()) {
						utypes = resultSet.getString(1);
					}
					utype = Integer.parseInt(utypes);
					switch (utype) {
					case 1:
						utype = 2;
						break;
					case 2:
						utype = 3;
						break;
					case 3:
						utype = 3;
						break;
					}
					System.out.println(utype);
					sqlstmt = "update users set USER_TYPE='" + utype
							+ "' where USER_ID='" + uid + "'";
					stmt.addBatch(sqlstmt);
					stmt.executeBatch();

					conn.close();
					System.out.println("database Closed");

				} catch (Exception e) {
					e.printStackTrace();
				}

				System.out.println("Success");
				forward = PERMISSION;
			}

			else if (parameters.containsKey("demote" + permission_num)) {
				String uid = request.getParameter("uid" + permission_num);
				System.out.println(uid);
				// DATABASE PROGRAM FOR PREMISSION

				try {

					conn = new Conn().getConnection();
					stmt = conn.createStatement();
					String sqlstmt = "";
					String utypes = "";
					int utype = 0;

					sqlstmt = "select USER_TYPE from users where USER_ID='"
							+ uid + "'";
					resultSet = stmt.executeQuery(sqlstmt);
					while (resultSet.next()) {
						utypes = resultSet.getString(1);
					}

					utype = Integer.parseInt(utypes);
					switch (utype) {
					case 1:
						utype = 1;
						break;
					case 2:
						utype = 1;
						break;
					case 3:
						utype = 2;
						break;
					}
					sqlstmt = "update users set USER_TYPE='" + utype
							+ "' where USER_ID='" + uid + "'";
					stmt.addBatch(sqlstmt);
					stmt.executeBatch();

					conn.close();
					System.out.println("database Closed");

				} catch (Exception e) {
					e.printStackTrace();
				}

				System.out.println("Success");
				forward = PERMISSION;
			}

			else if (parameters.containsKey("approval" + application_num)) {
				String orderid = request.getParameter("uid" + application_num);
				System.out.println(orderid);
				String page = request.getParameter("page");
				try {
					conn = new Conn().getConnection();
					stmt = conn.createStatement();

					String sqlstmt = "";
					String status = "";

					sqlstmt = "update orders set STAT='Accept' where ORDER_ID='"
							+ orderid + "'";
					stmt.addBatch(sqlstmt);
					stmt.executeBatch();

					conn.close();
					System.out.println("database Closed");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				forward = APPLICATION+"?page="+page;
			}

			else if (parameters.containsKey("reject" + application_num)) {
				String orderid = request.getParameter("uid" + application_num);
				System.out.println(orderid);
				String page = request.getParameter("page");
				try {
					conn = new Conn().getConnection();
					stmt = conn.createStatement();

					String sqlstmt = "";
					String status = "";

					sqlstmt = "update orders set STAT='Reject' where ORDER_ID='"
							+ orderid + "'";
					stmt.addBatch(sqlstmt);
					stmt.executeBatch();

					conn.close();
					System.out.println("database Closed");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				forward = APPLICATION+"?page="+page;
			}

		} else {
			System.out.println("act_all");
			String act = request.getParameter("dowhat");
			String orderid[] = request.getParameterValues("act_select");
			String page = request.getParameter("page");
			if (!act.equals("nothing")) {
				try {
					conn = new Conn().getConnection();
					stmt = conn.createStatement();

					String sqlstmt = "";
					String status = "";
					for (int i = 0; i < orderid.length; i++) {
						sqlstmt = "update orders set STAT='"+act+"' where ORDER_ID='"
								+ orderid[i] + "'";
						stmt.addBatch(sqlstmt);
						stmt.executeBatch();
					}
					conn.close();
					System.out.println("database Closed");
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			forward = APPLICATION+"?page="+page;
		}
		response.sendRedirect(forward);
	}

}
