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

<h2 align="center"><font><strong>Summary of revenue by city</strong></font></h2>
<table>
<tr>
<td><b></b></td>
<td>City</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Revenue</td>
</tr>
<table>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();

String city = request.getParameter("city_name");
ResultSet rs = st.executeQuery("select a.city, SUM(r.total_fare) " +
		" FROM airports a, legs l, travels t, reservations r" + 
		" where a.airport_id = l.arriving_airport_id and l.legs_flight_number = t.travels_flight_number and t.travels_reservation_number = r.reservation_number " +
		" and a.city ='" +city+ "' " +
		" GROUP BY a.city;");

while (rs.next()){
	out.println(rs.getString(1)+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(2)+"&nbsp;"+"&nbsp;"+"|");
	%><br>
	<%
}
%>
</body>
</html>