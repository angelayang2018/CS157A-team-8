<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>

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
		<form method = "post" action = "Products.jsp">
			<i class="fas fa-search"></i> <input type="text"
				name = "search" placeholder="Search for products or sellers" />
		</form>
		<div class="nav-list">
			<%
			if (session.getAttribute("currentUser") != null) {
				out.print("<a href = \"ShoppingCart.jsp\"><i class=\"fas fa-shopping-cart\"></i></a>");
			} else {out.print("<a href = \"SignIn.jsp\"><i class=\"fas fa-shopping-cart\"></i></a>");}
			%>

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
	<h1 class=headerProducts>Products</h1>
	<div class="filter-container">
		<form method = "post" action = "Products.jsp">
			<%
			String db = "weed";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				java.sql.Connection con;
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
				System.out.println(db + " database successfully opened.");
				Statement statement = con.createStatement();
				// Read row
				String selectSql = "SELECT categoryName FROM Category";
				ResultSet rs = statement.executeQuery(selectSql);
				while (rs.next()) {
					out.print("<input type = checkbox name = checked hidden value = " + rs.getString(1) + " id = " + rs.getString(1) + " value = "
					+ rs.getString(1) + "><label for = " + rs.getString(1) + ">" + rs.getString(1) + "</label>");

				}
			%>
			<input type="submit" value="Apply filters">
		</form>
	</div>
	<div class="product-container">
		<%
		/*StringBuffer requestURL = request.getRequestURL();
		if (request.getQueryString() != null) {
		    requestURL.append("?").append(request.getQueryString());
		}
		String completeURL = requestURL.toString();
		System.out.println(completeURL);

		String query = request.getQueryString();
		System.out.println(query);*/
		
		String[] checkedArray = request.getParameterValues("checked");
		if (checkedArray != null)
		for(int i = 0; i < checkedArray.length; i++){
			System.out.println("checkedArray " + checkedArray[i]);
		}
		
	
	
		selectSql = "SELECT * FROM Products WHERE ";
		String category = request.getParameter("category");
		String search = request.getParameter("search");

		if (category != null && search == null) { //filter for category but no search word
			String[] categoryArray = category.split(" ");
				//singular category
			if (categoryArray.length == 1) selectSql = selectSql + "category = '" + category + "';";
			else{ //multiple category filter
				selectSql =  selectSql + "category = '" + categoryArray[0] + "'";
				for(int i = 1; i < categoryArray.length; i++){
					selectSql = selectSql + "|| category = '" + categoryArray[i] + "'";
				}
			}
			selectSql = selectSql + ";";
		} else if (search != null && category == null) { //search word but no category
			selectSql = selectSql + "sellerName LIKE '%" + search + "%' || title LIKE '%" + search
			+ "%' || description LIKE '%" + search + "%' || category LIKE '%" + search + "%';";
		}else if(search != null && category != null){ //search word and category
			selectSql = selectSql + "sellerName LIKE '%" + search + "%' || title LIKE '%" + search
					+ "%' || description LIKE '%" + search + "%' || category LIKE '%" + search + "%'";
			String[] categoryArray = category.split(" ");
			for(int i = 0; i < categoryArray.length; i++){
				selectSql = selectSql + "|| category = '" + categoryArray[i] + "'";
			}
		selectSql = selectSql + ";";
			
		}else if(checkedArray!=null){
			if (checkedArray.length == 1) selectSql = selectSql + "category = '" + checkedArray[0] + "';";
			else{ //multiple category filter
				selectSql = selectSql + "category = '" + checkedArray[0] + "'";
				for(int i = 1; i < checkedArray.length; i++){
					selectSql = selectSql + "|| category = '" + checkedArray[i] + "'";
				}
			}
			selectSql = selectSql + ";";
			
		} else //no search word or category filter
			selectSql = "SELECT * FROM Products WHERE quantity <> '0';";
		rs = statement.executeQuery(selectSql);
		while (rs.next()) {

			out.println("<a href = ProductDetails.jsp?productId=" + rs.getString(1) + "><div class = product>" + "<h1>" + rs.getString(2) + "</h1>");
			for (int i = 3; i <= 7; i++) {
				out.println("<p>" + rs.getString(i) + "</p>");
			}
			out.println("</div></a>");
		}
		rs.close();
		statement.close();

		} catch (SQLException e) {
		System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
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