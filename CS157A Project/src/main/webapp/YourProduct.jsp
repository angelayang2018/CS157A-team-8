<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Products</title>
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

	<form class="addProduct" action="Create" method="post">
		<h1>Add Your Product</h1>
		<input type="text" name="product_title" placeholder="Product Title"
			required />
		<textarea name="product_description" placeholder="Product Description"></textarea>
		<input type="text" name="quantity" placeholder="Quantity" required />
		<input type="text" name="price" placeholder="Price" required /> <input
			list="category" name="category" placeholder="Category">
		<datalist id="category">
			<option value="Flower">
			<option value="Edibles">
			<option value="Concentrates">
			<option value="Topicals">
			<option value="Pre-Roll">
			<option value="CBD">
			<option value="Plants and Seeds">
		</datalist>
		<button>Add Product</button>
	</form>

	<div class="yourProducts">
		<h1>Your Products</h1>
	</div>

	<div class="product-container">
		<%
		String db = "weed";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");
			Statement statement = con.createStatement();
			// Read row
			String selectSql = "SELECT * FROM Products";
			ResultSet rs = statement.executeQuery(selectSql);
			//statement = con.createStatement();
			// Read row
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

</html>