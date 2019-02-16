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
<%@ page import ="java.sql.CallableStatement" %>
<%@page import ="java.text.SimpleDateFormat"%>

<%@ page import = "java.util.Date"%>

<%

if(session.getAttribute("email")==null)
	response.sendRedirect("login.jsp");

String email=(String)session.getAttribute("email");
String flight= request.getParameter("flight");
String flight2= request.getParameter("flight2");
String meal=request.getParameter("meal");

%>

<%
/*String seats=request.parameter("seat");
int s=Integer.parseInt(seats);
String clas=request.parameter("clas");*/
Class.forName("com.mysql.jdbc.Driver");

Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
//get seats as int first? then

Statement st=con.createStatement();

ResultSet rs=st.executeQuery("select * from Customers where email="+email+"");
try{
String fname=rs.getString(2);
String lname=rs.getString(1);
}catch(Exception e){}

// ask for name 
//make up some field randomly

ResultSet rs1=st.executeQuery("select * from Legs where legs_flight_number="+flight+"");
//out.println(rs1.getString(1));

	
ResultSet rs2=st.executeQuery("select * from Flights where flight_number="+flight+"");
ResultSet rs3;
if(flight2!=null){
	rs3=st.executeQuery("select * from Flights where flight_numbe=r"+flight2+"");
}
ResultSet rs4;
if(flight2!=null){
	rs4=st.executeQuery("select * from Flights where flight_number="+flight2+"");
}



out.println("booking successful");
%>

</body>
</html>