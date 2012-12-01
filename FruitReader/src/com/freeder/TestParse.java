package com.freeder;

import java.net.URI;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.io.File;
import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import com.sun.syndication.feed.opml.Opml;
import com.sun.syndication.feed.opml.Outline;
import com.sun.syndication.feed.synd.SyndCategory;
import com.sun.syndication.feed.synd.SyndContent;
import com.sun.syndication.feed.synd.SyndEnclosure;
import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.WireFeedInput;
import com.sun.syndication.io.XmlReader;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import java.io.File;
import java.net.MalformedURLException;

public class TestParse {

	public static void main(String[] args) {
		TestParse test = new TestParse();
		test.parseRss();

	}

	public Document read(String fileName) throws MalformedURLException,
			DocumentException {
		SAXReader reader = new SAXReader();
		Document document = reader.read(new File(fileName));
		return document;
	}

	public Element getRootElement(Document doc) {
		return doc.getRootElement();
	}

	static void p(String s) {
		System.out.println(s);
	}

	public void parseRss() {
		ArrayList sName = new ArrayList(10);
		ArrayList sType = new ArrayList(10);
		// String rss =
		// "http://news.baidu.com/n?cmd=1&class=civilnews&tn=rss&sub=0]http://news.baidu.com/n?cmd=1&class=civilnews&tn=rss&sub=0";
		// String FILE_NAME = "xml/google-reader-subscriptions.xml";
		String FILE_NAME = "http://colinzhang.com/grs.xml";

		TestParse d = new TestParse();
		try {
			URL url = new URL(FILE_NAME);

			// File dir = new File("D:g.xml");
			// p("File Name: " + dir.getName());
			// p ("Path: " + dir.getPath());
			// XmlReader reader = new XmlReader(dir);

			WireFeedInput input = new WireFeedInput();
			Opml feed = (Opml) input.build(new File("OPML.xml"));
			List<Outline> outlines = (List<Outline>) feed.getOutlines();
			p(outlines.get(1).getTitle());

			// System.out.println(feed);
			// XmlReader a = new XmlReader(reader);
			// String root;
			// ·µ»ØDocument¶ÔÏó
			// d.read(FILE_NAME);
			// root=d.getRootElement(d.read(FILE_NAME)).getName();
			// System.out.println("RssÔŽµÄ±àÂëžñÊœÎª£º" + root);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
