<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	try {
		//Get parameters from the HTML form at the LoginRegistration.jsp
		String username = request.getParameter("Username");
		String password = request.getParameter("Password");
		
		if(username.equals("") || password.equals("")){
			%>
			<script>
				alert("The Username and Password fields are mandatory.");
				window.location.href = "LoginRegistration.jsp"
			</script>
			<%
		}
		
		//Create a connection string
		String url = "jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
				
		//Create a connection to your DB
		Connection con = DriverManager.getConnection(url, "JTSR", "336HotelJTSR");

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Search the Customer DB
		String str = "SELECT * FROM Customer WHERE Username = '" + username + "'";
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(str);

		if(result.next() == false){
			%>
			<script>
				alert("Username and Password combination does not exist. Both are case sensitive.");
				window.location.href = "LoginRegistration.jsp"
			</script>
			<%			
		}
		
		String db_pass = result.getString("Password");
		
		if(db_pass.equals(password)){
			session.setAttribute("user_name", username);
			%>
			<script>
				alert("Successfully logged in.");
				//window.location.href = "test.jsp"
			</script>
			<%
		} else {
			%>
			<script>
				alert("Username and Password combination does not exist. Both are case sensitive.");
				window.location.href = "LoginRegistration.jsp"
			</script>
			<%
		}

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	} catch (Exception ex) {
		out.print("Oops! Something broke. Please hit the hyperlink below and try again.");
	}
	%>
	</br>
	<a href="LoginRegistration.jsp">Back to Login/Registration Page</a>
</body>
</html>