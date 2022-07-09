<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Weeder</title>
<link rel="stylesheet" href="css/home.css" />
<link rel="stylesheet" href="css/style.css" />
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
			<li><a href="About.jsp">About Us</a></li>
			<li><a href="Products.jsp">Products</a></li>
			<li><a href="SignUp.jsp"><button>Sign Up</button></a></li>
		</ul>
	</nav>

	<div class="hero-container"></div>

	<div class=category-container>
		<h2>Browse Catgeories</h2>
	</div>

	<footer>
		<div class="footer-container">
			<h1>Weeder</h1>

			<ul class = "contact-info">
				<li><i class="fas fa-map-marker-alt"></i>1 Washington Sq, San
					Jose, CA 95192</li>
				<li><i class="fas fa-phone"></i>(123)-456-7890</li>
				<li><i class="fas fa-envelope"></i>weeder@gmail.com</li>
			</ul>

			<ul>
				<li>About Us</li>
				<li>Products</li>
				<li>Sign In</li>
				<li>Sign Up</li>
				<li>Your Products</li>
			</ul>

		</div>
		<hr>
		<div class="copyright">
			<p>Copyright © 2022 Weeder</p>
			<p>Made with <3 by Dias Mustafin, Swift Sheng, Angela Yang</p>
		</div>
	</footer>


</body>
</html>