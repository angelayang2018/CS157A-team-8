

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;



/**
 * Servlet implementation class Checkout
 */
@WebServlet("/Checkout")
public class Checkout extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Checkout() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String db = "weed";
		RequestDispatcher dispatcher = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			java.sql.Connection con;
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db + "?useSSL = false", "root",
					"mrbigbear18!");
			System.out.println(db + " database successfully opened. <br>");

			HttpSession session = request.getSession();
			int userId = (int) session.getAttribute("currentId");
			
			Timestamp sqlDate = new Timestamp(System.currentTimeMillis());
			System.out.println(sqlDate);
			PreparedStatement ps=con.prepareStatement("INSERT INTO ORDERS (userid, lastUpdated) VALUES(?,?)");
			ps.setInt(1,userId);
			ps.setTimestamp(2, sqlDate);
			ps.executeUpdate();
			ps.close();
			
			
			String selectSql = "SELECT orderid FROM Orders WHERE userid ='" + userId + "' ORDER BY lastUpdated DESC LIMIT 1;";
			Statement stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(selectSql);
			int orderid = 0;
			if(rs.next()) {
				orderid = rs.getInt(1);
			}
			

			selectSql = "SELECT shopCartId FROM ShoppingCart WHERE userid ='" + userId + "';";
			rs = stmt.executeQuery(selectSql);
			int cartId = 0;
			if(rs.next()) {
				cartId = rs.getInt(1);
			}
			
			
			String insertSql = "INSERT INTO OrderItem(orderId, productId, quantity, price) SELECT '" + orderid + "', productId, quantity, price FROM CartItem WHERE cartid ='"+ cartId + "';";
			stmt.executeUpdate(insertSql);
			
			insertSql = "DELETE FROM CartItem WHERE cartid='" + cartId + "'";
			stmt.executeUpdate(insertSql);
			
			
			dispatcher = request.getRequestDispatcher("Orders.jsp");
			dispatcher.forward(request, response);

			// response.sendRedirect("SignUp.jsp");

		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("Orders.jsp");
			System.out.println("failed");
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
