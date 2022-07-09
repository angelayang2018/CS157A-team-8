import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class User {
    Connection con;
    User(Connection con){
        this.con = con;
    }

    static final String DEFAULT_CLASS = "buyer"; // Three classes: buyer, seller, dispenser

    void CreateUser(String username, String email, String password, String firstName, String lastName){
        try {
            String insertSql = "INSERT INTO users (username, email, password, first_name, last_name) "
                    + "VALUES ('" + username + "','" + email + "','" + password + "','" + firstName + "','" + lastName + "')";
            Statement statement = con.createStatement();
            statement.execute(insertSql);
        }
        catch (Exception e){ System.out.println(e);}

    }

    void DeleteUser(String username){
        try {
            String deleteSql = "DELETE FROM users WHERE username = '" + username + "'";
            Statement statement = con.createStatement();
            statement.execute(deleteSql);
        }catch (Exception e) {System.out.println(e);}
    }

    void ChangePassword(String username, String newPassword){
        try {
            String updateSql =  "UPDATE users SET password = '" + newPassword + "' WHERE username = '" + username +"'";;
            Statement statement = con.createStatement();
            statement.execute(updateSql);

        }
        catch (Exception e){ System.out.println(e);}
    }

    void getUser(){}

    void printUsers(){
        try {
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery("select * from users");
            while (rs.next())
                System.out.println(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(3)
                        + " " + rs.getString(4) + " " + rs.getString(5) + " " + rs.getString(6));
        }catch (Exception e) {
            System.out.println(e);
        }
    }

}
