<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Calendar,java.text.SimpleDateFormat,java.util.Date, java.text.DateFormat, java.util.concurrent.TimeUnit"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 5 Transitional//EN" "http://www.w3.org/TR/html5/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> payment - JTSR Hotel Order System</title>
</head>

<body>
<%
	String hotelName = request.getParameter("hotelSelection");
	session.setAttribute("h", hotelName);
	String roomType = request.getParameter("roomType");
	session.setAttribute("r", roomType);
	String sDate = request.getParameter("startDate");
	session.setAttribute("startDate", sDate);
	String eDate = request.getParameter("endDate");
	session.setAttribute("e", eDate);
%>
<font size = 6>Welcome to JTSR Hotels </font>
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
			<tr><td> <input type = "submit" id = "successOrder" value = "Check Out"></td></tr>
					
		</table>
	
	
	</center>
	</form>

<%
	//insert data in mainOrderPage into database first
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
		
		/* automatic generate invoiceNo for each reservation*/
		Statement stmt = con.createStatement();	
		String str = "SELECT MAX(r.InvoiceNo) as cnt FROM Reservation r";
		ResultSet result = stmt.executeQuery(str);
		result.next();
		int invoiceNo = result.getInt("cnt") + 1;
		out.println("invoiceNo: " + invoiceNo);
		
		/*temple dynamic username*/
		//String userName = session.getAttribute("user_name").toString();
		//out.println("userName: " + userName);
		
		/*get Card Number*/
		String cardNum = request.getParameter("cardNum");
		out.println("cardNum: " + cardNum);
		
		/*get reservation date*/
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
		String date = today.format(calendar.getTime());
		out.println("date: " + date);
		
		/*get expect expMon and expYear*/
		String expMon  = request.getParameter("expMon");
		String expYear = request.getParameter("expYear");
		out.println("expMon: " + expMon + "expYear: " + expYear);

		
		/*get card type*/
		String cardType = request.getParameter("cardType");
		out.println(cardType);
		
		/*get security code(cvv)*/
		String cvv = request.getParameter("cvv");
		out.println("cvv: " + cvv);
		
		/*get first name and Last name*/
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		out.println("First Name: " + firstName + "Last Name: " + lastName);
		
		/*get billing address street, state, zip*/
		String billStr = request.getParameter("billStr");
		String billSta = request.getParameter("billSta");
		String billZip = request.getParameter("billZip");
		out.println("billStr: " + billStr + "billSta: " + billSta + "billZip" + billZip);
		
		/*get total amount*/
		String inDate = request.getParameter("startDate");
		String outDate = request.getParameter("endDate");
		out.print("startDate: " + inDate + "endDate: " + outDate);
		
		/*convert string to date and calculate the number of day that customer will stay*/
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
		Date startDate = format.parse(inDate);
		Date endDate = format.parse(outDate);
		long diff = endDate.getTime() - startDate.getTime();
	    long days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
	    out.println("days: " + days);
	    
	}catch (Exception e){
		e.printStackTrace();
	}
%>

</body>
</html>