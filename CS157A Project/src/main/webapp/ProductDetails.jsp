<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProductDetails</title>
<link rel="icon" href="images/logo.png" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/productDetail.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
</head>
<body>
	<input type="hidden" id="statusReview" name="statusReview"
		value="<%=request.getAttribute("statusReview")%>">
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
	<div class="productdetail-container">

		<form method="post" action="AddToCart">
			<%
			//System.out.println(productId);

			
				Statement stmt = con.createStatement();
				String productId = request.getParameter("productId");

				String username = (String) (session.getAttribute("currentUser"));
				String insertSql = "SELECT userid FROM Users WHERE username = '" + username + "';";

				ResultSet rs = stmt.executeQuery(insertSql);
				int userId = 0;
				if (rs.next())
					userId = rs.getInt(1);

				String selectSql = "SELECT * FROM Products WHERE product_id ='" + productId + "';";
				rs = stmt.executeQuery(selectSql);

				if (rs.next()) {
			%>
			<div class=product-container>
				<p>
					Product ID#
					<%=rs.getInt(1)%>
				</p>
				<h2><%=rs.getString(2)%></h2>
				<p>
					Description:
					<%=rs.getString(3)%></p>
				<p>
					Quantity:
					<%=rs.getString(4)%></p>
				<p>
					Price: $<%=rs.getString(5)%></p>
				<p>
					Category:
					<%=rs.getString(6)%></p>
				<p>
					Seller:
					<%=rs.getString(7)%></p>

			</div>
			<%
			}
			%>

			<input name="productId" type="hidden"
				value=<%=request.getParameter("productId")%>> 
				<% 
					int quantity = Integer.parseInt(rs.getString(4));
					if(quantity > 0){
				%>
				<input type=text name=quantity placeholder="Quantity" required /> 
				<input type=submit value="Add to Cart" />
				<p id="errorMessageCart"></p>
				<%
					}else out.println("Out of Stock.");
				
				%>
		</form>


	</div>

	<div class="reviews">
		<h1>Reviews</h1>
		<p id="errorMessage"></p>
		<form method="post" action="AddReview">
			<p>Write a review</p>
			<input name="productId" type="hidden"
				value=<%=request.getParameter("productId")%>>
			<textarea name="product_review" placeholder="Product Review"></textarea>
			<input type="submit" />
		</form>

		<%
		selectSql = "SELECT userId, description FROM Reviews WHERE productId ='" + productId + "';";
		rs = stmt.executeQuery(selectSql);
		if (rs.isBeforeFirst()) {

			while (rs.next()) {
		%>
		<div class=review-container>
			<form method="post" action="UpdateReview">
				<input name="pId" type="hidden"
					value=<%=request.getParameter("productId")%>>
				<div class="review">
					<p>
						User#<%=rs.getInt(1)%></p>
					<p><%=rs.getString(2)%></p>
				</div>
				<%
				if (rs.getInt(1) == userId) {
				%>
				<div class="reviewEdit">
					<input type="hidden" value="Edit">
					<button name="delete" type="submit" value=<%=rs.getString(1)%>>Delete</button>
					<input type="hidden" value="Save"> <input type="hidden"
						value="Cancel">

				</div>
			</form>

			<%
			}
			%>

		</div>
		<%
		}

		} else {
		%>
		<p>Be the first to comment!</p>
		<%
		}

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
	var status = document.getElementById("statusReview").value;
	console.log(status);
	if (status == "failed") {
		document.getElementById("errorMessage").innerHTML = "Error occurred. You can only write one review per product.";
	}else if(status == "failedCart"){
		document.getElementById("errorMessageCart").innerHTML = "Error occurred. Quantity must be a number and it must be less that the total quantity.";
	}else{
		console.log("hello");
	}
</script>

</html>