<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Calendar,java.text.SimpleDateFormat,java.sql.Date, java.text.DateFormat, java.util.concurrent.TimeUnit"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> payment - Hulton Hotel Order System</title>
</head>

<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
	Statement t = con.createStatement();
	
	int i = 0;//number of type of serivice
	int j = 0;//number of type of breakfast
	float bre_cost = 0;
	float ser_cost = 0;
	String hotelId = session.getAttribute("h").toString();
	
	String sqlbreakfast  = "SELECT bType, bPrice" + " FROM Breakfast" + " WHERE HotelID = '" + hotelId + "' " + " ORDER BY bType ASC";	
	ResultSet resBreakfast = t.executeQuery(sqlbreakfast);
	
	/*calculate breakfast price*/
	while(resBreakfast.next()){
		String textName = "num" + j + "";
		String brePass = "brePass" + j + "";
		int numBreakfast = 0;
		if(request.getParameter(textName) != ""){
			numBreakfast = Integer.parseInt (request.getParameter(textName));
		}
		float price = resBreakfast.getFloat(2);
		bre_cost += price * numBreakfast;
		
		//pass number of Breakfast to successful Page
		session.setAttribute( brePass , numBreakfast);
		
		j++;
	}

	/*calculate service price*/
	String sqlservice = "SELECT sType, sCost " + " FROM Service" + " WHERE HotelID = '" + hotelId + "' " + " ORDER BY sType ASC";
	ResultSet resservice  =  t.executeQuery(sqlservice);
	
	while(resservice.next()){
		String textName = "number" + i + "";
		String serPass = "serPass" + i + "";
		
		int numReserve = 0;
		
		if(request.getParameter(textName) != ""){
			numReserve = Integer.parseInt (request.getParameter(textName));
			
		}
		
		float price = resservice.getFloat(2);
		ser_cost += price * numReserve;
		
		session.setAttribute( serPass , numReserve);
		i++;
	}
	
	session.setAttribute("bre_cost", bre_cost);
	session.setAttribute("ser_cost", ser_cost);
%>
<font size = 6>Welcome to Hulton Hotels </font>
<br>	
	<form method = "post" action = "successfulPay.jsp">
	<center>
	<h1>Fill Your Payment</h1>
	
		<table>
			<tr><td>First Name: <input type = "text" maxlength = "20" size = "20" name = "firstName"> Last Name: <input type = "text" maxlength = "20" size = "20" name = "lastName"></td></tr>
			<tr><td>Card Number: 
					     <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "16" size = "16" name = "cardNum"> (No Blank)
			</td></tr>
			<tr><td>
						 Card Type:
						 <select name = "cardType">
						 <option value = "masterCard"> masterCard </option>
						 <option value = "Visa"> Visa </option>
						 <option value = "American Express"> American Express </option>
						 <option value = "UnionPay"> UnionPay </option>

						 </select>
					</td>
			</tr>
			
			<tr><td>Exp date:
					     <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "2" size = "2" name = "expMon"> 
						 / 
						 <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "2" size = "2" name = "expYear">
					     cvv:
					     <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "3" size = "3" name = "cvv">
					</td>
			</tr>
			
			<tr><td>BillingAddrStreet: <input type = "text" maxlength = "30" size = "30" name = "billStr"></td></tr>
			<tr><td>BillingAddrState: <input type = "text" maxlength = "30" size = "30" name = "billSta"></td></tr>
			<tr><td>BillingAddrZip: <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "30" size = "30" name = "billZip"></td></tr>
			<tr><td> <input type = "submit" name = "successOrder" value = "Check Out"></td></tr>
			<tr><td> <input type = "submit" name = "makeAnotherOrder" value = "Check Out with the same Invoice number"></td></tr>
		</table>
	
	
	</center>
	</form>
<a href="LoginRegistration.jsp">Logout</a>
</body>
<style>
body {
    background-image: url("file:///Users/claireyou/git/CS336final/WebContent/WEB-INF/pic3.png");
    background-size:100% 190%;
}
</style>

</html>