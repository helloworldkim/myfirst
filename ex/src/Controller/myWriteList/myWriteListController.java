package Controller.myWriteList;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bbs.Bbs;
import bbs.BbsDAO;
import bbs.bbscomment.Comment;
@WebServlet("/myWriteList")
public class myWriteListController extends HttpServlet {
			
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		

		HttpSession session = request.getSession();
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		
		if(userId ==null)	{
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인하셔야지만 이용가능합니다')");
			out.println("location.href='bbs'");
			out.println("</script>");
		}else {
			
			BbsDAO bbsDAO = new BbsDAO();
			int totalCount = bbsDAO.totalContent(); //총 게시글 수 
			int totalMyCount = bbsDAO.totalMyContent(userId); //특정유저의 총 게시글 수 
			
			String field_ = request.getParameter("f");
			String query_ = request.getParameter("q");
			String myPageNumber_ = request.getParameter("myPageNumber");
			
			String field = "bbsTitle";
			if(field_ != null && !field_.equals("")) {
				field = field_;
			}
			String query = "";
			if(query_ != null && !query_.equals("")) {
				query = query_;
			}
			int myPageNumber = 1;
			if((myPageNumber_ != null) && !(myPageNumber_.equals(""))) {
				myPageNumber = Integer.parseInt(myPageNumber_);
			}
			
			int totalMyPage; //특정유저의 게시글  페이지 수
			int lastNumber; //마지막페이지 넘버
			if(totalMyCount%10==0) {
				totalMyPage =	totalMyCount/10;
				lastNumber = totalMyPage;
			}else {
				
				totalMyPage =	totalMyCount/10+1;
				lastNumber = totalMyPage;
			}
			
				
			//list에다가 게시판에있는걸 모두 조회한걸 넣어줌 **Comment포함한걸로 변경
			//List<Bbs> myList = bbsDAO.getMyList(myPageNumber, field, query, userId);
			
			List<Comment> myList = bbsDAO.getMyList(myPageNumber, field, query, userId);
			
		
			
			request.setAttribute("myList", myList);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("totalMyCount", totalMyCount);
			request.setAttribute("lastNumber", lastNumber);
			request.setAttribute("totalMyPage", totalMyPage);
			request.setAttribute("userId", userId);
			
			
		
			
			request.getRequestDispatcher("myWriteList.jsp").forward(request, response);
			}
		
		}
		
}
