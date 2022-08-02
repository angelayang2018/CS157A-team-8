
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class AddReview
 */
@WebServlet("/AddReview")
public class AddReview extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public AddReview() {
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

			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("currentUser");
			String insertSql = "SELECT userid FROM Users WHERE username = '" + username + "';";

			ResultSet rs = stmt.executeQuery(insertSql);
			String productId = request.getParameter("productId");
			int userId = 0;
			if(rs.next()) userId = rs.getInt(1);
			String description = request.getParameter("product_review");

			dispatcher = request.getRequestDispatcher("/ProductDetails.jsp?productId" + userId);
			// returns the number of rows affected
			insertSql = "INSERT INTO Reviews(productId, userId, description) VALUES('" + productId + "', '" + userId
					+ "','" + description + "') ;";
			stmt.executeUpdate(insertSql);

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
