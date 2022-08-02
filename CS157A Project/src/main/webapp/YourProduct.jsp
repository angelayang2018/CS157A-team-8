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
						<a href = "<%if (session.getAttribute("currentUser") == null)
	out.println("SignIn.jsp");
else
	out.println("Orders.jsp");%>">Your Orders</a>
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
			<option value="Vape Pen">
		</datalist>
		<button>Add Product</button>
	</form>


	<div class="yourProducts">
		<h1>Pending Products</h1>
	</div>
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
			String selectSql = "SELECT * FROM Products WHERE sellerName = \"" + session.getAttribute("currentUser") + "\";";
			ResultSet rs = statement.executeQuery(selectSql);
			//statement = con.createStatement();
			// Read row
			if (!rs.isBeforeFirst()) {
				out.println("<p>You have no products currently.</p>");
			} else {
				out.println("<form method = \"post\" action = \"UpdateProduct\">");
				out.println("<input id = check name = check type = hidden />");
				out.println(
				"<table><tr><th class=\"colored\">Product ID</th><th>Title</th><th class=\"colored\">Description</th><th>Quantity</th><th class=\"colored\">Price</th><th>Category</th></tr>");
				while (rs.next()) {
			out.println("<tr>");

			String[] header = {"productId", "title", "description", "quantity", "price", "category"};
			for (int i = 1; i <= 6; i++) {

				if (i % 2 == 0)
					out.println("<td id = \"" + header[i - 1] + rs.getString(1) + "\">" + rs.getString(i) + "</td>");
				else
					out.println("<td id = \"" + header[i - 1] + rs.getString(1) + "\" class = lightColored>"
							+ rs.getString(i) + "</td>");

			}
			out.println("<td class = noBorder><button type = button id = \"" + rs.getString(1)
					+ "\" onClick = \"editClicked(this.id)\">Edit</button></td>");
			out.println("<td class = \"noBorder hidden\" id = \"saveContainer" + rs.getString(1)
					+ "\"><button class = hidden name = save value = \"" + rs.getString(1)
					+ "\"onClick = changeCheck(this.value) type = submit id = \"save" + rs.getString(1)
					+ "\">Save</button></td>");
			out.println("<td class = \"noBorder hidden\" id = \"cancelContainer" + rs.getString(1)
					+ "\"><a href = YourProduct.jsp><button class = \"hidden type\" = button id = \"cancel"
					+ rs.getString(1) + "\">Cancel</button></a></td>");

			out.println("<td class = noBorder><button id = \"delete" + rs.getString(1)
					+ "\" name = delete type = submit value ='" + rs.getString(1) + "' >Delete</button></td>");
			out.println("</tr>");
				}
				out.println("</table>");
				out.println("</form>");
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
	function editClicked(clicked_id) {
		const ids = [ "productId", "title", "description", "quantity", "price",
				"category" ];
		for (let i = 0; i < ids.length; i++) {
			var info = document.getElementById(ids[i] + clicked_id);
			var newInput = document.createElement("input");
			newInput.setAttribute("required", true);
			newInput.setAttribute("name", ids[i] + clicked_id);
			newInput.setAttribute("id", ids[i] + clicked_id);
			if (i == 0)
				newInput.setAttribute("readonly", true);
			newInput.value = info.innerHTML;
			info.innerHTML = "";
			info.append(newInput);

			var edit = document.getElementById(clicked_id);
			var save = document.getElementById("save" + clicked_id);
			var saveC = document.getElementById("saveContainer" + clicked_id);
			var cancel = document.getElementById("cancel" + clicked_id);
			var cancelC = document.getElementById("cancelContainer"
					+ clicked_id);
			var deleteB = document.getElementById("delete" + clicked_id);
			edit.classList.add("hidden");
			deleteB.classList.add("hidden");
			save.classList.remove("hidden");
			cancel.classList.remove("hidden");
			saveC.classList.remove("hidden");
			cancelC.classList.remove("hidden");

		}
	}

	function changeCheck(value) {
		var check = document.getElementById("check");
		console.log(value);
		check.value = value;

	}
</script>
</html>