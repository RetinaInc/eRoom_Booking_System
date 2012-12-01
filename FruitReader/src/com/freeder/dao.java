package com.freeder;

import java.io.IOException;
import java.sql.SQLException;

import com.sun.syndication.io.FeedException;

public class dao {

	/**
	 * @param args
	 */

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//getsubscriptions();
		getsubscriptions();
		
	}
	
	public static void getsubscriptions(){
		String urlStr = "http://www.nytimes.com/services/xml/rss/userland/HomePage.xml";
		try {
			new GetSubscriptions(urlStr);
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FeedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	

}
