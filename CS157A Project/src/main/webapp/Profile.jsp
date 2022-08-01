<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Your Profile</title>
<link rel="icon" href="images/logo.png" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
<link rel="stylesheet" href="css/profile.css" />
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
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">
	<div class="profile-container">
		<h1>Manage Your Profile</h1>
		<p id="errorMessage"></p>
		<div class="edit-container">

			<button id="edit">
				Edit <i class="fas fa-edit"></i>
			</button>
			<a href="Profile.jsp">
				<button id="cancel" class="hidden">Cancel</button>
			</a>
		</div>
		<form method="post" action="UpdateProfile">
			<%
			String db = "weed";
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				java.sql.Connection con;
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
				System.out.println(db + " database successfully opened. <br>");
				Statement statement = con.createStatement();
				// Read row
				String selectSql = "SELECT* FROM Users WHERE username = \"" + session.getAttribute("currentUser") + "\";";
				ResultSet rs = statement.executeQuery(selectSql);
				String[] fieldNames = {"First Name", "Last Name", "Username", "Password", "Phone", "Email"};
				if (rs.next())
					for (int i = 1; i <= 6; i++) {
				if (i % 2 == 0) {
					out.print("<div class = infoContainer><h3>" + fieldNames[i - 1] + "</h3><p id = " + fieldNames[i - 1]
							+ ">" + rs.getString(i) + "</p></div>");
				} else {
					out.print("<div class = \"infoContainer colored\"><h3>" + fieldNames[i - 1] + "</h3><p id = "
							+ fieldNames[i - 1] + ">" + rs.getString(i) + "</p></div>");

				}
					}

			} catch (SQLException e) {
				System.out.println("SQLException caught: " + e.getMessage());
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			%>
			<input type=submit value="Save Changes" id="saveChanges"
				class="hidden" />
		</form>
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
	document.getElementById("edit").addEventListener(
			"click",
			function() {
				var saveChange = document.getElementById("saveChanges");
				var cancel = document.getElementById("cancel");
				var edit = document.getElementById("edit");
				edit.classList.add("hidden");
				saveChange.classList.remove("hidden");
				cancel.classList.remove("hidden");
				const ids = [ "First", "Last", "Username", "Password", "Phone",
						"Email" ];
				for (let i = 0; i < ids.length; i++) {
					var info = document.getElementById(ids[i]);
					var newInput = document.createElement("input");
					newInput.setAttribute("required", true);
					newInput.setAttribute("name", ids[i]);
					if (i == ids.length - 1)
						newInput.type = "email";
					newInput.value = info.innerHTML;
					info.parentNode.replaceChild(newInput, info);
				}
			})
</script>
<script type="text/javascript">
	var status = document.getElementById("status").value;
	if (status == "success") {
		document.getElementById("errorMessage").innerHTML = "Changes saved successfully.";
	} else if (status == "failed") {
		document.getElementById("errorMessage").innerHTML = "Username is taken.";
		console.log("bad");
	} else
		console.log("no good");
</script>
</html>