
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class LoginCheck
 */
@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {
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
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, "root", "mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");
			Statement stmt = con.createStatement();

			String username = request.getParameter("username");
			String password = request.getParameter("password");

			String selectSql = "SELECT * FROM weed.Users WHERE username ='" + username + "' AND password = '" + password
					+ "';";
			
			ResultSet rs = stmt.executeQuery(selectSql);
			if (rs.next() == false) {
				dispatcher = request.getRequestDispatcher("/SignIn.jsp");
				request.setAttribute("status", "failed");
				dispatcher.forward(request, response);
				// response.sendRedirect("SignIn.jsp");
			} else {
				selectSql = "SELECT userid FROM Users WHERE username = '" + username + "';";
				rs = stmt.executeQuery(selectSql);
				int userId = 0;
				if (rs.next())
					userId = rs.getInt(1);
				HttpSession session = request.getSession();
				session.setAttribute("currentUser", username);
				session.setAttribute("currentId", userId);
				response.sendRedirect("Home.jsp");
			}

			con.close();
		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
