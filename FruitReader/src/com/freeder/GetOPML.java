package com.freeder;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

import com.sun.syndication.feed.opml.Opml;
import com.sun.syndication.feed.opml.Outline;
import com.sun.syndication.io.FeedException;
import com.sun.syndication.io.WireFeedInput;

public class GetOPML {

	GetOPML() {
		try {
		 WireFeedInput input = new WireFeedInput();
		  Opml feed;
		
			feed = (Opml) input.build( new File(".xml") );
		
		  List<Outline> outlines = (List<Outline>) feed.getOutlines();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (FeedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	GetOPML(String uemail) {

	}
}
