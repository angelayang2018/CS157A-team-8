<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders</title>
<link rel="icon" href="images/logo.png" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
<link rel="stylesheet" href="css/order.css" />
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
			}
			%>

		</div>
	</nav>


	<div class="order-container">
		<h1>Your Orders</h1>

		<%
		
			Statement stmt = con.createStatement();

			int userId = (int) session.getAttribute("currentId");

			String selectSql = "SELECT orderid FROM Orders WHERE userid = '" + userId + "';";
			ResultSet rs = stmt.executeQuery(selectSql);
			int total = 0;

			if (!rs.isBeforeFirst()) {
				out.println("You do not have any orders.");
			}
			else {
				while (rs.next()) {
			selectSql = "SELECT SUM(price) FROM OrderItem where orderid = '" + rs.getInt(1) + "';";
			Statement totalStmt = con.createStatement();
			ResultSet totalRs = totalStmt.executeQuery(selectSql);

			if (totalRs.next())
				total = totalRs.getInt(1);

			selectSql = "SELECT * FROM OrderItem WHERE orderid = '" + rs.getInt(1) + "';";
			Statement itemStmt = con.createStatement();
			ResultSet itemRs = itemStmt.executeQuery(selectSql);
		%>
		<div class="order">
			<h2>
				Order #<%=rs.getInt(1)%></h2>
			<%
			while (itemRs.next()) {
			%>
			<div class="order-item">
				<%
				selectSql = "SELECT * FROM Products WHERE product_id = '" + itemRs.getInt(2) + "';";
				Statement itemInfo = con.createStatement();
				ResultSet itemInfoRs = itemInfo.executeQuery(selectSql);
				while (itemInfoRs.next()) {
				%>
				<h2>
					<a
						href="ProductDetails.jsp?productId=<%=itemInfoRs.getString(1)%>"><%=itemInfoRs.getString(2)%></a>
				</h2>

				<p>
					Quantity:
					<%=itemRs.getInt(3)%></p>
				<p>
					Price: $<%=itemRs.getInt(4)%></p>
			</div>

			<%
			}
			}
			%>
			<hr />
			<p>
				Total Price: $<%=total%>
			</p>
		</div>
		<%
		}
		}

		} catch (SQLException e) {
		System.out.println("SQLException caught: " + e.getMessage());
		out.println("Error occurred");

		} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		} catch (Exception e) {
		out.println("Error occurred");
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