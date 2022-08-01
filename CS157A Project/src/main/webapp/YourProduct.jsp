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
					<a
						href="<%if (session.getAttribute("currentUser") == null)
	out.println("SignIn.jsp");
else
	out.println("YourProduct.jsp");%>">Your
						Products</a> <a href="Products.jsp">All Products</a>
				</div>
			</div>
			<%
			if (session.getAttribute("currentUser") == null)
				out.print("<a href=\"SignUp.jsp\"><button>Sign Up</button></a>");
			else {
				out.print(
				"<form method = \"post\" action = \"LogOut\"><input type = \"submit\" value = \"Log Out\"></input></form>");

			}
			%>
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
		<table>
			<tr>
			<th class = "colored">Product ID</th>
				<th>Title</th>
				<th class = "colored">Description</th>
				<th>Quantity</th>
				<th class = "colored">Price</th>
				<th>Category</th>
			</tr>
			<%
			String db = "weed";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				java.sql.Connection con;
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
				System.out.println(db + " database successfully opened. <br>");
				Statement statement = con.createStatement();
				// Read row
				String selectSql = "SELECT * FROM Products WHERE sellerName = \"" + session.getAttribute("currentUser") + "\";";
				ResultSet rs = statement.executeQuery(selectSql);
				//statement = con.createStatement();
				// Read row
				while (rs.next()) {
					out.println("<tr>");
					for (int i = 1; i <= 6; i++) {
						if(i % 2 == 0)
				out.println("<td>" + rs.getString(i) + "</td>");
						else 
							out.println("<td class = lightColored>" + rs.getString(i) + "</td>");
					}
					out.println("<td class = noBorder><form><input type = submit value = Edit></form></td>");
					out.println("<td class = noBorder><form method = \"post\" action = \"Delete\"><button name = delete type = submit value ='" + rs.getString(1) + "' >Delete</button></form></td>");
					out.println("</tr>");
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
		</table>
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