<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> payment - JTSR Hotel Order System</title>
</head>

<body>
<font size = 6>Welcome to JTSR Hotels </font>
<br>
	<form method = "post" action = "paymentInfo.jsp">
	<center>
	<h1>Fill Your Payment</h1>
	
		<table>
			<tr><td>First Name: <input type = "text" maxlength = "20" size = "20"> Last Name: <input type = "text" maxlength = "20" size = "20"></td></tr>
			<tr><td>Card Number: 
					     <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "16" size = "16"> (No Blank)
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
					     <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "2" size = "2"> 
						 / 
						 <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "2" size = "2">
					     cvv:
					     <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "3" size = "3">
					</td>
			</tr>
			
			<tr><td>BillingAddrStreet: <input type = "text" maxlength = "30" size = "30"></td></tr>
			<tr><td>BillingAddrState: <input type = "text" maxlength = "30" size = "30"></td></tr>
			<tr><td>BillingAddrZip: <input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' maxlength = "30" size = "30"></td></tr>
			<tr><td> <input type = "submit" id = "successOrder" value = "Check Out"></td></tr>
					
		</table>
	
	
	</center>
	</form>
</body>
</html>