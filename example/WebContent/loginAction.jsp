<%@page import="user.User"%>
<%@page import="user.UserDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<jsp:useBean id="user" class="user.User" scope="page"></jsp:useBean>
	 <jsp:setProperty property="userId" name="user"/>
	 <jsp:setProperty property="userPassword" name="user"/>
	 
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
		script.println("alert('이미 로그인 되어있습니다')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		if (user.getUserId() == null || user.getUserPassword() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('입력이 안 된 사항이 있습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else{
					UserDAO userDAO = new UserDAO(); 
					int result = userDAO.login(user.getUserId(), user.getUserPassword());
					if(result==1){
						PrintWriter script = response.getWriter();
						session.setAttribute("userId", user.getUserId());
						script.println("<script>");
						script.println("alert('로그인에 성공하셨습니다')");
						script.println("history.back()");
						script.println("</script>");
					}else if(result==0){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('비밀번호가 틀립니다')");
						script.println("history.back()");
						script.println("</script>");
					}else if(result==-1){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('아이디가 중복되었습니다')");
						script.println("history.back()");
						script.println("</script>");
					}else{
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('정상적이지 못한 접근입니다')");
						script.println("history.back()");
						script.println("</script>");
					}

				}
	}
	



%>
</body>
</html>