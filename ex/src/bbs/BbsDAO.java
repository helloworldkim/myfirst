package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bbs.bbscomment.Comment;

public class BbsDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//인스턴스 생성때 커넥션생성
	public BbsDAO() {
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
	public int write(String bbsTitle, String bbsContent,String userId) {
		String sql = "insert into bbs(bbsid, bbstitle,bbscontent,bbsdate,bbsUserId,bbsHit) values(bbs_seq.nextval,?,?,sysdate,?,0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setString(3, userId);
			return pstmt.executeUpdate(); //성공적으로 insert되면 양수반환
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;//db오류
		
	}
	//총 게시물 갯수를 구하는 함수
	public int totalContent() {
		String sql = "select count(*) from bbs";
		try {
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				//값이 있으면 그 값을 반환
			return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//db오류
	}
	//특정 유저의 게시물의 수를 구하는 메서드
	public int totalMyContent(String userId) {
		String sql = "select count(*) from bbs where bbsUserId=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				//값이 있으면 그 값을 반환
			return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;//db오류
	}
		//검색된 게시물 갯수를 구하는 함수
	public int searchedTotalContent(String field, String query) {
			String sql = "select count(*) from bbs where "+field+"like ?";
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%"+query+"%");
				rs= pstmt.executeQuery();
				if(rs.next()) {
					//값이 있으면 그 값을 반환
				return rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;//db오류
}	
	public List<Comment> getList(){
		return getList(1, "bbsTitle", "");
	}
	//검색전 모든 게시물을 가져오는 메서드
	public List<Comment> getList(int pageNumber){
		
		return getList(pageNumber, "bbsTitle", "");
	}
	
	//검색전 모든 게시물을 가져오는 메서드
		public List<Comment> getList(int pageNumber, String field, String query){
				
				/*
				 * String sql
				 * ="SELECT * FROM (SELECT b.*, Row_Number() OVER (ORDER BY bbsid) MyRow FROM bbs b where "
				 * +field+" like ?) WHERE MyRow BETWEEN ? AND ?";
				 */
			//이대로하면 num이라는 순서를 붙인게 하나 더 나오니까 조회할것을 따로따로 적어줌
			//String sql = "select * from (select rownum num, N.* from(select * from bbs where "+field+" like ? order by bbsdate desc) N) WHERE NUM BETWEEN ? AND ?";
			//comment를 포함안한 쿼리문
			//String sql = "select bbsid,bbstitle,bbsdate,bbsUserId,bbshit from (select rownum num, N.* from(select * from bbs where "+field+" like ? order by bbsdate desc) N) WHERE NUM BETWEEN ? AND ?";
			//comment까지 포함한 view를 가지고 만든 쿼리문 bbscontent는 제거함 내용을 안보여주는 list로 변경 코멘트 갯수를 찾는 countbbsid 추가함
			String sql = "select bbsid,bbstitle,bbsdate,bbsUserId,bbshit,countBbsId from (select rownum num, N.* from(select * from bbsview where "+field+" like ? order by bbsdate desc) N) WHERE NUM BETWEEN ? AND ?";
				ArrayList<Comment> list = new ArrayList<Comment>();
				BbsDAO bbsDAO = new BbsDAO();
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+query+"%");
					pstmt.setInt(2, ((pageNumber-1)*10)+1);
					pstmt.setInt(3, pageNumber*10);
					rs=pstmt.executeQuery();
					while(rs.next()) {
						Comment comment = new Comment();
						comment.setBbsId(rs.getString(1));
						comment.setBbsTitle(rs.getString(2));
						comment.setBbsDate(rs.getString(3));
						comment.setbbsUserId(rs.getString(4));
						comment.setBbsHit(rs.getInt(5));
						comment.setCountBbsId(rs.getInt(6));
						list.add(comment);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return list;
			}
		//검색전 모든 게시물을 가져오는 메서드
		public List<Comment> getMyList(int myPageNumber, String field, String query, String userId){
				/*
				 * String sql
				 * ="SELECT * FROM (SELECT b.*, Row_Number() OVER (ORDER BY bbsid) MyRow FROM bbs b where "
				 * +field+" like ?) WHERE MyRow BETWEEN ? AND ?";
				 */
			//이대로하면 num이라는 순서를 붙인게 하나 더 나오니까 조회할것을 따로따로 적어줌
			//String sql = "select * from (select rownum num, N.* from(select * from bbs where "+field+" like ? order by bbsdate desc) N) WHERE NUM BETWEEN ? AND ?";
			String sql = "select bbsid,bbstitle,bbsdate,bbsUserId,bbshit,countBbsId from (select rownum num, N.* from(select * from bbsview where "+field+" like ? and bbsuserId=? order by bbsdate desc) N) WHERE NUM BETWEEN ? AND ?";

				ArrayList<Comment> myList = new ArrayList<Comment>();
				try {
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, "%"+query+"%");
					pstmt.setString(2, userId);
					pstmt.setInt(3, ((myPageNumber-1)*10)+1);
					pstmt.setInt(4, myPageNumber*10);
					
					rs=pstmt.executeQuery();
					while(rs.next()) {
						Comment comment = new Comment();
						comment.setBbsId(rs.getString(1));
						comment.setBbsTitle(rs.getString(2));
						comment.setBbsDate(rs.getString(3));
						comment.setbbsUserId(rs.getString(4));
						comment.setBbsHit(rs.getInt(5));
						comment.setCountBbsId(rs.getInt(6));
						myList.add(comment);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				return myList;
			}
	
	
	//view 페이지에서 하나의 게시물을 가져오는 메서드
	public Bbs getBbs(String bbsId) {
		String sql = "select * from bbs where bbsid=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsId(rs.getString(1));
				bbs.setBbsTitle(rs.getString(2));
			 	bbs.setBbsContent(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setbbsUserId(rs.getString(5));
				bbs.setBbsHit(rs.getInt(6));
				
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//몇개든 여러개의 comment를 모두 가져오는 메서드
	public List<Comment> getComments(String bbsId) {
		String sql = "select bbsuserid,bbsid,commentdate,commentcontent from bbscomment where bbsid=? order by commentdate";
		ArrayList<Comment> list = new ArrayList<>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comment comment = new Comment();
				comment.setBbsUserId(rs.getString(1));
				comment.setBbsId(rs.getString(2));
				comment.setCommentDate(rs.getString(3));
				comment.setCommentContent(rs.getString(4));
				list.add(comment);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	//다음글을 가져오는 메서드
	public Bbs getNextBbs(String bbsId) {
		
		String sql = "select bbsid,bbstitle from bbs where bbsid = (select bbsid from bbs where bbsdate > (select bbsdate from bbs where bbsid=?) and rownum =1)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsId(rs.getString(1));
				bbs.setBbsTitle(rs.getString(2));
				
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;	
	}
	//이전글을 가져오는 메서드
	public Bbs getPrevBbs(String bbsId) {
		
		String sql = "select bbsid,bbsTitle from (select * from bbs order by bbsdate desc) where bbsdate < (select bbsdate from bbs where bbsid=?) and rownum=1";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsId(rs.getString(1));
				bbs.setBbsTitle(rs.getString(2));
				
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		
	}
	//게시글 삭제시 실행되는 메서드
	public int delete(String bbsId) {
		String sql="delete from bbs where bbsId=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bbsId);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //db오류
	}
	
	public int commentWrite(String bbsuserId, String bbsId, String commentContent) {												
		String sql = "insert into bbscomment(commentId,bbsUserId,bbsId,commentDate,commentContent) values(comment_seq.nextval,?,?,sysdate,?)";
		try {//bbuserid,bbsid,commentcontent
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsuserId);
			pstmt.setString(2, bbsId);
			pstmt.setString(3, commentContent);
			return pstmt.executeUpdate(); //성공적으로 insert되면 양수반환
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;//db오류
		
	}
	//bbsId값을 동일하게 가지는 comment를 찾아서 갯수를 찾는 메서드
	public int commentCount(String bbsId) {
		String sql = "select count(*) from bbscomment where bbsId=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bbsId);
			pstmt.executeQuery();
			if(rs.next()) {
			return rs.getInt(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;//db오류
	}
	
}
