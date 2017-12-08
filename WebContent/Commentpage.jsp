<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comments</title>
</head>
<body>
<h2>Thank you for Submitting your review!</h2>
<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
		String entity = request.getParameter("CommentType");
		System.out.println("entity" + entity);
		
		if(entity.equals("room")){
			String hotelid1 = request.getParameter("hotelID1");
			String roomid1 = request.getParameter("roomID1");
			String checkin = request.getParameter("inDate");
			String checkout = request.getParameter("outDate");
			String rating = request.getParameter("rating");
			String comment = request.getParameter("paragraph_text");
			if(rating.matches("[a-zA-Z]*")){ //|| Integer.parseInt(rating) > 10 || Integer.parseInt(rating) < 0){
				%>
				<script>
					alert("Invaild Rating Input.");
					window.location.href = "Reviewpage.jsp"
				</script>
				<%
			}
			String update = "UPDATE Reserves SET Rating= " + rating +
					", TextComment= "+"'"+  comment + "'"+
					" WHERE HotelID=" +hotelid1 + " AND RoomNo=" + roomid1+ " AND inDate=" + "'" + checkin+ "'"+";"; 
			Statement st= con.createStatement();
			int i = st.executeUpdate(update);
		
		}else if(entity.equals("br")){
			String bfid = request.getParameter("bfID");
			String rating = request.getParameter("rating");
			String comment = request.getParameter("paragraph_text");
			if(Integer.parseInt(rating) > 10 || Integer.parseInt(rating) < 0){
				%>
				<script>
					alert("Invaild Rating Input.");
					window.location.href = "Reviewpage.jsp"
				</script>
				<%
			}
			String update = "UPDATE bTypeOrdered SET Rating = " + rating +
					", TextComment= "+"'"+  comment + "'"+
					" WHERE BreakfastID =" + bfid + ";"; 
			Statement st= con.createStatement();
			int i = st.executeUpdate(update);
			
		}else if(entity.equals("sev")){
			String sevid = request.getParameter("sevID");
			String rating = request.getParameter("rating");
			String comment = request.getParameter("paragraph_text");
			if(Integer.parseInt(rating) > 10 || Integer.parseInt(rating) < 0){
				%>
				<script>
					alert("Invaild Rating Input.");
					window.location.href = "Reviewpage.jsp"
				</script>
				<%
			}
			String update = "UPDATE sTypeOrdered SET Rating= " + rating +
					", TextComment= "+"'"+  comment + "'"+
					" WHERE ServiceID=" +sevid + ";"; 
			Statement st= con.createStatement();
			int i = st.executeUpdate(update);
		}
	}
	catch(Exception e){
		e.printStackTrace();
	}

%>
</body>
</html>