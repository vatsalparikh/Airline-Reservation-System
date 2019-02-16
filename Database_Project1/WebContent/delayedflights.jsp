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

<h2 align="center"><font><strong>Flight list by airport</strong></font></h2>

<table>
<tr>
<td><b></b></td>
<td>Flight No.</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp;Airline ID</td>
<td>&nbsp;&nbsp;Firstclass</td>
<td>&nbsp;&nbsp;Economy</td>
<td>&nbsp;&nbsp;&nbsp;Business</td>
<td>&nbsp;&nbsp;Advance Book</td>
<td>Discount</td>
</tr>
<table>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();

ResultSet rs = st.executeQuery("select * from flights f " +
		" where exists (select * from legs l " + 
						" where f.flight_number = l.legs_flight_number " +
						" AND (l.actual_arrival > l.arrival_time OR l.actual_departure > l.departure_time));");
while (rs.next()){
	out.println(rs.getString(1)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(2)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(3)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(4)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(5)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(6)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(7)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	%><br>
	<%
}
%>
</body>
</html>