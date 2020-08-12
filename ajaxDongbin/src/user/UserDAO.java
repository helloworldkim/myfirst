package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class UserDAO {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public UserDAO() {
		try {
			String userid = "madang"; 
		    String userpassword = "madang";
		    String url = "jdbc:oracle:thin:@localhost:1521:xe";
		    
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn= DriverManager.getConnection(url,userid,userpassword);
			
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	
	public ArrayList<User> search(String userName) {
		String sql= "select * from ajax where username like ?";
				ArrayList<User> userList = new ArrayList<User>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+userName+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				User user = new User();
				user.setUserName(rs.getString(1));
				user.setUserAge(rs.getInt(2));
				user.setUserGender(rs.getString(3));
				user.setUserEmail(rs.getString(4));
				userList.add(user);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userList;
	}
	

}
