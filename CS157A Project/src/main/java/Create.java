import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class Create
 */
@WebServlet("/Create")
public class Create extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String db = "weed";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root", "mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");
			Statement stmt = con.createStatement();

			String title = request.getParameter("product_title");
			String description = request.getParameter("product_description");
			String quantity = request.getParameter("quantity");
			String price = request.getParameter("price");
			String category = request.getParameter("category");

			String insertSql = "INSERT INTO Products (title, description, quantity, price, category) VALUES ('"
					+ title + "', '" + description + "', '" + quantity + "', '" + price + "', '" + category  + "')";
			stmt.executeUpdate(insertSql);
			
			response.sendRedirect("Products.jsp");

		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
