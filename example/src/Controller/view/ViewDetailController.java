package Controller.view;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bbs.Bbs;
import bbs.BbsDAO;

@WebServlet("/view")
public class ViewDetailController extends HttpServlet {
	 
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		HttpSession session = request.getSession();
		 String userId =null; 
		 if(session.getAttribute("userId") !=null){ 
			 userId=(String)session.getAttribute("userId"); 
		 }
		 
		 
		 String bbsId=null; 
		 if(request.getParameter("bbsId")!=null){
			 bbsId =request.getParameter("bbsId"); 
		}
		 
		if(bbsId==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다'))");
			script.println("history.back()");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsId);
		Bbs nextBbs = new BbsDAO().getNextBbs(bbsId);
		Bbs prevBbs = new BbsDAO().getPrevBbs(bbsId);
		String bbsUserId = bbs.getbbsUserId();
		String bbsTitle = bbs.getBbsTitle();
		String bbsDate = bbs.getBbsDate();
		String bbsContent = bbs.getBbsContent();
		int bbsHit =  bbs.getBbsHit();
		bbsId = bbs.getBbsId();
		
		request.setAttribute("bbsUserId", bbsUserId);
		request.setAttribute("bbsTitle", bbsTitle);
		request.setAttribute("bbsDate", bbsDate);
		request.setAttribute("bbsContent", bbsContent);
		request.setAttribute("bbsId", bbsId);
		request.setAttribute("bbsHit", bbsHit);
		
		request.setAttribute("nextBbs", nextBbs);
		request.setAttribute("prevBbs", prevBbs);
		
		request.getRequestDispatcher("./view.jsp").forward(request, response);
	}
}
