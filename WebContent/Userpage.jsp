<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hulton Hotel Account</title>
</head>
<body>	
	<center>
	<font size = 8>My Account</font>
	</center>
	<br>
	<br>
	<%try{
			request.getSession().removeAttribute("invoiceNo");
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			String username = session.getAttribute("user_name").toString();
			//String username = "teacher1";
			Statement t = con.createStatement();
			//System.out.println(username);
			String sqls = "SELECT r.InvoiceNo\n" + "FROM Reservation r\n" + "WHERE r.Username = \"" + username + "\"";
			ResultSet res = t.executeQuery(sqls);
	%>
		<center>
			<form action = "mainOrderPage.jsp">
				<input type = "Submit" value = "Make a Reservation" name = "reservation">
			</form>
			<br>
			<br>
		    <h1> My Reservations</h1>
		        <form action="Reviewpage.jsp">
		        	<select name="invoiceNum" size=1>
		        	<%  while(res.next()){ %>
		        		<option value="<%= res.getString(1) %>"><%= res.getString(1) %></option>
		        	 <% } %>
		        	</select>
		        	<input type = "Submit" value = "view">
		        </form>
		    <br>
		</center>
			
		<%}
		catch(Exception e){
			e.printStackTrace();
		}
	%>

</body>

<style>
input[name = reservation]{
		height: 150px;
		width: 350px;
		border: none;
    	font-size:36px;
	}
</style>

<a href="LoginRegistration.jsp">Logout</a>

</html>