<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/product.css" />
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
		<ul class="nav-list">
			<li><a href="SignIn.jsp"><i class="fas fa-shopping-cart"></i></a></li>
			<li><a href="SignIn.jsp">Hello, Sign In</a></li>
			<li><a href="Products.jsp">Products</a></li>
			<li><a href="SignUp.jsp"><button>Sign Up</button></a></li>
		</ul>
	</nav>

	<form action="Create" method="post">
		<h1>Add Your Product</h1>
		<input type="text" name="product_title" placeholder="Product Title"
			required />
		<textarea name = "product_description" placeholder="Product Description"></textarea>
		<input type="text" name="quantity" placeholder="Quantity" required />
		<input type="text" name="price" placeholder="Price" required />
		<input list = "category" name = "category" placeholder = "Category">
		<datalist id = "category">
			<option value = "Flower">
			<option value = "Edibles">
			<option value = "Concentrates">
			<option value = "Topicals">
			<option value = "Pre-Roll">
			<option value = "CBD">
			<option value = "Plants and Seeds">
		</datalist>
		<button>Add Product</button>
	</form>

	<div class = "product-container">
		<h1>Products</h1>
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
				while(rs.next())
					out.println("<br>" + rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3)+" "+rs.getString(4) +" "+rs.getString(5) +" "+rs.getString(6));
				rs.close();
				statement.close();
			
		}catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		%>
	</div>
</body>
</html>