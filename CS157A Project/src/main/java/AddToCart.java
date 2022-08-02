
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class AddToCart
 */
@WebServlet("/AddToCart")
public class AddToCart extends HttpServlet {
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

			// get user id
			HttpSession session = request.getSession();
			String username = (String) session.getAttribute("currentUser");
			String selectSql = "SELECT userid FROM Users WHERE username = '" + username + "';";
			ResultSet rs = stmt.executeQuery(selectSql);
			int userId = 0;
			if (rs.next())
				userId = rs.getInt(1);

			//get quantity
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			// get shopping cart id
			selectSql = "SELECT shopCartId FROM ShoppingCart where userid ='" + userId + "';";
			rs = stmt.executeQuery(selectSql);
			int cartId = 0;
			if (rs.next())
				cartId = rs.getInt(1);

			// get product id
			String productId = request.getParameter("productId");
			// add to cartItem with shopping id and product id
			String insertSql = "INSERT INTO CartItem(productid, cartid, quantity) VALUES('" + productId + "', '" + cartId
					+ "', '" + quantity + "');";
			stmt.executeUpdate(insertSql);
			
			String updateSql = "UPDATE Products SET quantity = quantity - " + quantity + " WHERE product_id = '" + productId + "';";
			stmt.executeUpdate(updateSql);
			
			dispatcher = request.getRequestDispatcher("/ProductDetails.jsp?productId=" + productId);

			dispatcher.forward(request, response);

			con.close();
		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
