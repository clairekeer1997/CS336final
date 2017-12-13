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
	<form method = "post" action = "mainOrderPage.jsp">
	<center>
	<h1>Make Your Reservation</h1>
	<table>
	
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			Statement t = con.createStatement();
			String Country  = request.getParameter("countrySelection");
			session.setAttribute("countrySelection", Country);
			String sqls = "SELECT DISTINCT State FROM Hotel WHERE Country = '" + Country + "'";
			ResultSet res = t.executeQuery(sqls);
	%>	
	
	<tr><td>Select State: </td><td>
	<select name = "stateSelection">
		<%  while(res.next()){ 
		String state = res.getString(1);
		%>
			<option value = <%= state %>> <%= state %> </option>
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
	
	<tr><td> <input type = "submit" id = "mainOrder" value = "Go make your order"></td></tr>
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