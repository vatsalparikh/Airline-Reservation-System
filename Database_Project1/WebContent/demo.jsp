<%
String fname = request.getParameter("fname");
String lname= request.getParameter("lname");
String driverName = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String dbName = "database_project";
String userId = "root";
String password = "root";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>
<h2 align="center"><font><strong>Reservation list by customer name</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
<tr>
<td><b>First Name</b></td>
<td><b>Last Name</b></td>
<td><b>Reservation Number</b></td>
<td><b>Booking Fee</b></td>
<td><b>Total Fare</b></td>
</tr>
<%
try{ 
connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
statement=connection.createStatement();
String sql ="select c.first_name, c.last_name, r.reservation_number, r.booking_fee, r.total_fare " + 
		" from reservations r, customers c " + 
		" where r.reservations_account_number = c.account_number " +
		" and c.first_name = '" +fname+ "' and c.last_name = '" +lname+ "';";

resultSet = statement.executeQuery(sql);
while(resultSet.next()){
%>


<td><%=resultSet.getString(1) %></td>
<td><%=resultSet.getString(2) %></td>
<td><%=resultSet.getString(3) %></td>
<td><%=resultSet.getString(4) %></td>
<td><%=resultSet.getString(5) %></td>

</tr>

<% 
}

} catch (Exception e) {
e.printStackTrace();
}
%>
</table>