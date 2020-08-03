package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDAO {
	
	
    
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//인스턴스 생성때 커넥션생성
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
	public int login(String userId, String userPassword) {
		String sql = "select userPassword from newuser where userId=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs= pstmt.executeQuery();
			
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1;//성공시 1
				}else {
					return 0; //비밀번호 불일치시 0
				}
			}
			return -1;//id없음 1
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //db오류 -2
	}
	
	public int join(User user) {
		
		String sql = "insert into newuser values(?,?,?,?)";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserAge());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return -1;
		
	}
}
