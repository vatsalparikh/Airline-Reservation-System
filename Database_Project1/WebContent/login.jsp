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
String email=request.getParameter("email");
session.putValue("email",email);
String pass=request.getParameter("password");

Class.forName("com.mysql.jdbc.Driver");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();
ResultSet rs = st.executeQuery("select * from Customers where email='"+email+"'");
if(rs.next()){
	if(rs.getString(9).equals(pass))
	{
		out.println("welcome");
		response.sendRedirect("reservations.html");
		//how to transfer to another page?
		}
	else
	{
		out.println("login failed");
		}
} else 
%>
</body>
</html>