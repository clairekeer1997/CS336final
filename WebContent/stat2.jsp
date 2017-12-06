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

<center><font size = 8>Top 5 Paying Customers</font></center>

	<%
	try {
		String sDate = request.getParameter("startDate");
		String eDate = request.getParameter("endDate");

		String url = "jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb";
		Class.forName("com.mysql.jdbc.Driver");				
		Connection con = DriverManager.getConnection(url, "JTSR", "336HotelJTSR");
		Statement stmt = con.createStatement();
		
		String str = "SELECT Customer.FirstName, Customer.LastName, SUM(Reservation.TotalAmt) FROM Customer, Reservation WHERE Customer.Username = Reservation.UserName AND Reservation.ResDate > '" + sDate + "' AND Reservation.ResDate < '" + eDate + "' GROUP BY Customer.FirstName ORDER BY Reservation.TotalAmt DESC";
		ResultSet result = stmt.executeQuery(str);

		if(result.next() == false){
			con.close();
			%>
			<script>
				alert("No completed reservations in the database.");
				window.location.href = "Analysis.jsp"
			</script>
			<%
		}
		
		out.print("Top 5 Paying Customers.");
		
		for(int i = 0; i < 4; i++){
			%><br><%
			String firstName = result.getString(1);
			String lastName = result.getString(2);
			String amt = result.getString(3);
			out.print(firstName + " " + lastName + " - " + amt);
			if(!result.next()){ break; }
		}
			
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