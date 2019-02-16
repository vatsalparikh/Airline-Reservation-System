<%@page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Register</title>
</head>
<body>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%
//write same as name field of form
String lname = request.getParameter("lname");
String fname = request.getParameter("fname");
String add = request.getParameter("add");
String country = request.getParameter("country");
String city = request.getParameter("city");
String state = request.getParameter("state");
String zip = request.getParameter("zip");
String phone = request.getParameter("phn");
String email = request.getParameter("ema");
String card = request.getParameter("CCnum");
String user = request.getParameter("acc");
String pass = request.getParameter("pass");
int acc = Integer.parseInt(user);
Class.forName("com.mysql.jdbc.Driver");
//java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://ec2-13-59-174-252.us-east-2.compute.amazonaws.com");
Statement st=con.createStatement();
ResultSet rs;
//values must be in same order as table columns
int i= st.executeUpdate("insert into Customers values('" +lname+ "', '" +fname+ "', '" +add+ "', '" +city+ "', '" +state+ "', '" +zip+ "', '" +phone+ "', '" +email+ "', '" +pass+ "', '" +card+ "','" +acc+"', '" +country+ "')");
out.println("registration successfull");
%>
</body>
</html>