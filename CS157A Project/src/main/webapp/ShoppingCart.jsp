<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart</title>
<link rel="icon" href="images/logo.png" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/cart.css" />

<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
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
				if (session.getAttribute("currentUser") != null) {
					String select = "SELECT * from Users WHERE userid IN (SELECT userId FROM Admin) AND userid = '"
					+ (int) session.getAttribute("currentId") + "'";
					ResultSet check = statement.executeQuery(select);
					if (check.isBeforeFirst()) {
				out.println("<a href = Admin.jsp>Admin</a>");
					}
				}

				if (session.getAttribute("currentUser") == null)
					out.print("<a href=\"SignUp.jsp\"><button>Sign Up</button></a>");
				else {
					out.print(
					"<form method = \"post\" action = \"LogOut\"><input type = \"submit\" value = \"Log Out\"></input></form>");
				}
			%>

		</div>
	</nav>

	<div class=cart-container>
		<h1>Your Shopping Cart</h1>
		<%
		if (session.getAttribute("currentUser") != null) {
			Statement stmt = con.createStatement();

			int userId = (int) session.getAttribute("currentId");
			String selectSql = "SELECT shopCartId FROM ShoppingCart where userid = '" + userId + "';";
			ResultSet rs = stmt.executeQuery(selectSql);
			int cartId = 0;
			if (rs.next())
				cartId = rs.getInt(1);

			selectSql = "SELECT SUM(price) FROM CartItem where cartid = '" + cartId + "';";
			rs = stmt.executeQuery(selectSql);
			int total = 0;
			if (rs.next())
				total = rs.getInt(1);

			selectSql = "SELECT * FROM Products WHERE product_id IN (SELECT productid FROM CartItem WHERE cartid = '" + cartId
			+ "');";
			rs = stmt.executeQuery(selectSql);

			if (!rs.isBeforeFirst()) {
				out.println("You do not have anything in your shopping cart.");

			} else {
				while (rs.next()) {
		%>
		<div class=product-container>
			<%
			selectSql = "SELECT quantity, price FROM CartItem WHERE productid = '" + rs.getInt(1) + "' && cartid = '" + cartId
					+ "';";
			Statement itemStmt = con.createStatement();
			ResultSet itemRs = itemStmt.executeQuery(selectSql);
			while (itemRs.next()) {
			%>
			<form method="post" action="UpdateCart">
				<p>
					Product ID#
					<%=rs.getInt(1)%>
				</p>
				<h2>
					<a href="ProductDetails.jsp?productId=<%=rs.getString(1)%>"><%=rs.getString(2)%></a>
				</h2>
				<p>
					Description:
					<%=rs.getString(3)%></p>
				<p>
					Category:
					<%=rs.getString(6)%></p>
				<p>
					Seller:
					<%=rs.getString(7)%></p>

				<p>
					Quantity:
					<%=itemRs.getInt(1)%></p>

				<p>
					Price: $<%=itemRs.getInt(2)%></p>


				<%
				}
				%>

				<button type="submit" name="delete" value=<%=rs.getInt(1)%>>Delete</button>
			</form>
		</div>

		<%
		}
		%>
		<h2>
			Total: $<%=total%></h2>
		<form method="post" action="Checkout">
			<button type=submit value=<%=userId%>>Check Out</button>
		</form>
		<%
		}
		}else{out.println("You must be signed in to see your shopping cart.");}
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