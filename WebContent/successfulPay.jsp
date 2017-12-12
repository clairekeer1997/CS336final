<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Calendar,java.text.SimpleDateFormat,java.util.Date, java.text.DateFormat, java.util.concurrent.TimeUnit,java.lang.Math, java.lang.Integer"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<html>
<body>
<%
		try{
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://jtsr336db.c8venqrmdpbq.us-east-2.rds.amazonaws.com:3306/hoteldb", "JTSR","336HotelJTSR");
			boolean isBad = false;
			boolean isSame = false;
			String sqls = "";
			Statement  t = con.createStatement();
			ResultSet res;
			/*get submit status*/
			String makeAnotherOrder = request.getParameter("makeAnotherOrder");
			String ssfOrder = request.getParameter("successOrder");
			out.print(makeAnotherOrder);
			
			/* automatic generate invoiceNo for each reservation*/
			int invoiceNo = 0;

			if(session.getAttribute("invoiceNo") == null){
			    sqls = "SELECT MAX(r.InvoiceNo) as cnt FROM Reservation r";
				res = t.executeQuery(sqls);
				if(!res.next()){
					invoiceNo = 0;
				}else{
					invoiceNo = res.getInt("cnt") + 1;	
				}
				
				session.setAttribute("invoiceNo", String.valueOf(invoiceNo));
				out.println("invoiceNo: " + invoiceNo);
			}else{
		
				String invoiceStr = session.getAttribute("invoiceNo").toString();
				invoiceNo = Integer.parseInt(invoiceStr);
				isSame = true;
				out.println("invoiceNo: " + invoiceNo);

			}
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
		    int days = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);
		    out.println("days: " + days);
		    
			/*query hotelId*/
			String hotelID = session.getAttribute("h").toString();
			String roomType  = session.getAttribute("r").toString();

			int hotelId = Integer.parseInt(hotelID);
			out.print("HOTELID: " + hotelId);
			out.print("roomType: " + roomType);
			
			/*Using hotelId and roomType to query room price per day*/
			sqls = "SELECT Price FROM Room Where HotelID = '" + hotelId + "'" + " AND Type = " + "'" + roomType + "'";
			res = t.executeQuery(sqls);
			if(!res.next()){
				%>
				<script>
					alert("No such type of room in this Hotel. Please change your roomType selections or change your hotel selection.");
					window.location.href = "mainOrderPage.jsp";
				</script>
				<%
				isBad = true;
			}
			float price = res.getFloat(1);

			/*In case to situation like: For example, room 1 and room 2 are all standard room type. Room 1 is not avaliable during the selected time period. Room 2 is avaliable due to no one ordered room 2 before. But I can not know room 2 is avaliable through the query. there is no room 2 record in reserves table.*/
			sqls = "SELECT DISTINCT RoomNo FROM Room WHERE HotelID ='" + hotelId + "'" + " AND Type = " + "'" + roomType + "' ";
			res = t.executeQuery(sqls);
			ArrayList roomList = new ArrayList();		

			while(res.next()){
				roomList.add(res.getInt(1));	
			}
			
			/*query avaliable room number*/
			int roomNo = -1;
			boolean isAva = true;
			boolean isEmpty = false;
			sqls = "SELECT RoomNo, inDate, outDate FROM Reserves Where RoomNo IN ( SELECT DISTINCT RoomNo FROM Room WHERE HotelID ='" + hotelId + "'" + " AND Type = " + "'" + roomType + "' )";
			out.println(sqls);
			res = t.executeQuery(sqls);
			
			if(!res.next()){
				roomNo  = ((Integer) roomList.get(0)).intValue();
				isEmpty = true;
			}
			
			do{	
					if(isEmpty){
						break;
					}

					int tmpRoomNo = res.getInt(1);

					Date startQuery = format.parse(res.getString(2));
					Date endQuery   = format.parse(res.getString(3));
					
					if(startDate.after(startQuery) &&
					   startDate.before(endQuery)){
						continue;
					}
					if(endDate.after(startQuery) &&
					   endDate.before(endQuery)){
						isAva = false;
						//delete the room already be checked.
						Integer myInt = Integer.valueOf(tmpRoomNo);
						Object myObject = myInt;
						boolean is = roomList.remove(myObject);
						
						continue;
					}
					if(startQuery.after(startDate) &&
					   startQuery.before(endDate)){
						isAva = false;
						//delete the room already be checked.
						Integer myInt = Integer.valueOf(tmpRoomNo);
						Object myObject = myInt;
						boolean is = roomList.remove(myObject);
						continue;
					}
					if(endQuery.after(startDate) &&
					   endQuery.before(endDate)){
						isAva = false;
						
						//delete the room already be checked.
						Integer myInt = Integer.valueOf(tmpRoomNo);
						Object myObject = myInt;
						boolean is = roomList.remove(myObject);
						
						continue;
					}
					if(startQuery.equals(startDate) &&
					   endQuery.equals(endDate)){
						isAva = false;

						//delete the room already be checked.
						Integer myInt = Integer.valueOf(tmpRoomNo);
						Object myObject = myInt;
						boolean is = roomList.remove(myObject);
						
						continue;
					}

				if(isAva == true){
					roomNo = tmpRoomNo;
					out.println("successful order!");
					break;
				}

			}while(res.next() && isAva == false);
			
			if(isAva == false && !roomList.isEmpty()){
				roomNo  = ((Integer) roomList.get(0)).intValue();
			}else if(isAva == false && isEmpty == false && roomList.isEmpty()){//if no room avaliable at that date, return main page
				%>
				<script>
					alert("No such room avaliable during this time period. Please change your roomType selections or change your hotel selection.");
					window.location.href = "mainOrderPage.jsp";
				</script>
				<%
				isBad = true;
			}

			/*query discount information for that room and calculate total price for room*/
			float discount;
			boolean isDis = true;
			float stayPrice = 0;
			Date tmpStartDate = startDate;
			Date tmpEndDate   = endDate;
			sqls = "SELECT SDate, EDate, Discount FROM Discount WHERE HotelID = '" + hotelId + "'" + " AND RoomNo = " + "'" + roomNo + "'";
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
			
			/*calculate total amount*/
			float totalAmt = bre_cost + ser_cost + stayPrice;
			
			if(!isBad){
				String ins = "";
				PreparedStatement pst;
				/*insert reservation table*/
				if(!isSame){
					ins = "INSERT INTO Reservation(InvoiceNo , Username , Cnumber , ResDate , TotalAmt, ExpMonth , ExpYear , Type ,SecCode ,FirstName ,LastName ,BillingAddrStreet ,BillingAddrState ,BillingAddrZip ) "
									+ " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					pst = con.prepareStatement(ins);
					pst.setInt(1, invoiceNo);
					pst.setString(2,"teacher1");
					//test.purpose
					pst.setString(3, cardNum);
					pst.setString(4, date);
					pst.setFloat(5, totalAmt);
					pst.setString(6, expMon);
					pst.setString(7, expYear);
			    	pst.setString(8, cardType);
					pst.setString(9, cvv);
					pst.setString(10, firstName);
					pst.setString(11, lastName);
					pst.setString(12, billStr);
					pst.setString(13, billSta);
					pst.setString(14, billZip);
					pst.executeUpdate();
				}
				/*insert Reserves table*/
				ins = "INSERT INTO Reserves(HotelId, RoomNo, InvoiceNo , inDate, outDate , NoOfDays) "
								+ " VALUES(?, ?, ?, ?, ?, ?)";
				pst = con.prepareStatement(ins);
				pst.setInt(1, hotelId);
				pst.setInt(2, roomNo);
				pst.setInt(3, invoiceNo);
				pst.setString(4, inDate);
				pst.setString(5, outDate);
				pst.setInt(6, days);
				pst.executeUpdate();
			
				/*get the number of BreakfastID*/
				sqls = "SELECT MAX(BreakfastID) as cnt FROM bTypeOrdered";
				res = t.executeQuery(sqls);
				res.next();
				int breakfastId = res.getInt("cnt") + 1;
				
				/*insert bTypeOrdered*/
				sqls = "SELECT bType" + " FROM Breakfast" + " WHERE HotelID = '" + hotelId + "' " + " ORDER BY bType ASC";
				res = t.executeQuery(sqls);
				int j = 0;
				
				while(res.next()){
					String passString = "brePass" + j + "";
					int numBreakfast = Integer.parseInt(session.getAttribute(passString).toString());
					String breakfastType = res.getString(1);
	
					int tmpNum = 0;
					for(;tmpNum < numBreakfast; tmpNum ++){
						
						//insert into bTypeOrdered table
						//breakfastId, hotelId, roomNo, invoiceNo,breakfastType
						String insert = "INSERT INTO bTypeOrdered(BreakfastID, HotelID, RoomNo, InvoiceNo, bType) "
										+ " VALUES(?, ?, ?, ?, ?)";
						
						PreparedStatement ps = con.prepareStatement(insert);
						ps.setInt(1, breakfastId);
						ps.setInt(2, hotelId);
						ps.setInt(3, roomNo);
						ps.setInt(4, invoiceNo);
						//test purpose
						ps.setString(5, breakfastType);
						ps.executeUpdate();
						breakfastId++;
					}
					j++;
				}
				
				/*get the number of ServiceID*/
				sqls = "SELECT MAX(ServiceID) as c FROM sTypeOrdered";
				res = t.executeQuery(sqls);
				res.next();
				int ServiceId = res.getInt("c") + 1;
				
				/*insert bTypeOrdered*/
				sqls = "SELECT sType" + " FROM Service" + " WHERE HotelID = '" + hotelId + "' " + " ORDER BY sType ASC";
				res = t.executeQuery(sqls);
				int i = 0;
				
				while(res.next()){
					String passString = "serPass" + i + "";
					int numService = Integer.parseInt(session.getAttribute(passString).toString());
					String serviceType = res.getString(1);
	
					int tmpNum = 0;
					for(;tmpNum < numService; tmpNum ++){
						
						//insert into bTypeOrdered table
						//ServiceId, hotelId, roomNo, invoiceNo,serviceType
						String insert = "INSERT INTO sTypeOrdered(ServiceId, HotelID, RoomNo, InvoiceNo, sType) "
										+ " VALUES(?, ?, ?, ?, ?)";
						
						PreparedStatement ps = con.prepareStatement(insert);
						ps.setInt(1, ServiceId);
						ps.setInt(2, hotelId);
						ps.setInt(3, roomNo);
						ps.setInt(4, invoiceNo);
						//test purpose
						ps.setString(5, serviceType);
						ps.executeUpdate();
						ServiceId++;
					}
					i++;
				}
				
				if(makeAnotherOrder != null){
					%>
					<script>
						alert("You are going to make another order with the same invoice number. Current order has been already submitted.");
						window.location.href = "mainOrderPage.jsp";
					</script>
					<%
				}
				
				else if(ssfOrder != null){
					%>
					<script>
						alert("Congratulations! You place the order successfully!");
						window.location.href = "Userpage.jsp";
					</script>
					<%
				}
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}

			

%>

</body>
<style>
body {
    background-image: url("file:///Users/claireyou/git/CS336final/WebContent/WEB-INF/pic3.png");
    background-size:100% 100%;
}
</style>
</html>