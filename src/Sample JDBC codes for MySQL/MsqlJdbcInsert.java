import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MsqlJdbcInsert {

	public static void main(String[] args) throws Exception {
		// Connection to MySql
		Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/demo?serverTimezone=UTC", "root", "root");
		
		// Insert row
		java.util.Date now = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(now.getTime());
		String insertSql = "INSERT INTO USER (USERNAME, AGE, CREATED_DATE) "
				          + "VALUES ('Mike Wu', 18, '" + sqlDate + "')";
		Statement statement = connection.createStatement();
		statement.execute(insertSql);
		
		// Query 
		
		String querySql = "SELECT * FROM USER";
		Statement st=connection.createStatement();
		ResultSet rs=st.executeQuery(querySql);
		while(rs.next())
		{
		    // rs.getString(1); //or rs.getString("column name");
			String Fullname = rs.getString("USERNAME");
            int age = rs.getInt("AGE");
            String Date = rs.getString("CREATED_DATE");

            System.out.println(Fullname);
            System.out.println(age);
            System.out.println(Date);
		}
		
		// Close connection
		statement.close();
		rs.close();
		connection.close();
		

	}

}
