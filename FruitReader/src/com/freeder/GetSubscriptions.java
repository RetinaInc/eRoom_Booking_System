package com.freeder;

import java.io.IOException;
import java.net.URLConnection;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

public class GetSubscriptions {

	/**
	 * @param args
	 */
	public Connection connect = null;
	public Statement statement = null;
	public ResultSet resultSet = null;
	public String ittitle, itauthor, itlink, itpubdate, itdescription;

	public GetSubscriptions(String urlStr) throws IllegalArgumentException,
			FeedException, IOException, ClassNotFoundException, SQLException {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");

		URLConnection feedUrl = new java.net.URL(urlStr).openConnection();

		feedUrl.setRequestProperty("User-Agent",
				"Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");

		SyndFeedInput input = new SyndFeedInput();

		SyndFeed feed = input.build(new XmlReader(feedUrl));

		Class.forName("com.mysql.jdbc.Driver");
		// Setup the connection with the DB
		connect = DriverManager.getConnection("jdbc:mysql://localhost/freeder",
				"rokeer", "enjoylove");

		// Statements allow to issue SQL queries to the database
		statement = connect.createStatement();
		statement.execute("SET CHARACTER SET utf8");
		statement.execute("SET NAMES utf8");
		// Result set get the result of the SQL query
		resultSet = statement
				.executeQuery("select * from subscriptionslib where subxml = '"
						+ urlStr + "'");
		if (!resultSet.next()) {
			statement.execute("insert into subscriptionslib values(default, '"
					+ feed.getTitle() + "', '" + urlStr + "', '"
					+ feed.getLink() + "')");
		}
		
		List list = feed.getEntries();
		for (int i = 0; i < list.size(); i++) {
			try{
				SyndEntry entry = (SyndEntry) list.get(i);
				ittitle = entry.getTitle().replaceAll("'", "''").replaceAll("\\x","\\\\x");
				itauthor = entry.getAuthor().replaceAll("'", "''").replaceAll("\\x","\\\\x");
				itlink = entry.getLink().replaceAll("'", "''").replaceAll("\\x","\\\\x");
				itpubdate = fmt.format(entry.getPublishedDate())
						.replaceAll("'", "''").replaceAll("\\x","\\\\x");
				String tmp = entry.getContents().toString();
				if (tmp.equals("[]")) {
					tmp = entry.getDescription().toString();
					itdescription = tmp.substring(22, tmp.length() - 135)
							.replaceAll("'", "''").replaceAll("\\x","\\\\x");
				} else {
					itdescription = tmp.substring(23, tmp.length() - 132)
							.replaceAll("'", "''").replaceAll("\\x","\\\\x");
				}

				resultSet = statement
						.executeQuery("select * from itemlib where itemlink = '"
								+ itlink + "'");
				if (!resultSet.next()) {
					statement.execute("insert into itemlib values(default, '"
							+ ittitle + "', '" + itauthor + "', '" + itlink
							+ "', '" + itpubdate + "', '" + itdescription + "', '"
							+ urlStr + "')");
				}
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			

		}

		statement.close();
		connect.close();

	}

}
