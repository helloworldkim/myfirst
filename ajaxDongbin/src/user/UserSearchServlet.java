package user;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserSearchServlet
 */
@WebServlet("/UserSearchServlet")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userName = request.getParameter("userName");
		response.getWriter().write(getJSON(userName));
		
	}
	//json형식으로 데이터를 보내는 자바 메서드
	public String getJSON(String userName) {
		if(userName==null) userName="";
		StringBuffer result = new StringBuffer("");//공백문자삽입
		result.append("{\"result\":[");
		UserDAO userDAO = new UserDAO();
		ArrayList<User> userList = userDAO.search(userName); //userName를 받아서 list를 반환하는 메서드
		for(int i=0; i<userList.size(); i++) {
			result.append("[{\"value\": \""+userList.get(i).getUserName()+"\"},");
			result.append("{\"value\": \""+userList.get(i).getUserAge()+"\"},");
			result.append("{\"value\": \""+userList.get(i).getUserGender()+"\"},");
			result.append("{\"value\": \""+userList.get(i).getUserEmail()+"\"}]");
			if(i != userList.size()-1) result.append(",");
		}
		result.append("]}");
		return result.toString();
	}
}
