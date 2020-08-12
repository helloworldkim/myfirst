package book;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class BookSearchServlet
 */
@WebServlet("/BookSearchServlet")
public class BookSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String inputvalue = request.getParameter("inputvalue"); //inputbox의 value값
		String target = request.getParameter("bookTarget"); //bookId,bookName,publisher,price
		//String bookName = request.getParameter("bookName");
		//System.out.println(inputvalue);
		//System.out.println(target);
		BookDTO bookDTO = new BookDTO();
		if(target.equals("price")) {
			//기본값 price기준!
			int value= Integer.parseInt(inputvalue);
			if(value<1) value=1;
			ArrayList<Book> bookList = bookDTO.searchbyPrice(value);
			response.getWriter().write(getJSON(bookList));
		}else if(target.equals("bookId")) {
			int value= Integer.parseInt(inputvalue);
			if(value<1) {
				value=1;
			}
			System.out.println(value);
			ArrayList<Book> bookList = bookDTO.searchbyId(value);
			response.getWriter().write(getJSON(bookList));	
		}else if(target.equals("publisher")) {
			if(inputvalue==null)inputvalue="";
			ArrayList<Book> bookList = bookDTO.searchbyPublisher(inputvalue);
			response.getWriter().write(getJSON(bookList));
		}else {
			if(inputvalue==null)inputvalue="";
			ArrayList<Book> bookList = bookDTO.searchbyName(inputvalue);
			response.getWriter().write(getJSON(bookList));
		}
	
		
	}
	
	public String getJSON(ArrayList<Book> bookList) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		for(int i=0; i<bookList.size(); i++) {
			result.append("[{\"value\":\""+bookList.get(i).getBookId()+"\"},");
			result.append("{\"value\":\""+bookList.get(i).getBookName()+"\"},");
			result.append("{\"value\":\""+bookList.get(i).getPublisher()+"\"},");
			result.append("{\"value\":\""+bookList.get(i).getPrice()+"\"}]");
			if(i != bookList.size()-1) result.append(",");
		}
		result.append("]}");
		return result.toString();
		
	}

	

}
