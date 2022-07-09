

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Servlet implementation class Register
 */
@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String db = "weed";
		try { 
			Class.forName("com.mysql.cj.jdbc.Driver");
			java.sql.Connection con; 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"+db, "root", "mrbigbear18!"); 
			System.out.println(db + " database successfully opened. <br>"); 
			Statement stmt=con.createStatement();
			
			String username = request.getParameter("name");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
		}catch(SQLException e) { 
			System.out.println("SQLException caught: " +e.getMessage()); } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 

	}

}
