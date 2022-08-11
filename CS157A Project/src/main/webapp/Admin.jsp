<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin</title>
<link rel="stylesheet" href="css/admin.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
</head>
<body>
<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
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

	<%
	

		String selectSql = "SELECT * FROM Admin WHERE userid = '" + session.getAttribute("currentId") + "';";
		ResultSet rs = statement.executeQuery(selectSql);
		if (!rs.isBeforeFirst()) {
			out.println("<div class = error>You do not have access to this page.</div>");

		} else {
	%>
	<div class="userInfo">
		<h1>Users</h1>
		<form method="post" action="DeleteUser">
			<table>
				<tr>
					<th>First Name</th>
					<th>Last Name</th>
					<th>Username</th>
					<th>Password</th>
					<th>Phone</th>
					<th>Email</th>
					<th>Userid</th>
				</tr>
				<%
				selectSql = "SELECT * FROM Users WHERE userid NOT IN (SELECT userid FROM Admin)";
				rs = statement.executeQuery(selectSql);
				if (!rs.isBeforeFirst()) {
					out.println("There are no users.");
				} else {

					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getString(4)%></td>
					<td><%=rs.getString(5)%></td>
					<td><%=rs.getString(6)%></td>
					<td><%=rs.getInt(7)%></td>
					<td><button type=submit name="delete" value=<%=rs.getInt(7)%>>Delete</button></td>
				</tr>
				<%
				}
				}
				%>

			</table>
		</form>

	</div>

	<div class="productInfo">
		<h1>Products</h1>
		<form method="post" action="DeleteProduct">
			<table>
				<tr>
					<th>Product ID</th>
					<th>Title</th>
					<th>Description</th>
					<th>Quantity</th>
					<th>Price</th>
					<th>Category</th>
					<th>Seller</th>
				</tr>
				<%
				selectSql = "SELECT * FROM Products";
				rs = statement.executeQuery(selectSql);
				if (!rs.isBeforeFirst()) {
					out.println("There are no products.");
				} else {

					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getInt(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><%=rs.getString(3)%></td>
					<td><%=rs.getInt(4)%></td>
					<td><%=rs.getInt(5)%></td>
					<td><%=rs.getString(6)%></td>
					<td><%=rs.getString(7)%></td>
					<td><button type = submit name = delete value =<%=rs.getInt(1)%>>Delete</button></td>
				</tr>


				<%
				}
				}
				%>


			</table>
		</form>

	</div>

	<%
	selectSql = "SELECT permission FROM Admin WHERE userid = '" + session.getAttribute("currentId") + "';";
	rs = statement.executeQuery(selectSql);
	int permission = 0;
	if (rs.next())
		permission = rs.getInt(1);
	if (permission == 2) {
	%>
	<div class="adminInfo">
		<h1>Administrators</h1>
		<p>*Permission = 1 Limited permission</p>
		<p>*Permission = 2 Full permission</p>
		<form method="post" action="DeleteAdmin">
			<table>
				<tr>
					<th>Admin ID</th>
					<th>User ID</th>
					<th>Permission</th>
				</tr>
				<%
				selectSql = "SELECT * FROM Admin";
				rs = statement.executeQuery(selectSql);
				if (!rs.isBeforeFirst()) {
					out.println("There are no Admins.");
				} else {

					while (rs.next()) {
				%>
				<tr>
					<td><%=rs.getInt(1)%></td>
					<td><%=rs.getInt(2)%></td>
					<td><%=rs.getInt(3)%></td>
					<%
					if (rs.getInt(3) != 2) {
					%>
					<td><button type = "submit" name = "delete" value =<%=rs.getInt(1)%>> Delete</button></td>
					<%
					}
					%>
				</tr>


				<%
				}
				}
				%>

			</table>
		</form>
		
		<form method = "post" action = "AddAdmin">
		<h2>Add Admin</h2>
		<input type = "text" name = "userid" placeholder = "User Id"/>
		<input type = "text" name = "permission" placeholder = "Permission Level"/>
		<button type = "submit">Add</button>
		<p id = "errorMessage"></p>
		</form>
	</div>

	<%
	}
	rs.close();
	statement.close();
	}
	} catch (SQLException e) {
	System.out.println("SQLException caught: " + e.getMessage());
	} catch (ClassNotFoundException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	}
	%>

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
	var status = document.getElementById("status").value;
	if(status == "failed"){
		document.getElementById("errorMessage").innerHTML = "There is no user with that user id.";
	}else if(status == "failedPermission")
		document.getElementById("errorMessage").innerHTML = "Permission level must be either 1 or 2.";
	else if(status == "failedUnknown") document.getElementById("errorMessage").innerHTML = "Error Occurred. Try again later. ";
	else console.log("success");
	</script>
</html>