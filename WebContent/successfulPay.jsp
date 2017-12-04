<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Calendar,java.text.SimpleDateFormat,java.util.Date, java.text.DateFormat, java.util.concurrent.TimeUnit"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>
<body>
<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			Statement t = con.createStatement();
			String hotelName = session.getAttribute("h").toString();
			String roomType  = session.getAttribute("r").toString();
			String sqls = "SELECT h.HotelID FROM Hotel h Where h.Name = '" + hotelName + "'";
			ResultSet res = t.executeQuery(sqls);
			res.next();
			int hotelId = res.getInt(1);
			
			sqls = "SELECT Price FROM Room Where HotelID = '" + hotelId + "'" + " AND Type = " + "'" + roomType + "'";
			res = t.executeQuery(sqls);
			res.next();
			float price = res.getFloat(1);
			out.print(price);
			//res = t.executeQuery(sqls)
			
			//out.println(sqls);
			//String price = res.getString(3);
		}catch(Exception ex){
			out.println("LOL");
		}

			

%>
</body>
</html>