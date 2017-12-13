<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%ResultSet resultset =null;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> reservation - JTSR Hotel Order System</title>
</head>

<body>
<font size = 6>Welcome to Hulton Hotels </font>
<br>
	<form method = "post" action = "selectState.jsp">
	<center>
	<h1>Make Your Reservation</h1>
	<table>
	
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			Statement t = con.createStatement();
			String sqls = "SELECT DISTINCT Country FROM Hotel";
			ResultSet res = t.executeQuery(sqls);
	%>	
	
	<tr><td>Select country: </td><td>
	<select name = "countrySelection">
		<%  while(res.next()){ 
		String country = res.getString(1);
		%>
			<option value = <%= country %>> <%= country%> </option>
		<%} 
		con.close();
		%>
	</select>
	</td></tr>
	<%}
		catch(Exception e){
			e.printStackTrace();
		}
	%>
	
	<tr><td> <input type = "submit" id = "selectState" value = "Go Select State"></td></tr>
	</table>
	</center>
	</form>
<a href="LoginRegistration.jsp">Logout</a>
</body>
<style>
body {
    background-image: url("file:///Users/claireyou/git/CS336final/WebContent/WEB-INF/pic3.png");
    background-size:100% 250%;
}
</style>
</html>