<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>select</title>
</head>
<body> <center>
 <font size = 6>Your choice for Breakfast and Service </font></center>
 <br>
 <%
	  int cid = 0;
	  try{
		   Class.forName("com.mysql.jdbc.Driver");
		   Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
		   
		   String  hotelID = "1";
		   
		    Statement t = con.createStatement();
		    String sqlbreakfast  = "SELECT Btype.bType\n" + "FROM Breakfast Btype\n" + "WHERE Btype.HotelID = \"" + hotelID + "\"";
			
          ResultSet resBreakfast = t.executeQuery(sqlbreakfast);
         
        	 // ResultSet resservice  =  t.executeQuery(sqlservice);
		    %>
		  	<form method="post" action="paymentinfo.jsp">
		   <center>
		      <h1> select breakfast type</h1>
		          
		       
		          <%  while(resBreakfast.next()){ %>
		            <br> 
		             Breakfast Type: <%= resBreakfast.getString(1)%><input type="number" min="0"name="resbreakfast" >
		           
		             <br>
		          <% } %>
		           
           </center>
  
     <%     String sqlservice = "SELECT Stype.sType\n" + "FROM Service Stype\n" + "WHERE Stype.HotelID = \"" + hotelID + "\"";
	        ResultSet resservice  =  t.executeQuery(sqlservice);
	  %>
	  
	  <center>
		      <h1> select service type</h1>
		          
		        
		          <%  while(resservice.next()){ %>
		            <br> 
		             service Type: <%= resservice.getString(1)%><input type="number" min="0"  name="resservice" >
		           
		             <br>
		          <% } %>
		           
           </center>
		
	
<%     }
		  catch(Exception e){
		   e.printStackTrace();
	  }
 %>
 <br>
  <br><center>
 <input type="submit" value="submit">
 </center>
 
  </form>
 </body>
 </html>