
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class UpdateProduct
 */
@WebServlet("/UpdateProduct")
public class UpdateProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public UpdateProduct() {
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

			String saveButton = request.getParameter("save");
			String deleteButton = request.getParameter("delete");

			if (saveButton != null) {
				String id = request.getParameter("check");
				System.out.println("id" + id);
				String productID = request.getParameter("productId" + id);
				String title = request.getParameter("title" + id);
				String description = request.getParameter("description" + id);
				String quantity = request.getParameter("quantity" + id);
				String price = request.getParameter("price" + id);
				String category = request.getParameter("category" + id);
				
				

				String updateSql = "UPDATE Products SET title = '" + title + "', description = '" + description
						+ "', quantity= '" + quantity + "', price = '" + price + "', category = '" + category
						+ "' WHERE product_id = '" + productID + "';";

				dispatcher = request.getRequestDispatcher("/YourProduct.jsp");
				// returns the number of rows affected
				int rows = stmt.executeUpdate(updateSql);

				if (rows > 0) {
					request.setAttribute("status", "success");

				} else
					request.setAttribute("status", "failed");

				dispatcher.forward(request, response);
			}else if (deleteButton != null) {
				String id = request.getParameter("delete");

				String deleteSql = "DELETE FROM Products WHERE product_id = '" + id + "';" ;
				stmt.executeUpdate(deleteSql);
				
				response.sendRedirect("YourProduct.jsp");
			}else {
				dispatcher = request.getRequestDispatcher("/YourProduct.jsp");
				request.setAttribute("status", "failed");
				dispatcher.forward(request, response);
			}


		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("/YourProduct.jsp");
			request.setAttribute("status", "failed");
			dispatcher.forward(request, response);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
