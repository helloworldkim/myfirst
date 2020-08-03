<%@page import="bbs.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		
		String userId = null;
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}
		BbsDAO bbsDAO = new BbsDAO(); 
		
		String bbsId = null;
		if(request.getParameter("bbsId")!=null) {
			bbsId=request.getParameter("bbsId");
		}
		
		String commentContent=null;
		if(request.getParameter("commentContent")!=null) {
			commentContent = request.getParameter("commentContent");
		}
		
		
		if(userId==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하셔야 코멘트 작성이 가능합니다')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}//로그인 한 경우 코멘트가 가능하도록!
		else{//작성안된부분이 있는경우 되돌아가기
			if(commentContent==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용을 입력해주세요.')");
			script.println("history.back()");
			script.println("</script>");
			}else{//로그인했고 모두입력 완료했을때 commentwrite메서드 시행
				int result = bbsDAO.commentWrite(userId, bbsId, commentContent);
				if(result==-1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비정상적인 오류가 발생하였습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 작성 완료')");
				script.println("location.href='bbs'");
				script.println("</script>");
			
			}
		}
	}
%>

</body>
</html>