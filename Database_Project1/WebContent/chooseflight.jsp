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
<%@ page import = "java.util.Calendar" %>


<% 
if(session.getAttribute("email")==null)
	response.sendRedirect("login.jsp");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/database_project","root","root");
Statement st=con.createStatement();

String start= request.getParameter("start");
String destination= request.getParameter("destination");
String date= request.getParameter("date");
//convert to date
String clas= request.getParameter("class");
String seats= request.getParameter("seats");
int seat=Integer.parseInt(seats);
//Date book_date= new Date();
 

//SimpleDateFormat sdf=new SimpleDateFormat("MM-dd-yyyy");
Date sdf=new SimpleDateFormat("MM/dd/yyyy").parse(request.getParameter("date"));
//Date d4=sdf.parse(date);
//java.util.Date d=format.Parse(date);
//String date="2000-11-10";
//java.sql.Date d3=sdf.format(date);
out.println(date);
//current date and time
Calendar c=Calendar.getInstance();
java.util.Date cd=c.getTime();
java.sql.Date d2= new java.sql.Date(cd.getTime());

java.sql.Date d3= new java.sql.Date(sdf.getTime());
out.println(d2);
out.println(d3);

 //Date start_date=sdf.parse(date); //sdf

/* Date book_date=new java.util.Date();
 String b=date.toString(); //java.util date
 Date book_d=sdf.parse(b);  //sdf
//write and execute query and display*/

//java.sql.Date localDate=sqlDate.toLocalDate();

//java.sql.Date sd=new java.sql.Date(start_date.getDate());
//java.sql.Date bd=new java.sql.Date(book_date.getDate());

String query="{ call database_project.call list_of_flights(?,?,?,?,?,?,?)}";
CallableStatement stmt = con.prepareCall(query);
	
	try{
		stmt.setDate("flight_date",d3);
	stmt.setDate("book_date",d2);
	stmt.setString("preffered_class",clas);
	stmt.setInt("passengers",seat);
	stmt.setString("start_port",start);
	stmt.setString("end_port",destination);
	//try{
	stmt.setInt("offset",1);}catch(Exception e){}
	
	//catch(NullPointerException npe)
	//{}	
	//try{
	ResultSet rs=stmt.executeQuery();
	
	int i=1;
	while(rs.next()){
		stmt.setInt("offset",i);
		rs=stmt.executeQuery();
		i+=1;%>
		<form action="bookflight.jsp" method="post">
<% out.println(rs.getString(1)+rs.getString(2)+rs.getString(3)+rs.getString(4)+rs.getString(5)+rs.getString(6)+rs.getString(7)+rs.getString(8)+rs.getString(9)+rs.getString(10)+rs.getString(11)+rs.getString(12));%>
	<select name="flight">
		
		 <option value="<%=rs.getString(4)%>"><%=rs.getString(4)%></option> </select><br>
		 <select name="flight2">
		
		 <option value="<%=rs.getString(9)%>"><%=rs.getString(9)%></option> </select>
	set these as session attributes<br>
	choose meal option
<select name="mealx">
		
		 <option value="chicken">chicken</option>
		 <option value="fish">chicken</option>
		 <option value="vegan">chicken</option></select>
	<br>
	<input id="Submit" name="book" method="post" type="submit" action="bookflight.jsp" value="Submit" />

</form>
		<%}
	

	
	out.println("hello");
	%>




	 

</body>
</html>