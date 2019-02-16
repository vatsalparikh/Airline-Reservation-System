<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<h2 align="center"><font><strong>Reservation list by flight number</strong></font></h2>

<table>
<tr>
<td><b></b></td>
<td>Flight No.</td>
<td>&nbsp;&nbsp;&nbsp; Reservation No.</td>
<td>Reservation Date</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Total Fare</td>
<td>&nbsp;&nbsp;&nbsp; Booking Fee</td>
</tr>
<table>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();

String flno = request.getParameter("flight_number");
ResultSet rs = st.executeQuery("select t.travels_flight_number flight_number, r.reservation_number reservation_number, r.reservation_date reservation_date, " + 
		"r.total_fare total_fare, r.booking_fee booking_fee" + 
		" from reservations r, travels t " + 
		" where t.travels_reservation_number = r.reservation_number" +
		" and t.travels_flight_number = '" +flno+ "';");
while (rs.next()){
	out.println(rs.getString(1)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(2)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(3)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(4)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(5)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	%><br>
	<%
}
%>
</body>
</html>