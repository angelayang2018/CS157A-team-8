<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weeder</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/home.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
</head>
<body>
	<nav>
		<h1>
			<a href="Home.jsp">Weeder</a>
		</h1>
		<form>
			<i class="fas fa-search"></i> <input type="text"
				placeholder="Search for products or sellers" />
		</form>
		<div class="nav-list">
			<a href="SignIn.jsp"><i class="fas fa-shopping-cart"></i></a> <a
				class="hello" href="SignIn.jsp"><span>Hello,</span><span>Sign
					In</span></a>
			<div class="dropdown">
				<a href="Products.jsp">Products</a>
				<div class="dropdown-content">
					<a href="YourProduct.jsp">Your Products</a> <a href="Products.jsp">All
						Products</a>
				</div>
			</div>
			<a href="SignUp.jsp"><button>Sign Up</button></a>
		</div>
	</nav>

	<div class="hero-container">
		<img src="images/banner.jpeg" alt="Weed Banner">
	</div>

<h2>Browse Catgeories</h2>
	<div class=category-container>
		
		

			<%
			String db = "weed";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				java.sql.Connection con;
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
				System.out.println(db + " database successfully opened. <br>");
				Statement statement = con.createStatement();
				// Read row
				String selectSql = "SELECT categoryName, imagePath FROM Category";
				ResultSet rs = statement.executeQuery(selectSql);
				while (rs.next()) {
					out.print("<div class = container><img src = \"images/" + rs.getString(2) + "\"/><p>" + rs.getString(1) + "</p></div>");
					System.out.println(rs.getString(2));
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

	<div class="about-container"></div>

	<footer>
		<div class="footer-container">
			<h1>Weeder</h1>

			<ul class="contact-info">
				<li><i class="fas fa-map-marker-alt"></i>1 Washington Sq, San
					Jose, CA 95192</li>
				<li><i class="fas fa-phone"></i>(123)-456-7890</li>
				<li><i class="fas fa-envelope"></i>weeder@gmail.com</li>
			</ul>

			<ul>
				<li>Products</li>
				<li>Sign In</li>
				<li>Sign Up</li>
				<li>Your Cart</li>
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