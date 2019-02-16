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
<%@ page import="java.lang.*"%>
<%
if(session.getAttribute("email")==null){
	response.sendRedirect("skies_login.html");
}
String email = (String) session.getAttribute("email");
%>

<h2 align="center"><font><strong>Travel Itinerary</strong></font></h2>

<table>
<tr>
<td><b></b></td>
<td>Flight No.</td>
<td>&nbsp;&nbsp;&nbsp; Airline ID</td>
<td>&nbsp;&nbsp; Departure Time</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reservation No.</td>
<td>Seat Number</td>
<td>First Name</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp; Last Name</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Special Meal</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class</td>
</tr>
<table>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();

String rno = request.getParameter("res_no");

ResultSet rs = st.executeQuery("select t.* " + 
		" from reservations r, travels t, customers c " + 
		" where t.travels_reservation_number = r.reservation_number and r.reservations_account_number = c.account_number " +
		" and r.reservation_number = '" +rno+ "' and t.travels_departure_time >= now() " +
		" and c.account_number IN (select c1.account_number from customers c1 where c1.email = '" +email+ "');");

while (rs.next()){
	out.println(rs.getString(1)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(2)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(3)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(4)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(5)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(6)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(7)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(8)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(9)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	%><br>
	<%
}
%>

</body>
</html>