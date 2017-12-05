<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Reservations</title>
</head>
<body>	
	<center>
	<font size = 7 style="text-align:center">Reservation Details</font>
	</center>
	
	<br>
	<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			int invoiceNum = 0;
			invoiceNum = Integer.parseInt(request.getParameter("invoiceNum"));
			//get room resultset;
			Statement room = con.createStatement();
			String roomsql = "SELECT re.HotelID, re.RoomNo, re.inDate, re.outDate\n" + "FROM Reserves re\n" + "WHERE re.InvoiceNo = \"" + invoiceNum + "\"";
			ResultSet roomres = room.executeQuery(roomsql);
			
			//get breakfast resultset;
			Statement bf = con.createStatement();
			String bfsql = "SELECT bo.HotelID, bo.RoomNo, bo.BreakfastID, bo.bType\n" + "FROM bTypeOrdered bo\n" + "WHERE bo.InvoiceNo = \"" + invoiceNum + "\"";
			ResultSet bfres = bf.executeQuery(bfsql);
			
			//get service resultset;
			Statement sev = con.createStatement();
			String sevsql = "SELECT so.HotelID, so.RoomNo, so.ServiceID, so.sType\n" + "FROM sTypeOrdered so\n" + "WHERE so.InvoiceNo = \"" + invoiceNum + "\"";
			ResultSet sevres = sev.executeQuery(sevsql);
			
			
			
			 %>
			 <h1>Room Reservations</h1>
			 	<%while(roomres.next()){	
			 	%>
				<form action = Commentpage.jsp >
				Hotel: <input type = "text" name = hotelID1 value = <%= roomres.getString(1) %>>
				Room: <input type = "text" name = roomID1 value = <%= roomres.getString(2) %>>
				CheckIn Date: <input type = "text" name = inDate value = <%= roomres.getString(3) %>>
				CheckOut Date: <input type = "text" name = outDate value = <%= roomres.getString(4) %>>
				<input type = "hidden" name = CommentType value = "room">
				<br>
				Rating:<input type = "text" name = rating> (Number from 1 to 10 only)
				<br>
				please write some comment here:				
				<br>
				<textarea name="paragraph_text" cols="50" rows="6"></textarea>
				<br>
				<input type = "Submit" value = "submit">
				<br>
				<br>
				</form>
				<% } %>
		     <h1>Breakfast Ordered</h1> 
		     <%while(bfres.next()){ %>
		     	<form action = Commentpage.jsp>
				Hotel: <input type = "text" name = hotelID2 value = <%= bfres.getString(1) %>>
				Room: <input type = "text" name = roomID2 value = <%= bfres.getString(2) %>>
				<input type = "hidden" name = bfID value = <%= bfres.getString(3) %>>
				Breakfast Type: <input type = "text" name = bfType value = <%= bfres.getString(4) %>>
				<input type = "hidden" name = CommentType value = "br">
				<br>
				Rating:<input type = "text" name = rating> (Number from 1 to 10 only)
				<br>
				please write some comment here:				
				<br>
				<textarea name="paragraph_text" cols="50" rows="6"></textarea>
				<br>
				<input type = "Submit" value = "submit">
				<br>
				<br>
				
				</form>	
			 <% } %>

		     <h1>Service Ordered</h1>  	
		     	 <%while(sevres.next()){ %>
				<form action = Commentpage.jsp>
				Hotel: <input type = "text" name = hotelID3 value = <%= sevres.getString(1) %>>
				Room: <input type = "text" name = roomID3 value = <%= sevres.getString(2) %>>
				<input type = "hidden" name = sevID value = <%= sevres.getString(3) %>>
				Service Type: <input type = "text" name = sevType value = <%= sevres.getString(4) %>>
				<input type = "hidden" name = CommentType value = "sev">
				<br>
				Rating:<input type = "text" name = rating> (Number from 1 to 10 only)
				<br>
				please write some comment here:				
				<br>
				<textarea name="paragraph_text" cols="50" rows="6" maxlength = 1000></textarea>
				<br>
				<input type = "Submit" value = "submit">
				<br>
				<br>
				</form>	
				<% } %>	
		<%}
		catch(Exception e){
			e.printStackTrace();
		}
	%>

</body>
<style>
body {
    background-image: url("file:///Users/claireyou/Desktop/hotel.jpg");
}
</style>
</html>