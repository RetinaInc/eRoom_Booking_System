package com.erb;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TreeMap;

public class Handler {
	Connection connection;

	public Handler() {
		try {
			connection = new Conn().getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ResultSet getOrders(String username) {
		ResultSet rs = null;
		Statement t;

		try {
			t = connection.createStatement();
			rs = t.executeQuery("select * from ORDERS where USER_ID= '"
					+ username + "' ORDER BY ORDER_ID DESC");
			System.out.println(username);
			System.out.println("getOrders,select done");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet searchWithoutKeyword(String searchDate, String searchFrom,
			String searchTo) {
		ResultSet rs = null;
		Statement t;
		int day = getDay(searchDate);
		try {
			t = connection.createStatement();
			rs = t.executeQuery("SELECT * FROM erb.ROOM WHERE NOT EXISTS (SELECT * FROM "
					+ "erb.ORDERS, erb.IMPORTDATA WHERE (ORDERS.ROOM_NUM = ROOM.ROOM_NUM "
					+ "and (ORDERS.STAT = 'Waiting' or ORDERS.STAT = 'Accept') and ORDERS.DATEA='"
					+ searchDate
					+ "' and (('"
					+ searchFrom
					+ "' >= ORDERS.TIME_FROM and '"
					+ searchFrom
					+ "' <= ORDERS.TIME_TO) or ('"
					+ searchTo
					+ "' >= ORDERS.TIME_FROM and '"
					+ searchTo
					+ "' <= ORDERS.TIME_TO))) or ( IMPORTDATA.ROOM_NUM = ROOM.ROOM_NUM and ("
					+ day
					+ " = IMPORTDATA.DAYS and (('"
					+ searchFrom
					+ "' >= IMPORTDATA.TIME_FROM and '"
					+ searchFrom
					+ "' <= IMPORTDATA.TIME_TO) or ('"
					+ searchTo
					+ "' >= IMPORTDATA.TIME_FROM and '"
					+ searchTo
					+ "' <= IMPORTDATA.TIME_TO)))))");
			System.out.println("getOrders,select done");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public ResultSet searchWithKeyword(String searchDate, String searchFrom,
			String searchTo, String searchType, String searchKeyword) {
		ResultSet rs = null;
		Statement t;
		int day = getDay(searchDate);
		try {
			t = connection.createStatement();
			if (searchType.equals("ROOM_NUM")) {
				rs = t.executeQuery("SELECT * FROM erb.ROOM WHERE ROOM.ROOM_NUM like '%"
						+ searchKeyword
						+ "%' and NOT EXISTS (SELECT * FROM "
						+ "erb.ORDERS, erb.IMPORTDATA WHERE (ORDERS.ROOM_NUM = '"
						+ searchKeyword
						+ "' "
						+ "and (ORDERS.STAT = 'Waiting' or ORDERS.STAT = 'Accept') and ORDERS.DATEA='"
						+ searchDate
						+ "' and (('"
						+ searchFrom
						+ "' >= ORDERS.TIME_FROM and '"
						+ searchFrom
						+ "' <= ORDERS.TIME_TO) or ('"
						+ searchTo
						+ "' >= ORDERS.TIME_FROM and '"
						+ searchTo
						+ "' <= ORDERS.TIME_TO))) or ( IMPORTDATA.ROOM_NUM = '"
						+ searchKeyword
						+ "' and ("
						+ day
						+ " = IMPORTDATA.DAYS and (('"
						+ searchFrom
						+ "' >= IMPORTDATA.TIME_FROM and '"
						+ searchFrom
						+ "' <= IMPORTDATA.TIME_TO) or ('"
						+ searchTo
						+ "' >= IMPORTDATA.TIME_FROM and '"
						+ searchTo
						+ "' <= IMPORTDATA.TIME_TO)))))");
				System.out.println(searchType);
			} else if (searchType.equals("ITEM")) {
				rs = t.executeQuery("SELECT * FROM erb.ROOM WHERE ROOM."
						+ searchType
						+ " like '%"
						+ searchKeyword
						+ "%' and NOT EXISTS (SELECT * FROM "
						+ "erb.ORDERS, erb.IMPORTDATA WHERE (ORDERS.ROOM_NUM = ROOM.ROOM_NUM "
						+ "and (ORDERS.STAT = 'Waiting' or ORDERS.STAT = 'Accept') and ORDERS.DATEA='"
						+ searchDate
						+ "' and (('"
						+ searchFrom
						+ "' >= ORDERS.TIME_FROM and '"
						+ searchFrom
						+ "' <= ORDERS.TIME_TO) or ('"
						+ searchTo
						+ "' >= ORDERS.TIME_FROM and '"
						+ searchTo
						+ "' <= ORDERS.TIME_TO))) or ( IMPORTDATA.ROOM_NUM = ROOM.ROOM_NUM and ("
						+ day + " = IMPORTDATA.DAYS and (('" + searchFrom
						+ "' >= IMPORTDATA.TIME_FROM and '" + searchFrom
						+ "' <= IMPORTDATA.TIME_TO) or ('" + searchTo
						+ "' >= IMPORTDATA.TIME_FROM and '" + searchTo
						+ "' <= IMPORTDATA.TIME_TO)))))");
				System.out.println(searchType);
			} else {
				rs = t.executeQuery("SELECT * FROM erb.ROOM WHERE ROOM."
						+ searchType
						+ " >= "
						+ searchKeyword
						+ " and NOT EXISTS (SELECT * FROM "
						+ "erb.ORDERS, erb.IMPORTDATA WHERE (ORDERS.ROOM_NUM = ROOM.ROOM_NUM "
						+ "and (ORDERS.STAT = 'Waiting' or ORDERS.STAT = 'Accept') and ORDERS.DATEA='"
						+ searchDate
						+ "' and (('"
						+ searchFrom
						+ "' >= ORDERS.TIME_FROM and '"
						+ searchFrom
						+ "' <= ORDERS.TIME_TO) or ('"
						+ searchTo
						+ "' >= ORDERS.TIME_FROM and '"
						+ searchTo
						+ "' <= ORDERS.TIME_TO))) or ( IMPORTDATA.ROOM_NUM = ROOM.ROOM_NUM and ("
						+ day + " = IMPORTDATA.DAYS and (('" + searchFrom
						+ "' >= IMPORTDATA.TIME_FROM and '" + searchFrom
						+ "' <= IMPORTDATA.TIME_TO) or ('" + searchTo
						+ "' >= IMPORTDATA.TIME_FROM and '" + searchTo
						+ "' <= IMPORTDATA.TIME_TO)))))");
				System.out.println(searchType);
			}
			System.out.println("getOrders,select done");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}

	public TreeMap getStatisticsWithoutKeyword(String dateFrom, String dateTo) {
		// Hashtable resultTable = new Hashtable();
		TreeMap resultTree = new TreeMap();
		ResultSet rs = null;
		ResultSet rs2 = null;
		Statement t;
		Statement t2;
		dateTo = nextDate(dateTo);
		double totalHours = getNumOfDays(dateTo, dateFrom) * 15.0;
		int day;
		double usingHours;
		String dateTemp;
		NumberFormat nf = NumberFormat.getPercentInstance();
		nf.setMinimumFractionDigits(2);
		try {
			t = connection.createStatement();
			t2 = connection.createStatement();

			rs = t.executeQuery("SELECT ROOM_NUM FROM erb.ROOM");

			while (rs.next()) {
				usingHours = 0.0;
				dateTemp = dateFrom;
				while (!dateTemp.equals(dateTo)) {
					rs2 = t2.executeQuery("SELECT TIME_FROM, TIME_TO FROM erb.ORDERS WHERE ROOM_NUM='"
							+ rs.getString("ROOM_NUM")
							+ "' && DATEA = '"
							+ dateTemp + "'");
					while (rs2.next()) {
						usingHours = usingHours
								+ (rs2.getInt("TIME_TO") - rs2
										.getInt("TIME_FROM")) / 100.0;
					}
					day = getDay(dateTemp);
					rs2 = t2.executeQuery("SELECT TIME_FROM, TIME_TO FROM erb.IMPORTDATA WHERE ROOM_NUM='"
							+ rs.getString("ROOM_NUM") + "' && DAYS = " + day);
					while (rs2.next()) {
						usingHours = usingHours
								+ (rs2.getInt("TIME_TO") - rs2
										.getInt("TIME_FROM")) / 100.0;
					}
					resultTree.put(rs.getString("ROOM_NUM"),
							nf.format(usingHours / totalHours));
					dateTemp = nextDate(dateTemp);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultTree;
	}

	public TreeMap getStatisticsWithKeyword(String dateFrom, String dateTo,
			String searchKeyword) {
		// Hashtable resultTable = new Hashtable();
		TreeMap resultTree = new TreeMap();
		ResultSet rs = null;
		ResultSet rs2 = null;
		Statement t;
		Statement t2;
		dateTo = nextDate(dateTo);
		double totalHours = getNumOfDays(dateTo, dateFrom) * 15.0;
		int day;
		double usingHours;
		String dateTemp;
		NumberFormat nf = NumberFormat.getPercentInstance();
		nf.setMinimumFractionDigits(2);
		try {
			t = connection.createStatement();
			t2 = connection.createStatement();
			
			rs2 = t2.executeQuery("SELECT ROOM_NUM FROM ROOM WHERE ROOM_NUM LIKE '%"
					+ searchKeyword + "%'");
			if (rs2.next()) {
				rs2.previous();
				while(rs2.next()){
					usingHours = 0.0;
					dateTemp = dateFrom;
				while (!dateTemp.equals(dateTo)) {
					rs = t.executeQuery("SELECT TIME_FROM, TIME_TO FROM erb.ORDERS WHERE ROOM_NUM LIKE '%"
							+ searchKeyword + "%' && DATEA = '" + dateTemp + "'");
					while (rs.next()) {
						usingHours = usingHours
								+ (rs.getInt("TIME_TO") - rs
										.getInt("TIME_FROM")) / 100.0;
					}
					day = getDay(dateTemp);
					rs = t.executeQuery("SELECT TIME_FROM, TIME_TO FROM erb.IMPORTDATA WHERE ROOM_NUM LIKE '%"
							+ searchKeyword + "%' && DAYS = " + day);
					while (rs.next()) {
						usingHours = usingHours
								+ (rs.getInt("TIME_TO") - rs
										.getInt("TIME_FROM")) / 100.0;
					}
					resultTree.put(rs2.getString("ROOM_NUM"),
							nf.format(usingHours / totalHours));
					dateTemp = nextDate(dateTemp);
				}
				}
			} else {
				resultTree.put("null", "null");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultTree;
	}

	public boolean deleteOrder(String userID, String orderID) {
		Statement t;
		try {
			t = connection.createStatement();
			t.execute("delete from ORDERS where ORDER_ID='" + orderID
					+ "' and USER_ID='" + userID + "'");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	public int getMaxOrders(int typeID)
	{
		ResultSet rs = null;
		Statement t;
		try {
			t = connection.createStatement();
			rs = t.executeQuery("select MAX_ORDERS from erb.USERTYPE where USER_TYPE_ID = '"+typeID+"'");
			rs.next();
			return rs.getInt("MAX_ORDERS");
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public int getDaysAdvance(int typeID)
	{
		ResultSet rs = null;
		Statement t;
		try {
			t = connection.createStatement();
			rs = t.executeQuery("select DAYS_ADVANCE from erb.USERTYPE where USER_TYPE_ID = '"+typeID+"'");
			rs.next();
			return rs.getInt("DAYS_ADVANCE");
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public String getTpyeName(int typeID)
	{
		ResultSet rs = null;
		Statement t;
		try {
			t = connection.createStatement();
			rs = t.executeQuery("select TPYE_NAME from erb.USERTYPE where USER_TYPE_ID = '"+typeID+"'");
			rs.next();
			return rs.getString("TYPE_NAME");
		} catch (Exception e) {
			e.printStackTrace();
			return "Null";
		}
	}

	public boolean addOrder(String userID, String ROOM_NUM, String sDate,
			String sFrom, String sTo, String remark) {
		Statement t, t2;
		try {
			ResultSet rs = null;
			t = connection.createStatement();
			t2 = connection.createStatement();
			
			rs = t2.executeQuery("select count(*), USER_TYPE from erb.ORDERS, erb.USERS "
					+ "where ORDERS.USER_ID=USERS.USER_ID and ORDERS.USER_ID='"
					+ userID + "' and ORDERS.STAT='Waiting'");
			rs.next();
			int maxOrders = getMaxOrders(rs.getInt("USER_TYPE"));
			if (rs.getInt("count(*)") >= maxOrders) {
				return false;
			} else {
				if (rs.getInt("USER_TYPE") == 3) {
					t.execute("insert into ORDERS values(DEFAULT, '" + userID
							+ "', '" + ROOM_NUM + "', '" + sDate + "', "
							+ sFrom + ", " + sTo + ", 'Accept', '"+remark+"')");
				} else {
					t.execute("insert into ORDERS values(DEFAULT, '" + userID
							+ "', '" + ROOM_NUM + "', '" + sDate + "', "
							+ sFrom + ", " + sTo + ", 'Waiting', '"+remark+"')");
				}
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	private int getDay(String date) {
		int a = 7;
		int y, m, d;
		String aDate[] = new String[3];
		aDate = date.split("-");
		y = Integer.parseInt(aDate[0]);
		m = Integer.parseInt(aDate[1]);
		d = Integer.parseInt(aDate[2]);
		if ((m == 1) || (m == 2)) {
			m += 12;
			y--;
		}
		a = ((d + 2 * m + 3 * (m + 1) / 5 + y + y / 4 - y / 100 + y / 400) % 7) + 1;
		return a;
	}

	private int getNumOfDays(String dateFrom, String dateTo) {
		DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		Date date2 = null;
		try {
			date = format1.parse(dateFrom);
			date2 = format1.parse(dateTo);
			Calendar aCalendar = Calendar.getInstance();

			aCalendar.setTime(date);

			int day1 = aCalendar.get(Calendar.DAY_OF_YEAR);

			aCalendar.setTime(date2);

			int day2 = aCalendar.get(Calendar.DAY_OF_YEAR);

			int day = day2 - day1;
			if (day < 0) {
				return -day;
			} else {
				return day;
			}

		} catch (ParseException e) {
			e.printStackTrace();
			return 0;
		}
	}

	private String nextDate(String thisDate) {
		Calendar c = Calendar.getInstance();
		Date date = null;
		try {
			date = new SimpleDateFormat("yy-MM-dd").parse(thisDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		c.setTime(date);
		int day = c.get(Calendar.DATE);
		c.set(Calendar.DATE, day + 1);

		String dayAfter = new SimpleDateFormat("yyyy-MM-dd")
				.format(c.getTime());
		return dayAfter;
	}

	public String getDateInWeek(int n, int day) {
		Calendar cal = Calendar.getInstance();
		// n为推迟的周数，1本周，-1向前推迟一周，2下周，依次类推
		cal.add(Calendar.DATE, n * 7);
		// 想周几，这里就传几Calendar.MONDAY（TUESDAY...）
		cal.set(Calendar.DAY_OF_WEEK, day);
		return new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
	}

	public String getLast30Days(int n) {
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, n);
		return new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
	}

	// day = 0 first day, day = 1 last day
	public String getMonthFirstDay(int year, int month, int day) {
		Calendar calendar = Calendar.getInstance();
		if (year != 0) {
			calendar.set(Calendar.YEAR, year);
			calendar.set(Calendar.MONTH, month);
		}
		if (day == 0) {
			calendar.set(Calendar.DAY_OF_MONTH,
					calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
		} else {
			calendar.set(Calendar.DAY_OF_MONTH,
					calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		}
		return new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
	}

}
