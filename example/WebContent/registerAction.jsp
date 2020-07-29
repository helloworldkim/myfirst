<%@page import="user.User"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
	 <jsp:setProperty property="userId" name="user"/>
	 <jsp:setProperty property="userPassword" name="user"/>
	 <jsp:setProperty property="userName" name="user"/>
	 <jsp:setProperty property="userAge" name="user"/>
 
<%-- <%
 String userId = request.getParameter("userId");
 String userPassword = request.getParameter("userPassword");
 String userName = request.getParameter("userName");
 String userAge = request.getParameter("userAge");
 	User user = new User();
 	user.setUserId(userId);
 	user.setUserPassword(userPassword);
 	user.setUserName(userName);
 	user.setUserAge(userAge);
 %> --%>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userId =null;
	if(session.getAttribute("userId") !=null){
		userId= (String)session.getAttribute("userId");
	}
	if(userId != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 가입하셨습니다')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		if (user.getUserId() == null || user.getUserPassword() == null || user.getUserName() == null
				|| user.getUserAge()==null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					UserDAO userDAO = new UserDAO(); 
					int result = userDAO.join(user);
					if(result == -1){ 
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('이미 존재하는 아이디 입니다.')");
						script.println("history.back()");
						script.println("</script>");
					}

					//가입성공
					else {
						session.setAttribute("userId", user.getUserId());
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('가입성공하셨습니다')");		
						script.println("location.href = 'register.jsp'");
						script.println("</script>");

					}

				}
	}
	



%>
</body>
</html>