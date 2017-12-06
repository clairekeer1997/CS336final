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

<center><font size = 8>Highest Rated Room Type For Each Hotel</font></center>

	<%
	try {
		
		String sDate = request.getParameter("startDate");
		String eDate = request.getParameter("endDate");

		String url = "jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb";
		Class.forName("com.mysql.jdbc.Driver");				
		Connection con = DriverManager.getConnection(url, "JTSR", "336HotelJTSR");
		Statement stmt = con.createStatement();
		
		String str = "SELECT DISTINCT HotelID FROM Hotel";
		ResultSet result = stmt.executeQuery(str);

		if(result.next() == false){
			%>
			<script>
				alert("No hotels registered in database.");
				window.location.href = "Analysis.jsp"
			</script>
			<%
		}
		
		ArrayList listTest = new ArrayList();		
		do{
			listTest.add(result.getString(1));		
		}while(result.next());
		
		Iterator it = listTest.iterator();
		while(it.hasNext()){
			String HID = (String)it.next();
			int stdRating = -1, dblRating = -1, delRating = -1, sutRating = -1;
			String stdRoomNo = null, dblRoomNo = null, delRoomNo = null, sutRoomNo = null;
			%><br><%
			
			str = "SELECT DISTINCT Name FROM Hotel WHERE HotelID = '" + HID + "'";
			result = stmt.executeQuery(str);
			result.next();
			String test = result.getString(1);
			out.print("Hotel: " + test);			
			
			//Standard
			str = "SELECT Reserves.HotelID, Reserves.RoomNo, MAX(Reserves.Rating), Room.Type FROM Reserves, Room WHERE Reserves.HotelID = Room.HotelID AND Reserves.RoomNo = Room.RoomNo AND Room.Type = 'standard' AND Reserves.inDate > '" + sDate + "' AND Reserves.outDate < '" + eDate + "' AND Reserves.HotelID = '" + HID + "'";
			result = stmt.executeQuery(str);
			if(result.next()){ stdRating = result.getInt(3); stdRoomNo = result.getString(2); }
			//out.print("Standard Max Rating: " + stdRating);
			//out.print("Standard Room No: " + stdRoomNo);
		
			//Double
			str = "SELECT Reserves.HotelID, Reserves.RoomNo, MAX(Reserves.Rating), Room.Type FROM Reserves, Room WHERE Reserves.HotelID = Room.HotelID AND Reserves.RoomNo = Room.RoomNo AND Room.Type = 'double' AND Reserves.inDate > '" + sDate + "' AND Reserves.outDate < '" + eDate + "' AND Reserves.HotelID = '" + HID + "'";
			result = stmt.executeQuery(str);
			if(result.next()){ dblRating = result.getInt(3); dblRoomNo = result.getString(2); }
			//out.print("Double Max Rating: " + dblRating);
			//out.print("Double Room No: " + dblRoomNo);
						
			//Deluxe
			str = "SELECT Reserves.HotelID, Reserves.RoomNo, MAX(Reserves.Rating), Room.Type FROM Reserves, Room WHERE Reserves.HotelID = Room.HotelID AND Reserves.RoomNo = Room.RoomNo AND Room.Type = 'deluxe' AND Reserves.inDate > '" + sDate + "' AND Reserves.outDate < '" + eDate + "' AND Reserves.HotelID = '" + HID + "'";
			result = stmt.executeQuery(str);
			if(result.next()){ delRating = result.getInt(3); delRoomNo = result.getString(2); }
			//out.print("Deluxe Max Rating: " + delRating);
			//out.print("Deluxe Room No: " + delRoomNo);
			
			//Suite
			str = "SELECT Reserves.HotelID, Reserves.RoomNo, MAX(Reserves.Rating), Room.Type FROM Reserves, Room WHERE Reserves.HotelID = Room.HotelID AND Reserves.RoomNo = Room.RoomNo AND Room.Type = 'suite' AND Reserves.inDate > '" + sDate + "' AND Reserves.outDate < '" + eDate + "' AND Reserves.HotelID = '" + HID + "'";
			result = stmt.executeQuery(str);
			if(result.next()){ sutRating = result.getInt(3); sutRoomNo = result.getString(3); }
			//out.print("Suite Max Rating: " + sutRating);
			//out.print("Suite Room No: " + sutRoomNo);
			
			int max1 = Math.max(stdRating, dblRating);
			int max2 = Math.max(delRating, sutRating);
			int finalmax = Math.max(max1, max2);
			
			if(stdRating <= 0 && dblRating <= 0 && delRating <= 0 && sutRating <= 0){ 
				out.print(" ----- No Rooms with Reviews Available for this Hotel.");
				continue;
			}
			
			int[] arr = new int[4];
			if(finalmax == stdRating){ arr[0] = 1; }
			if(finalmax == dblRating){ arr[1] = 1; }
			if(finalmax == delRating){ arr[2] = 1; }
			if(finalmax == sutRating){ arr[3] = 1; }
			int j = 0;
			for(int i = 0; i < 4; i++){	if(arr[i] == 1){ j++; } }
			if(j > 1){
				out.print(" ----- Highest rated room type within the time period is tied between: ");
				if(arr[0] == 1){ out.print("Standard, ");}
				if(arr[1] == 1){ 
					out.print("Double");
					if(arr[2] == 1 || arr[3] == 1){
						out.print(", ");
					}
				}
				if(arr[2] == 1){ 
					out.print("Deluxe");
					if(arr[3] == 1){
						out.print(", ");
					}
				}
				if(arr[3] == 1){ out.print("Suite"); }
			} else {
				out.print(" ----- Highest rated room type within the time period is: ");
				if(arr[0] == 1){ out.print("Standard"); }
				if(arr[1] == 1){ out.print("Double"); }
				if(arr[2] == 1){ out.print("Deluxe"); }
				if(arr[3] == 1){ out.print("Suite"); }
			}
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