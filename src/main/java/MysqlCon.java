
import java.sql.*;
class MysqlCon{
	public static void main(String args[]){
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/LoveAndWeed?autoReconnect=true&useSSL=false","root","$S/ztc*95@$-]tDB");

			User user = new User(con);
			user.CreateUser("SwiftSheng", "Ruijie.Sheng@sjsu.edu", "pswd", "Swift", "Sheng");
			user.CreateUser("SwiftZhang", "Ruijie.Zhang@sjsu.edu", "pswd", "Swift", "Sheng");

			user.printUsers();

			user.DeleteUser("SwiftSheng");
			user.printUsers();

			user.ChangePassword("SwiftZhang", "newpswd");
			user.printUsers();




			con.close();
		}catch(Exception e){ System.out.println(e);}
	}
}
