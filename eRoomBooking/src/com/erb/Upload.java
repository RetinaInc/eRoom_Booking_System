package com.erb;

import java.io.File;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import java.io.PrintWriter; 
import javax.servlet.ServletConfig; 
import com.jspsmart.upload.SmartUpload; 
import com.jspsmart.upload.SmartUploadException;


/**
 * Servlet implementation class Upload
 */
public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static String SUCC_JSP = "admin/mainpages/success.jsp";
	private static String ERR_JSP = "admin/mainpages/error.jsp";
	public ResultSet resultSet;

	public int id_num=1;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Upload() {
        super();
        // TODO Auto-generated constructor stub
    }



	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response); 

		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Map parameters = request.getParameterMap();
		String forward="";
		
		
		// THE DATABASE INITICALIZATION
		java.sql.Connection conn=new Conn().getConnection();;
		java.sql.Statement stmt=null;
		
		System.out.println("database connected");
		
	
			//THE XML READER INITIALIZATION
			long   lasting   =System.currentTimeMillis(); 
			PageContext pageContext=JspFactory.getDefaultFactory().getPageContext(this, request, response, null, true, 8192, true);
			String xmlurl=request.getRealPath("/")+"importdata.xml";
			 			 
			try{     
				//DATABASE PROGRAM
				stmt=conn.createStatement();
				
				stmt.addBatch("delete From importdata");
	            stmt.executeBatch();
				System.out.println("table initialized");
				String sqlstmt="";
				
				//XML READER PROGRAM
				File   f=new   File(xmlurl);    
				DocumentBuilderFactory   factory=DocumentBuilderFactory.newInstance();   
				DocumentBuilder   builder=factory.newDocumentBuilder();   
				Document   doc   =   builder.parse(f);   
				
		
				NodeList nl   =   doc.getElementsByTagName("SCHEDULES");

				 for (int i = 0; i<nl.getLength(); i++) {
					 	String days  =doc.getElementsByTagName("DAY").item(i).getFirstChild().getNodeValue();
					 	String room =doc.getElementsByTagName("ROOM").item(i).getFirstChild().getNodeValue();
					 	String tfroms = doc.getElementsByTagName("TIMEF").item(i).getLastChild().getNodeValue();
					 	String ttos = doc.getElementsByTagName("TIMET").item(i).getLastChild().getNodeValue();
					 	int day=0;
					 	int tfrom=0;
					 	int tto=0;
					 	
					 	
			            
					 	day = Integer.parseInt(days); 
					 	tfrom = Integer.parseInt(tfroms); 
					 	tto = Integer.parseInt(ttos); 
					 	//System.out.print(day+"day SCHEDULE:"+room);
					    //System.out.println("  from"+tfrom+" to"+tto);
					 	//System.out.println(id_num);
					 	
					    //sqlstmt="insert into importdata values('"+id_num+"','"+"'"+room+"','"+day+"','"+tfrom+"','"+tto+"')";
					 	stmt.addBatch("insert into importdata values('"+id_num+"','"+room+"','"+day+"','"+tfrom+"','"+tto+"')");
			            stmt.executeBatch();
					 	id_num++;
					}
			
				 	conn.close();
				 	
				 	System.out.println("Connection closed");
				 	
					  } catch (Exception e) {
					   e.printStackTrace();
					   response.sendRedirect(ERR_JSP);
					  }		
			response.sendRedirect(SUCC_JSP);
	}

}
