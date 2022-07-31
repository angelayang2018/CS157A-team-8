<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<link rel="icon" href="images/logo.png" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
<link rel="stylesheet" href="css/product.css" />
</head>
<body>
	<nav>
		<div class="logo-container">
			<img src="images/logo.png" />
			<h1>
				<a href="Home.jsp">Weeder</a>
			</h1>

		</div>
		<form>
			<i class="fas fa-search"></i> <input type="text"
				placeholder="Search for products or sellers" />
		</form>
		<div class="nav-list">
			<a href="SignIn.jsp"><i class="fas fa-shopping-cart"></i></a>

			<%
			if (session.getAttribute("currentUser") != null) {
				out.print("<a class = \"hello\" href = \"Profile.jsp\"><span>Hello,</span><span>"
				+ session.getAttribute("currentUser") + "</span>");
			} else
				out.print("<a class = \"hello\" href = \"SignIn.jsp\"><span>Hello,</span><span>Sign In</span>");
			%>

			<div class="dropdown">
				<a href="Products.jsp">Products</a>
				<div class="dropdown-content">
					<a href="YourProduct.jsp">Your Products</a> <a href="Products.jsp">All
						Products</a>
				</div>
			</div>
			<%
			if (session.getAttribute("currentUser") == null)
				out.print("<a href=\"SignUp.jsp\"><button>Sign Up</button></a>");
			else {
				out.print("<a href=\"Home.jsp\"><button id = \"logOut\">Log Out</button></a>");
			}
			%>
		</div>
	</nav>




	<h1 class=headerProducts>Products</h1>
	<div class="filter-container">
		<form>
			<%
			String db = "weed";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				java.sql.Connection con;
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
				System.out.println(db + " database successfully opened. <br>");
				Statement statement = con.createStatement();
				// Read row
				String selectSql = "SELECT categoryName FROM Category";
				ResultSet rs = statement.executeQuery(selectSql);
				while (rs.next()) {
					out.print("<input type = checkbox hidden name = " + rs.getString(1) + " id = " + rs.getString(1) + " value = "
					+ rs.getString(1) + "><label for = " + rs.getString(1) + ">" + rs.getString(1) + "</label>");

				}
			%>
			<input type="submit" value="Apply filters">
		</form>
	</div>
	<div class="product-container">
		<%
		//statement = con.createStatement();
		// Read row
		selectSql = "SELECT * FROM Products";
		rs = statement.executeQuery(selectSql);
		while (rs.next()) {

			out.println("<div class = product>" + "<h1>" + rs.getInt(1) + "</h1>");
			for (int i = 2; i <= 6; i++) {
				out.println("<p>" + rs.getString(i) + "</p>");
			}
			out.println("</div>");
		}
		rs.close();
		statement.close();

		} catch (SQLException e) {
		System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
		%>
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
<script type="text/javascript">
	document.getElementById("logOut").addEventListener("click", function() {
		 session.setAttribute("currentUser", null); 
	}) 
</script>

</html>