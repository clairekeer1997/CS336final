<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.util.ArrayList, java.util.Iterator"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Analysis - 1</title>
</head>
<body>

<center><font size = 8>Top Rated Breakfast</font></center>

	<%
	try {
		String sDate = request.getParameter("startDate");
		String eDate = request.getParameter("endDate");

		String url = "jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb";
		Class.forName("com.mysql.jdbc.Driver");				
		Connection con = DriverManager.getConnection(url, "JTSR", "336HotelJTSR");
		Statement stmt = con.createStatement();
		
		String str = "SELECT bTypeOrdered.bType, bTypeOrdered.Rating FROM bTypeOrdered, Reservation WHERE bTypeOrdered.InvoiceNo = Reservation.InvoiceNo AND Reservation.ResDate > '" + sDate + "' AND Reservation.ResDate < '" + eDate + "' ORDER BY Rating DESC";
		ResultSet result = stmt.executeQuery(str);

		if(result.next() == false){
			con.close();
			%>
			<script>
				alert("No rated breakfasts in the database for this time period.");
				window.location.href = "Analysis.jsp"
			</script>
			<%
		}
		
		String breakfast = result.getString(1);
		String rating = result.getString(2);

		if(rating == null){
			con.close();
			%>
			<script>
				alert("No rated breakfasts in the database for this time period.");
				window.location.href = "Analysis.jsp"
			</script>
			<%
		}
		
		%><br><%
		%><br><%
		
		out.print("Highest Rated Breakfast Type is: " + breakfast + " with a rating of: " + rating);

		%><br><%
		%><br><%
			
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	%>
	<br>
	<a href="LoginRegistration.jsp">Admin Log Out</a>
</body>
</html>