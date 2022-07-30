<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />

</head>
<body>
	<div class="toggle">
		<a><i class="fa fa-bars"></i></a>
	</div>
	<div class="menu"> <!-- use nav instead -->
		<ul>
			<li><a href="MySQL.jsp">Love and Peace, Get Some Weed</a></li>
			<li><a href="#">About</a></li>
			<li><a href="CreateProduct.jsp">Products</a></li>
			<li><a href="#">Contact Us</a></li>
			<li><a href="login.jsp">Sign Up</a></li>

		</ul>
	</div>
	<div class=product_container> <!-- maybe try <main> or<section> here -->
		<h1>Your Products</h1>
		<p>Create a new product</p>
		<div class="form_div"> <!-- do not need this div -->
			<form class=form_container> <!-- do not need form_container class if it is the only form on page -->
				<input type="text" name="title" placeholder="Title" />
				<textarea name="description" placeholder="Description of Product"></textarea>
				<input name="quantity" type="text" placeholder="Quantity" /> <input
					name="price" type="text" placeholder="Price" /> Choose a picture:
				<input type="file"> <input type="submit" value="Submit">
			</form>
		</div>

		<div class="inventory_container">
			<p>Your inventory</p>
		</div>
	</div>

	<%
	String db = "Yang";
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		java.sql.Connection con;
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, "root", "mrbigbear18!");
		out.println(db + " database successfully opened. <br>");
		Statement stmt = con.createStatement();

		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String quantity = request.getParameter("quantity");
		String price = request.getParameter("price");

		if (title != null && description != null && quantity != null) {

			String insert = "INSERT INTO weed.Products (title, description, quantity, price) VALUES ('" + title + "', '"
			+ description + "', '" + quantity + "', '" + price + "')";
			stmt.execute(insert);
		} else
			out.println("Title, description, or quantity cannot be NULL!");

		ResultSet rs = stmt.executeQuery("select * from weed.Products");
		while (rs.next())
			out.println("<br>" + rs.getInt(1) + " " + rs.getString(2) + " " + rs.getString(3) + " " + rs.getString(4) + " "
			+ rs.getString(5));
		con.close();
	} catch (SQLException e) {
		out.println("SQLException caught: " + e.getMessage());
	}
	%>

</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">
	>
</script>
<script src="js/myscripts.js"></script>
</html>