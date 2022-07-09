
import java.sql.*;
class MysqlCon{
	public static void main(String args[]){
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Yang?autoReconnect=true&useSSL=false","root","mrbigbear18!");
			//here Yang is database name, root is username and mrbigbear18! is the password
			Statement stmt=con.createStatement();
			ResultSet rs=stmt.executeQuery("select * from Student");
			while(rs.next())
				System.out.println(rs.getInt(1)+" "+rs.getString(2)+" "+rs.getString(3));
			con.close();
		}catch(Exception e){ System.out.println(e);}
	}
}
