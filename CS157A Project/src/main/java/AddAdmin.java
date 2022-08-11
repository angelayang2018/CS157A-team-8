

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.sql.*;

/**
 * Servlet implementation class AddAdmin
 */
@WebServlet("/AddAdmin")
public class AddAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public AddAdmin() {
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

			int userId = Integer.parseInt(request.getParameter("userid"));
			int permission = Integer.parseInt(request.getParameter("permission"));

			
			Statement stmt = con.createStatement();
			String query = "SELECT * FROM Users WHERE userid = '"+ userId+"';";
			ResultSet rs = stmt.executeQuery(query);
			
			if(!rs.isBeforeFirst() ) {
				dispatcher = request.getRequestDispatcher("Admin.jsp");
				request.setAttribute("status", "failed");
				dispatcher.forward(request, response);
			}else if(permission != 2 && permission != 1){
				dispatcher = request.getRequestDispatcher("Admin.jsp");
				request.setAttribute("status", "failedPermission");
				dispatcher.forward(request, response);
				
			}else {
			dispatcher = request.getRequestDispatcher("Admin.jsp");
			PreparedStatement ps=con.prepareStatement("INSERT INTO Admin (userId, permission) VALUES(?,?)");
			ps.setInt(1,userId);
			ps.setInt(2, permission);
			ps.executeUpdate();
			ps.close();
			dispatcher.forward(request, response);

		}} catch (SQLException e) {
			System.out.println("SQLException caught: " + e.getMessage());
			dispatcher = request.getRequestDispatcher("Admin.jsp");
			request.setAttribute("status", "failedUnknown");
			dispatcher.forward(request, response);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
