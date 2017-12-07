<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%ResultSet resultset =null;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Statistics Page</title>


<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Datepicker - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $(document).ready(function () {

	    $("#datepicker").datepicker({
	        dateFormat: "yy-mm-dd",
	        onSelect: function (date) {
	            var date2 = $('#datepicker').datepicker('getDate');
	            date2.setDate(date2.getDate() + 1);
	            $('#datepicker1').datepicker('setDate', date2);
	            //sets minDate to dt1 date + 1
	            $('#datepicker1').datepicker('option', 'minDate', date2);
	        }
	    });
	    $('#datepicker1').datepicker({
	        dateFormat: "yy-mm-dd",
	        onClose: function () {
	            var dt1 = $('#datepicker').datepicker('getDate');
	            var dt2 = $('#datepicker1').datepicker('getDate');
	            //check to prevent a user from entering a date below date of dt1
	            if (dt2 <= dt1) {
	                var minDate = $('#datepicker1').datepicker('option', 'minDate');
	                $('#datepicker1').datepicker('setDate', minDate);
	            }
	        }
	    });
	    
	    $("#datepicker2").datepicker({
	        dateFormat: "yy-mm-dd",
	        onSelect: function (date) {
	            var date4 = $/('#datepicker2').datepicker('getDate');
	            date4.setDate(date4.getDate() + 1);
	            $('#datepicker3').datepicker('setDate', date4);
	            //sets minDate to dt1 date + 1
	            $('#datepicker3').datepicker('option', 'minDate', date4);
	        }
	    });
	    $('#datepicker3').datepicker({
	        dateFormat: "yy-mm-dd",
	        onClose: function () {
	            var dt3 = $('#datepicker2').datepicker('getDate');
	            var dt4 = $('#datepicker3').datepicker('getDate');
	            //check to prevent a user from entering a date below date of dt3
	            if (dt4 <= dt3) {
	                var minDate = $('#datepicker3').datepicker('option', 'minDate');
	                $('#datepicker3').datepicker('setDate', minDate);
	            }
	        }
	    });

	    $("#datepicker4").datepicker({
	        dateFormat: "yy-mm-dd",
	        onSelect: function (date) {
	            var date6 = $('#datepicker4').datepicker('getDate');
	            date6.setDate(date6.getDate() + 1);
	            $('#datepicker5').datepicker('setDate', date6);
	            //sets minDate to dt1 date + 1
	            $('#datepicker5').datepicker('option', 'minDate', date6);
	        }
	    });
	    $('#datepicker5').datepicker({
	        dateFormat: "yy-mm-dd",
	        onClose: function () {
	            var dt5 = $('#datepicker4').datepicker('getDate');
	            var dt6 = $('#datepicker5').datepicker('getDate');
	            //check to prevent a user from entering a date below date of dt3
	            if (dt6 <= dt5) {
	                var minDate = $('#datepicker4').datepicker('option', 'minDate');
	                $('#datepicker4').datepicker('setDate', minDate);
	            }
	        }
	    });

	    $("#datepicker6").datepicker({
	        dateFormat: "yy-mm-dd",
	        onSelect: function (date) {
	            var date8 = $('#datepicker6').datepicker('getDate');
	            date8.setDate(date8.getDate() + 1);
	            $('#datepicker7').datepicker('setDate', date8);
	            //sets minDate to dt1 date + 1
	            $('#datepicker7').datepicker('option', 'minDate', date8);
	        }
	    });
	    $('#datepicker7').datepicker({
	        dateFormat: "yy-mm-dd",
	        onClose: function () {
	            var dt7 = $('#datepicker6').datepicker('getDate');
	            var dt8 = $('#datepicker7').datepicker('getDate');
	            //check to prevent a user from entering a date below date of dt3
	            if (dt8 <= dt7) {
	                var minDate = $('#datepicker6').datepicker('option', 'minDate');
	                $('#datepicker6').datepicker('setDate', minDate);
	            }
	        }
	    });
	});
  </script>
  
</head>

<body>
<center><font size = 8>Admin Statistics Page</font></center>

<br>
	<form method="post" action="stat1.jsp">
	<center>
	<tr><td>Beg Date: </td>
	<td> <input type="text" id="datepicker" name = "startDate"></td>
	<br>
	<td>End Date:</td>
	<td> <input type="text" id="datepicker1" name = "endDate"></td></tr>
	<br>
	<input type="submit" value="Highest Rated Room Type for Each Hotel">
	</center>
	</form>
<br>

<br>
	<form method="post" action="stat2.jsp">
	<center>
	<tr><td>Beg Date: </td>
	<td> <input type="text" id="datepicker2" name = "startDate"></td>
	<br>
	<td>End Date:</td>
	<td> <input type="text" id="datepicker3" name = "endDate"></td></tr>
	<br>
	<input type="submit" value="Top 5 Best Customers">
	</center>
	</form>
<br>

<br>
	<form method="post" action="stat3.jsp">
	<center>
	<tr><td>Beg Date: </td>
	<td> <input type="text" id="datepicker4" name = "startDate"></td>
	<br>
	<td>End Date:</td>
	<td> <input type="text" id="datepicker5" name = "endDate"></td></tr>
	<br>
	<input type="submit" value="Highest Rated Breakfast">
	</center>
	</form>
<br>

<br>
	<form method="post" action="stat4.jsp">
	<center>
	<tr><td>Beg Date: </td>
	<td> <input type="text" id="datepicker6" name = "startDate"></td>
	<br>
	<td>End Date:</td>
	<td> <input type="text" id="datepicker7" name = "endDate"></td></tr>
	<br>
	<input type="submit" value="Highest Rated Service">
	<br>
	</center>
	</form>
<br>


	<%
	try {
		//Create a connection string
		String url = "jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
				
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "JTSR", "336HotelJTSR");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Search the Customer DB
//		String str = "SELECT * FROM Customer WHERE Username = '" + username + "'";
		
		//Run the query against the database.
//		ResultSet result = stmt.executeQuery(str);

//		if(result.next() == false){
//		}
				
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	} catch (Exception ex) {
		out.print("Oops! Something broke. Please hit the hyperlink below and try again.");
	}
	%>
	</br>
	<a href="LoginRegistration.jsp">Admin Log Out</a>
</body>
</html>
