<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
<link rel="stylesheet"
	href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" />
<link rel="stylesheet" href="css/sign.css" />
</head>
<body>
	<a href="Home.jsp"><i class="fa fa-arrow-left fa-2x"></i></a>

	<div class="sign-container">
		<h1>Weeder</h1>
		<form class="form-container" action="register" method="post">
			<p id="sign-header">Sign Up</p>
			<input type="text" name="first_name" placeholder="First Name"
				required /> <input type="text" name="last_name"
				placeholder="Last Name" required /> <input type="email"
				name="email" placeholder="Email" required /> <input type="text"
				name="phone" placeholder="Phone Number" /> <input type="text"
				name="username" placeholder="Username" required /> <input
				type="password" name="password" placeholder="Password" required />
			<div class="agecheck-container">
				<input type="checkbox" id="age_check" name="age_check" /> <label
					for="age_check">I agree to the Terms of Service and I
					verify that I am 21 years or older.</label>
			</div>
			<button>Register</button>
		</form>
		<p>
			Already have an account? <a href="SignIn.jsp">Sign in</a>
		</p>
	</div>
</body>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js">
	>
</script>
</html>