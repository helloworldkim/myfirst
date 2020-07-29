package Controller.CommentList;

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

@WebServlet("/myCommentList")
public class commentListController extends HttpServlet {
		
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		
		 String bbsId=null; 
		 if(request.getParameter("bbsId")!=null){
			 bbsId =(String)request.getParameter("bbsId"); 
		}
		 
		if(bbsId==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다'))");
			script.println("history.back()");
			script.println("</script>");
		}
		BbsDAO bbsDAO = new BbsDAO();
		


		//list에다가 게시판에있는걸 모두 조회한걸 넣어줌
		//List<Bbs> list = bbsDAO.getList(pageNumber, field, query);
		//기존것 대신 countBbsId가 포함된 comment클래스로 생성된걸 넣어줌
		List<Comment> list = bbsDAO.getComments(bbsId);
	
		
		request.setAttribute("list", list);	

		
		request.getRequestDispatcher("myCommentList.jsp").forward(request, response);
		}
}
