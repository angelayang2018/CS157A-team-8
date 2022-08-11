
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
		String productId = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db, "root", "mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");
			Statement stmt = con.createStatement();

			// get user id
			HttpSession session = request.getSession();
			int userId = (int) session.getAttribute("currentId");
			

			//get quantity
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			// get shopping cart id
			String selectSql = "SELECT shopCartId FROM ShoppingCart where userid ='" + userId + "';";
			ResultSet rs = stmt.executeQuery(selectSql);
			int cartId = 0;
			if (rs.next())
				cartId = rs.getInt(1);

			// get product id
			productId = request.getParameter("productId");
			
			selectSql = "SELECT quantity FROM Products WHERE product_id = '"+ productId +"';";
			rs = stmt.executeQuery(selectSql);
			int totalQuantity = 0;
			if(rs.next()) {
				totalQuantity = rs.getInt(1);
			}
			System.out.println("totalQuantity" + totalQuantity);
			
			if(totalQuantity - quantity >= 0) {
			//get price of product
			selectSql = "SELECT price FROM Products where product_id ='" + productId + "';";
			rs = stmt.executeQuery(selectSql);
			int price = 0;
			if (rs.next())
				price = rs.getInt(1);
			// add to cartItem with shopping id and product id
			String insertSql = "INSERT INTO CartItem(productid, cartid, quantity, price) VALUES('" + productId + "', '" + cartId
					+ "', '" + quantity + "', '" + quantity * price + "');";
			stmt.executeUpdate(insertSql);
			
			String updateSql = "UPDATE Products SET quantity = quantity - " + quantity + " WHERE product_id = '" + productId + "';";
			stmt.executeUpdate(updateSql);
			
			dispatcher = request.getRequestDispatcher("/ProductDetails.jsp?productId=" + productId);
			request.setAttribute("statusReview", "success");
			dispatcher.forward(request, response);

			con.close();
		}else {
			dispatcher = request.getRequestDispatcher("/ProductDetails.jsp?productId=" + productId);
			request.setAttribute("statusReview", "failedCart");
			dispatcher.forward(request, response);
			
		}
			} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("/ProductDetails.jsp?productId=" + productId);
			request.setAttribute("statusReview", "failedCart");
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
