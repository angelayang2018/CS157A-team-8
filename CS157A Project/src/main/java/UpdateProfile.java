import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class UpdateProfile
 */
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public UpdateProfile() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

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
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root",
					"mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");
			Statement stmt = con.createStatement();

			String firstname = request.getParameter("First");
			String lastname = request.getParameter("Last");
			String username = request.getParameter("Username");
			String password = request.getParameter("Password");
			String email = request.getParameter("Email");
			String phone = request.getParameter("Phone");

			HttpSession session = request.getSession();
			String currentUser = (String) session.getAttribute("currentUser");

			String updateSql = "UPDATE Users SET firstname = '" + firstname + "', lastname = '" + lastname
					+ "', username = '" + username + "', password = '" + password + "', email = '" + email
					+ "', phone = '" + phone + "' WHERE username = '" + currentUser + "';";

			dispatcher = request.getRequestDispatcher("/Profile.jsp");
			// returns the number of rows affected
			int rows = stmt.executeUpdate(updateSql);
			if (!username.equals(currentUser)) {
				updateSql = "UPDATE Products SET sellerName = '" + username + "' WHERE sellerName = + '" + currentUser
						+ "';";
				stmt.execute(updateSql);
				session.setAttribute("currentUser", username);
			}
			if (rows > 0) {
				request.setAttribute("status", "success");

			} else
				request.setAttribute("status", "failed");

			dispatcher.forward(request, response);

			// response.sendRedirect("SignUp.jsp");

		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("/SignUp.jsp");
			request.setAttribute("status", "failed");
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
