<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Transaction</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/tran.css" />
</head>
<body>
<nav>
		<div class="logo-container">
			<img src="images/logo.png" />
			<h1>
				<a href="Home.jsp">Weeder</a>
			</h1>

		</div>
		<form method="post" action="Products.jsp">
			<i class="fas fa-search"></i> <input type="text" name="search"
				placeholder="Search for products or sellers" />
		</form>
		<div class="nav-list">
			<%
			if (session.getAttribute("currentUser") != null) {
				out.print("<a href = \"ShoppingCart.jsp\"><i class=\"fas fa-shopping-cart\"></i></a>");
				out.print("<a class = \"hello\" href = \"Profile.jsp\"><span>Hello,</span><span>"
						+ session.getAttribute("currentUser") + "</span>");
			} else {
				out.print("<a href = \"SignIn.jsp\"><i class=\"fas fa-shopping-cart\"></i></a>");
				out.print("<a class = \"hello\" href = \"SignIn.jsp\"><span>Hello,</span><span>Sign In</span>");
			}
			%>

			<div class="dropdown">
				<a href="Products.jsp">Products</a>
				<div class="dropdown-content">
					<a
						href="<%if (session.getAttribute("currentUser") == null)
	out.println("SignIn.jsp");
else
	out.println("YourProduct.jsp");%>">Your
						Products</a> <a href="Products.jsp">All Products</a> <a
						href="<%if (session.getAttribute("currentUser") == null)
	out.println("SignIn.jsp");
else
	out.println("Orders.jsp");%>">Your
						Orders</a>
				</div>
			</div>
			<%
			String db = "weed";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				java.sql.Connection con;
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
				System.out.println(db + " database successfully opened. <br>");
				Statement statement = con.createStatement();
				if (session.getAttribute("currentUser") != null){
				String select = "SELECT * from Users WHERE userid IN (SELECT userId FROM Admin) AND userid = '" + (int)session.getAttribute("currentId") +"'";
				ResultSet check = statement.executeQuery(select);
				if(check.isBeforeFirst()){
					out.println("<a href = Admin.jsp>Admin</a>");
				}
				}
			
			
			if (session.getAttribute("currentUser") == null)
				out.print("<a href=\"SignUp.jsp\"><button>Sign Up</button></a>");
			else {
				out.print(
				"<form method = \"post\" action = \"LogOut\"><input type = \"submit\" value = \"Log Out\"></input></form>");
			}} catch (SQLException e) {
				System.out.println("SQLException caught: " + e.getMessage());
			} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
			%>

		</div>
	</nav>
	<div class = "tran-container">
	<p id = "errorMessage"></p>
		<form action=Checkout method="post">
			<h1>Check Out</h1>
			<input type="text" name="firstname" placeholder="First Name" required />
			<input type="text" name="lastname" placeholder="Last Name" required />
			<input type="text" name="card" placeholder="Card Number" required />
			<button>Checkout</button>
		</form>
		</div>


<footer>
		<div class="footer-container">
			<div class="logo-container">
				<img class="footerimg" src="images/logo.png" />
				<h1>
					<a href="Home.jsp">Weeder</a>
				</h1>

			</div>

			<ul class="contact-info">
				<li><i class="fas fa-map-marker-alt"></i>1 Washington Sq, San
					Jose, CA 95192</li>
				<li><i class="fas fa-phone"></i>(123)-456-7890</li>
				<li><i class="fas fa-envelope"></i>weeder@gmail.com</li>
			</ul>

			<ul>
				<li><a href="YourProduct.jsp">Your Products</a></li>
				<li><a href="Profile.jsp">Your Profile</a></li>
				<li><a href="Products.jsp">Products</a></li>
				<li><a href="SignIn.jsp">Sign In</a></li>
				<li><a href="SignUp.jsp">Sign Up</a></li>
				<li><a href="ShoppingCart.jsp">Your Cart</a></li>
			</ul>

		</div>
		<hr>
		<div class="copyright">
			<p>Copyright © 2022 Weeder</p>
			<p>Made by Swift Sheng and Angela Yang</p>
		</div>
	</footer>
</body>
</html>