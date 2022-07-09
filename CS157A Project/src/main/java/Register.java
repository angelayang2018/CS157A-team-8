
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;
import java.io.*;

/**
 * Servlet implementation class Register
 */
@WebServlet("/register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String db = "weed";
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");
			Statement stmt = con.createStatement();

			String firstname = request.getParameter("first_name");
			String lastname = request.getParameter("last_name");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");

			String insertSql = "INSERT INTO users (firstname, lastname, phone, email, username, password) VALUES ('"
					+ firstname + "', '" + lastname + "', '" + phone + "', '" + email + "', '" + username + "', '"
					+ password + "')";
			
			dispatcher = request.getRequestDispatcher("/SignIn.jsp");
			//returns the number of rows affected
			int rows = stmt.executeUpdate(insertSql);
		
			if (rows > 0) {
			request.setAttribute("status", "success");
			}else request.setAttribute("status", "failed");
			
			dispatcher.forward(request, response);
			
			//response.sendRedirect("SignUp.jsp");

		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
