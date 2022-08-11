

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class UpdateCart
 */
@WebServlet("/UpdateCart")
public class UpdateCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public UpdateCart() {
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
			Statement stmt = con.createStatement();

			
			HttpSession session = request.getSession();
			String productId = request.getParameter("delete");
			int cartId = 0;
			if(session.getAttribute("currentUser") != null) {
			String querySql = "SELECT shopCartId FROM ShoppingCart WHERE userid = '"+ (int)session.getAttribute("currentId")+"';";
			ResultSet rs = stmt.executeQuery(querySql);
			if(rs.next()) {
				cartId = rs.getInt(1);
			}
			querySql = "SELECT quantity from CartItem WHERE cartId = '"+ cartId +"' AND productId = '"+ productId+"';";
			rs = stmt.executeQuery(querySql);
			int quantity = 0;
			if(rs.next()) {
				quantity = rs.getInt(1);
			}
			
			String updateSql = "UPDATE Products SET quantity = quantity + " + quantity + " WHERE product_id = '"+ productId +"';";
			stmt.executeUpdate(updateSql);
			
			updateSql = "DELETE FROM CartItem WHERE cartId = '"+ cartId +"' AND productId = '"+ productId+"';";
			stmt.executeUpdate(updateSql);
			
			
			dispatcher = request.getRequestDispatcher("ShoppingCart.jsp");
			dispatcher.forward(request, response);

			// response.sendRedirect("SignUp.jsp");

		}} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("ShoppingCart.jsp");
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
