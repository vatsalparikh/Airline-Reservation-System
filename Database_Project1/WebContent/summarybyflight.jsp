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

<h2 align="center"><font><strong>Summary of revenue by flight</strong></font></h2>
<table>
<tr>
<td><b></b></td>
<td>Flight No.</td>
<td>&nbsp;&nbsp;&nbsp;&nbsp; Revenue</td>
</tr>
<table>

<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();

String fnr = request.getParameter("flight_nr");
ResultSet rs = st.executeQuery("select t.travels_flight_number, SUM(r.total_fare) " +
		" FROM travels t, reservations r " + 
		" where t.travels_reservation_number = r.reservation_number " +
		" and t.travels_flight_number = '" +fnr+ "' " +
		" GROUP BY t.travels_flight_number;");

while (rs.next()){
	out.println(rs.getString(1)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	out.println(rs.getString(2)+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"&nbsp;"+"|");
	%><br>
	<%
}
%>
</body>
</html>