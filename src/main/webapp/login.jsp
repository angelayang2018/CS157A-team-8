<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import= "java.sql.*" %>
<%@ page import="java.io.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Love and Peace, Get Some Weed</title> 
<link rel = "stylesheet" href = "css/style.css">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">></script>
</head>
<body> 
<div class="toggle">
        <a><i class="fa fa-bars"></i></a>
    </div>
    <div class="menu">
        <ul>
            <li><a href="MySQL.jsp">Love and Peace, Get Some Weed</a></li>
            <li><a href="#">About</a></li>
            <li><a href="CreateProduct.jsp">Products</a></li>
            <li><a href="#">Contact Us</a></li>
            <li><a href="login.jsp">Sign Up</a></li>
            
        </ul>
    </div>

<div class="login-page">
  <div class="form">
  <h1>Sign In</h1>
    <form class="register-form" method = "post">
      <input type="text" name = "name" placeholder="Name"/>
      <input type="text" name = "password" placeholder="Password"/>
      <input type="text" name = "email" placeholder="Email address"/>
      <button>Sign Up</button>
      <p class="message">Already registered? <a href="#">Sign In</a></p>
    </form>
    <form class="login-form" method = "post">
      <input type="text" name = "sName" placeholder="Username"/>
      <input type="password" name = "sPassword" placeholder="Password"/>
      <button>login</button>
      <p class="message">Not registered? <a href="#">Create an account</a></p>
    </form>
  </div>
</div>


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
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	
	if (username != null && password != null && username.length() != 0 && password.length() != 0){
	
	String insert = "INSERT INTO weed.Users (username, password, email) VALUES ('" 
	+ username + "', '" + password + "', '" + email + "');";
	stmt.execute(insert);
	}else out.println("Username and/or password cannot be NULL!");

	String signName = request.getParameter("sName");
	String signPassword = request.getParameter("sPassword");
	
	
	if (signName != null && signPassword != null && signName.length() != 0 && signPassword.length() != 0){
		String selectSql = "SELECT username FROM weed.Users WHERE username ='" + signName + "' AND password = '" + signPassword + "';";
		ResultSet rs = stmt.executeQuery(selectSql);
		if(rs.next() ==  false) out.println("Wrong username or password!");
		else out.println("You have signed in!");
	}
	
   
	con.close(); 
} catch(SQLException e) { 
	out.println("SQLException caught: " +e.getMessage()); } 

%>

</body>
<script src = "js/myscripts.js"></script>
</html>