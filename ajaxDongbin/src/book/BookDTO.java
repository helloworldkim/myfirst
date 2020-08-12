package book;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookDTO {
	
	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public BookDTO() {
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
	//책이름으로 추천
	public String sugguestbyName(String bookName) {
		String sql= "select DISTINCT bookName from book where bookname like ?";
		StringBuffer abc = new StringBuffer("");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bookName+"%"); //축구의역사 면 축%? 으로 시작하는 단어를 추천해야함
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				abc.append(rs.getString(1)+","); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return abc.toString();
	}
	//출판사로 추천
	public String sugguestbyPublisher(String publisher) {
		String sql= "select DISTINCT publisher from book where publisher like ?";
		StringBuffer abc = new StringBuffer("");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, publisher+"%"); //축구의역사 면 축%? 으로 시작하는 단어를 추천해야함
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				abc.append(rs.getString(1)+","); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return abc.toString();
	}
	public ArrayList<Book> searchbyName(String bookName) {
		String sql= "select * from book where bookname like ?";
				ArrayList<Book> bookList = new ArrayList<Book>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+bookName+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getString(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
				bookList.add(book);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bookList;
	}
	
	public ArrayList<Book> searchbyId(int bookId) {
		String sql= "select * from book where bookid=?";
				ArrayList<Book> bookList = new ArrayList<Book>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bookId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getString(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
				bookList.add(book);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bookList;
	}
	public ArrayList<Book> searchbyPublisher(String publisher) {
		String sql= "select * from book where publisher like ?";
				ArrayList<Book> bookList = new ArrayList<Book>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+publisher+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getString(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
				bookList.add(book);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bookList;
	}
	public ArrayList<Book> searchbyPrice(int price) {
		String sql= "select * from book where price=?";
				ArrayList<Book> bookList = new ArrayList<Book>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, price);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getString(1));
				book.setBookName(rs.getString(2));
				book.setPublisher(rs.getString(3));
				book.setPrice(rs.getInt(4));
				bookList.add(book);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bookList;
	}
	

}
