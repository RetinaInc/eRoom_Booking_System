package com.erb;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if (username != null && password != null) {
			try {
				Connection connection = new Conn().getConnection();
				ResultSet rs = null;
				Statement t;
				t = connection.createStatement();

				rs = t.executeQuery("select * from USERS where USER_ID = '"
						+ username + "' && USER_PWD = '" + password + "'");

				if (rs.next()) {
					Cookie c1 = new Cookie("username", username);
					Cookie c2;

					c2 = new Cookie("usertype", rs.getString("USER_TYPE"));
					response.addCookie(c1);
					response.addCookie(c2);

					if (rs.getInt("USER_TYPE") != 3) {
						response.sendRedirect("main.jsp");
					} else {
						response.sendRedirect("admin/main.jsp");
					}
				} else {
					response.sendRedirect("index.jsp?word=Wrong username or password!");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

}
