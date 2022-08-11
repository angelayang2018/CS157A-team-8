

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class DeleteUser
 */
@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public DeleteUser() {
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

			String userId = request.getParameter("delete");
			String username = "";
			
			//get username
			String query = "SELECT username from Users WHERE userid = '"+ userId + "';";
			
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next()) {
				username = rs.getString(1);	
			}
		
			
			query = "SELECT * FROM Products WHERE sellerName = '" + username +"';";
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				int productID = rs.getInt(1);
				Statement productStmt = con.createStatement();
				String update = "DELETE FROM Products WHERE product_id = '"+ productID +"';";
				
				productStmt.executeUpdate(update);
				
				update = "DELETE FROM CartItem WHERE productid = '"+ productID + "';";
				
				productStmt.executeUpdate(update);
				
				update = "DELETE FROM Reviews WHERE productId = '"+ productID + "';";
				productStmt.executeUpdate(update);
			}
			
			String update = "DELETE FROM Users WHERE userid = '"+ userId+ "';";
			stmt.executeUpdate(update);
			
			response.sendRedirect("Admin.jsp");


		} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("Admin.jsp");
			dispatcher.forward(request, response);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
