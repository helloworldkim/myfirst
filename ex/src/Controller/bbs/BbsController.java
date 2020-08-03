package Controller.bbs;

import java.io.IOException;
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

@WebServlet("/bbs")
public class BbsController extends HttpServlet {
		
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		
		BbsDAO bbsDAO = new BbsDAO();
		int totalCount = bbsDAO.totalContent(); //총 게시글 수 
//		CommentDAO commentDAO = new CommentDAO();
		/*
		 int pagePerContent = 10; //리스트에 표시될 게시물 갯수
		 if(request.getParameter("pagePerContent") != null &&
		 !(request.getParameter("pagePerContent")=="")) { pagePerContent =
		 Integer.parseInt(request.getParameter("pagePerContent")); }
		 */
		
		String field_ = request.getParameter("f");
		String query_ = request.getParameter("q");
		String pageNumber_ = request.getParameter("pageNumber");
		
		String field = "bbsTitle";
		if(field_ != null && !field_.equals("")) {
			field = field_;
		}
		String query = "";
		if(query_ != null && !query_.equals("")) {
			query = query_;
		}
		int pageNumber = 1;
		if(pageNumber_ != null && !pageNumber_.equals("")) {
			pageNumber = Integer.parseInt(pageNumber_);
		}
		
	
		
		/*
		 * int pageNumber = 1; if(request.getParameter("pageNumber")!=null &&
		 * !(request.getParameter("pageNumber")=="")) { pageNumber =
		 * Integer.parseInt(request.getParameter("pageNumber")); }
		 */
		
		/*1~10 page1*10=10 
		  11~20 page2*10=20
		  21~30 page3*10=30
		  31~40 page4*10=40;
			 = startRownum;
		 1~5 page1*5 = 5;
		 6~10 page2*5 =10;
		 11~15 page3*5=15;
		 16~20 page4*5=20;
		startnum (pagenumber*pagepercontent+1) - pagepercontent
		lastnum pargenumber*pagepercontent
		int startRownum = (pageNumber*pagePerContent)-pagePerContent+1;	
		int lastRownum = pageNumber*pagePerContent;
		*/
		int totalPage; //총 페이지 수
		int lastNumber; //마지막페이지 넘버
		if(totalCount%10==0) {
			totalPage =	totalCount/10;
			lastNumber = totalPage;
		}else {
			
			totalPage =	totalCount/10+1;
			lastNumber = totalPage;
		}
		
			
		//list에다가 게시판에있는걸 모두 조회한걸 넣어줌
		//List<Bbs> list = bbsDAO.getList(pageNumber, field, query);
		//기존것 대신 countBbsId가 포함된 comment클래스로 생성된걸 넣어줌
		List<Comment> list = bbsDAO.getList(pageNumber, field, query);
	
		
		request.setAttribute("list", list);
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("lastNumber", lastNumber);
		
		
	
		
		request.getRequestDispatcher("bbs.jsp").forward(request, response);
		}
}
