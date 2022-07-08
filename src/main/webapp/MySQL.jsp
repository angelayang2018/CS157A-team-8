<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "java.sql.*" %>
<%@ page import="java.io.*" %> 

<html> 
<head> 
<title>Love and Peace, Get Some Weed</title> 
<link rel = "stylesheet" href = "css/style.css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<script src = "js/myscripts.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">></script>
</head>
<body> 
<div class="toggle">
        <a><i class="fa fa-bars"></i></a>
    </div>
    <div class="menu">
        <ul>
            <li><a href="#">Love and Peace, Get Some Weed</a></li>
            <li><a href="#">About</a></li>
            <li><a href="CreateProduct.jsp">Products</a></li>
            <li><a href="#">Contact Us</a></li>
            <li><a href="login.jsp">Sign Up</a></li>
            
        </ul>
    </div> 
    <h1> Love and Peace, Get Some Weed <3</h1>
</body> 
<script src = "js/myscripts.js"></script>
</html> 

<%
/*
	String db = "Yang";
	String user = "Yang";
	try { 
		Class.forName("com.mysql.cj.jdbc.Driver");
		java.sql.Connection con; 
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "mrbigbear18!"); 
		out.println(db + " database successfully opened. <br>"); 
		Statement stmt=con.createStatement();
		ResultSet rs=stmt.executeQuery("select * from Yang.student");
		out.println("hello"           );
		while(rs.next())
			out.println("<br>" + rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3));
		con.close(); 
	} catch(SQLException e) { 
		out.println("SQLException caught: " +e.getMessage()); } 
	*/%>
