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



<%
if(session.getAttribute("email")==null)
	response.sendRedirect("login.html");

String city= request.getParameter("");
Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");

Statement st=con.createStatement();
ResultSet rs = st.executeQuery("select * from airports");


%>
<form name=frm  method="post" action="chooseflight.jsp">
<table> book flights
<tr>
<tr><td><b>start:</b></td>

<select name="city">
<% while(rs.next()){%>
  <option value="<%=rs.getString(3)%>"><%=rs.getString(3)%></option>
   <%}%>
 </select></tr><br>
 <tr><tr>date<input type="date" name="date"></tr><br>
<%ResultSet rs1 = st.executeQuery("select * from airports"); %>
<tr><td><b>destination :</b></td></table>
<select name="city1">
<% while(rs1.next()){%>

  <option value="<%=rs1.getString(3)%>"><%=rs1.getString(3)%></option> <%}%></select></tr>
  <tr><br>

  
 <select name="class">
<option value="economy">economy</option>
<option value="business">business</option>
<option value="first">first</option></select>
<input id="Submit" name="book" method="post" type="submit" action="chooseflight.jsp" value="Submit" /></option></tr>
no of seats: <input type="text" name="seats"></form>

--------------------------------------------------
<br><br>
view current bookings
<br><form name=frm  method="post" action="">
<input id="Submit" name="view" method="post" type="submit" action="" value="Submit" />
<br><br></form>
view reservations history
<br><form name=frm  method="post" action="">
<input id="Submit" name="history" method="post" type="submit" action="" value="Submit" />
<br>
</form>



</body>
</html>