package book;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SearchSuggestServlet")
public class SearchSuggestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String inputvalue = request.getParameter("inputvalue"); //inputbox의 value값
		String target = request.getParameter("bookTarget"); //bookId,bookName,publisher,price
		
		BookDTO bookDTO = new BookDTO();
		if(target.equals("bookName")) {
			if(inputvalue==null)inputvalue="";
			String list= bookDTO.sugguestbyName(inputvalue);
			response.getWriter().write(list);
		}else if(target.equals("publisher")) {
			if(inputvalue==null)inputvalue="";
			String list= bookDTO.sugguestbyPublisher(inputvalue);
			response.getWriter().write(list);
		}
	
		
	}
	
	public String getJSON(ArrayList<Book> bookList) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		for(int i=0; i<bookList.size(); i++) {
			result.append("[{\"value\":\""+bookList.get(i).getBookName()+"\"}]");
			if(i != bookList.size()-1) result.append(",");
		}
		result.append("]}");
		return result.toString();
		
	}

	

}
