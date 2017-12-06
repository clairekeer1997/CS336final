<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Calendar,java.text.SimpleDateFormat,java.util.Date, java.text.DateFormat, java.util.concurrent.TimeUnit,java.lang.Math"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>
<body>
<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			
			/* automatic generate invoiceNo for each reservation*/
			Statement t = con.createStatement();	
			String sqls = "SELECT MAX(r.InvoiceNo) as cnt FROM Reservation r";
			ResultSet res = t.executeQuery(sqls);
			res.next();
			int invoiceNo = res.getInt("cnt") + 1;
			out.println("invoiceNo: " + invoiceNo);
			
			/*temple dynamic username*/
			//String userName = session.getAttribute("user_name").toString();
			//out.println("userName: " + userName);
			
			/*get Card Number*/
			String cardNum = request.getParameter("cardNum");
			out.println("cardNum: " + cardNum);
			
			/*generate reservation date*/
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
			
			/*get check in date and check out date*/
			String inDate = session.getAttribute("startDate").toString();
			String outDate = session.getAttribute("e").toString();
			out.print("startDate: " + inDate + "endDate: " + outDate);
			
			/*convert string to date and calculate the number of day that customer will stay*/
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
			Date startDate = format.parse(inDate);
			Date endDate = format.parse(outDate);
			long diff = endDate.getTime() - startDate.getTime();
		    long days = TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		    out.println("days: " + days);
		    
			/*query hotelId*/
			String hotelID = session.getAttribute("h").toString();
			String roomType  = session.getAttribute("r").toString();

			int hotelId = Integer.parseInt(hotelID);
			out.print("HOTELID: " + hotelId);
			
			/*Using hotelId and roomType to query room price per day*/
			sqls = "SELECT Price FROM Room Where HotelID = '" + hotelId + "'" + " AND Type = " + "'" + roomType + "'";
			res = t.executeQuery(sqls);
			res.next();
			float price = res.getFloat(1);

			/*query avaliable room number*/
			sqls = "SELECT RoomNo, inDate, outDate FROM Reserves Where RoomNo IN ( SELECT DISTINCT RoomNo FROM Room WHERE HotelID ='" + hotelId + "'" + " AND Type = " + "'" + roomType + "' )";
			out.println(sqls);
			res = t.executeQuery(sqls);
			if(!res.next()){
				%>
				<script>
					alert("No such type for this Hotel. Please change your roomType selections or change your hotel selection.");
					window.location.href = "mainOrderPage.jsp"
				</script>
				<%
			}
			
			int roomNo = -1;
			boolean isAva = true;
			do{
				int tmpRoomNo = res.getInt(1);
				
					Date startQuery = format.parse(res.getString(2));
					Date endQuery   = format.parse(res.getString(3));
					
					if(startDate.after(startQuery) &&
					   startDate.before(endQuery)){
						isAva = false;
						continue;
					}
					if(endDate.after(startQuery) &&
					   endDate.before(endQuery)){
						isAva = false;
						continue;
					}
					if(startQuery.after(startDate) &&
					   startQuery.before(endDate)){
						isAva = false;
						continue;
					}
					if(endQuery.after(startDate) &&
					   endQuery.before(endDate)){
						isAva = false;
						continue;
					}

				if(isAva == true){
					roomNo = tmpRoomNo;
					out.println("successful order!");
					break;
				}

			}while(res.next() && isAva == false);

			if(isAva == false){//if no room avaliable at that date, return main page
				%>
				<script>
					alert("No room available for this type of room. Please change your roomType selections or change your hotel selection.");
					window.location.href = "mainOrderPage.jsp"
				</script>
				<%
			}
			
			/*query discount information for that room and calculate total price for room*/
			float discount;
			boolean isDis = true;
			float stayPrice = 0;
			Date tmpStartDate = startDate;
			Date tmpEndDate   = endDate;
			sqls = "SELECT SDate, EDate, Discount FROM Discount WHERE HotelID = '" + hotelId + "'" + " AND RoomNo = " + "'" + roomNo + "'";
			out.print(sqls);
			res = t.executeQuery(sqls);
			if(!res.next()){
				discount = 0;
				isDis = false;
			}
			
			long fullPriceStay = days;//to calculate how many days without discount
			
			do{
				if(isDis == false){
					break;
				}
					Date discountStart = format.parse(res.getString(1));
					Date discountEnd   = format.parse(res.getString(2));
					discount = res.getFloat(3);
					
					if(tmpStartDate.after(discountStart) &&
					   tmpEndDate.before(discountEnd)){
						stayPrice += days * price * (1 - discount);
						fullPriceStay = 0;
						break;//since all days get discount
					}
					if(tmpStartDate.after(discountStart) &&
					   tmpStartDate.before(discountEnd)){
						/*discount 1 - 5 and stay 3 - 7*/
						long difference = discountEnd.getTime() - tmpStartDate.getTime();
					    long stays = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
					    stayPrice += stays * price * (1 - discount);
					    fullPriceStay -= stays;
					    continue;
					}
					
					if(tmpEndDate.after(discountStart) &&
					   tmpEndDate.before(discountEnd)){
						/*discount 5 - 10 and stay 3 - 7*/
						long difference = tmpEndDate.getTime() - discountStart.getTime();
					    long stays = TimeUnit.DAYS.convert(difference, TimeUnit.MILLISECONDS);
					    stayPrice += stays * price * (1 - discount);
					    fullPriceStay -= stays;
						continue;
					}

					if(fullPriceStay == 0){
						break;
					}
			}while(res.next());
		
			if(fullPriceStay != 0){
				stayPrice += price * fullPriceStay;
			}
			
			stayPrice = (float)Math.round(stayPrice * 100f) / 100f;
			out.print(stayPrice);

			/*get breakfast price and service price*/
			float bre_cost = (Float) session.getAttribute("bre_cost");
			float ser_cost = (Float) session.getAttribute("ser_cost");
			
			/*calculate full price*/
			float fullPrice = bre_cost + ser_cost + stayPrice;
			
			
		}catch(Exception e){
			e.printStackTrace();
		}

			

%>
</body>
</html>