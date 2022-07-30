<%@ page import= "java.sql.*" %>
<%@ page import="java.io.*" %> 
<%
String db = "weed";
String user = "Yang";
try { 
	Class.forName("com.mysql.cj.jdbc.Driver");
	java.sql.Connection con; 
	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "mrbigbear18!"); 
	out.println(db + " database successfully opened. <br>"); 
	Statement stmt=con.createStatement();
	
	String username = request.getParameter("name");
	out.println(username + " hello");
	//String password = request.getParamter("password");
	//String email = request.getParamter("email");
	
	ResultSet rs=stmt.executeQuery("select * from weed.users");
   
	con.close(); 
} catch(SQLException e) { 
	out.println("SQLException caught: " +e.getMessage()); } 
%>