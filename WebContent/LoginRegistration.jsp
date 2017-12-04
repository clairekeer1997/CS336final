<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hulton Hotel Login/Registration</title>
</head>
<body>
<center>
Welcome to Hulton Hotels<br><br>
For New Users, Please Register Here:
</center>
<br>
	<form method="post" action="newUserRegistration.jsp">
	<center>
	<table>
	<tr><td>Username:</td><td><input type="text" name="Username"></td></tr>
	<tr><td>Password:</td><td><input type="password" name="Password"></td></tr>
	<tr><td>First Name:</td><td><input type="text" name="FirstName"></td></tr>	
	<tr><td>Last Name:</td><td><input type="text" name="LastName"></td></tr>
	<tr><td>Email:</td><td><input type="text" name="Email"></td></tr>
	<tr><td>Street:</td><td><input type="text" name="AddrStreet"></td></tr>
	<tr><td>City:</td><td><input type="text" name="AddrCity"></td></tr>	
	<tr><td>State/Province:</td><td><input type="text" name="AddrState"></td></tr>	
	<tr><td>Country:</td><td><input type="text" name="AddrCountry"></td></tr>		
	<tr><td>Zip:</td><td><input type="text" name="AddrZip"></td></tr>	
	<tr><td>Phone:</td><td><input type="text" name="Phone_No"></td></tr>	
	</table>
	<br>
	<input type="submit" value="Submit New User Registration">
	</center>
	</form>
<br>
* Please note that all fields are required. <br>
* Passwords must be of a length greater than 3 characters. <br>
* Phone numbers must be input with numbers only and no spaces and must have a minimum length of 8 and a max of 15<br><br>


<br>
<center>
For Returning Users, Please Login Here:
<br>
	<form method="post" action="login.jsp">
	<table>
	<tr><td>Username:</td><td><input type="text" name="Username"></td></tr>
	<tr><td>Password:</td><td><input type="password" name="Password"></td></tr>
	</table>
	<br>
	<input type="submit" value="Log In For Pre-Existing Users">
	</form>
</center>
<br>
</body>
</html>