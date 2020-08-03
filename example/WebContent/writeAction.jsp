<%@page import="bbs.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"></jsp:useBean>
<jsp:setProperty property="bbsTitle" name="bbs" />
<jsp:setProperty property="bbsContent" name="bbs"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String userId =null;
	//로그인이 되어있는경우 세션값 대입
	if(session.getAttribute("userId") != null){
		userId =(String)session.getAttribute("userId"); 
	}
	
	if(userId==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인하셔야 글쓰기가 가능합니다')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}//로그인 한 경우 글쓰기가 가능하도록!
	else{//작성안된부분이 있는경우 되돌아가기
		if(bbs.getBbsTitle()==null || bbs.getBbsContent() ==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
		}else{
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), bbs.getBbsContent(), userId);
			//write함수가 비정상적으로 종료될때 -1이 반환될예정
			if(result== -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('db입력오류')");
				script.println("history.back()");
				script.println("</script>");
			}//정상적인경우
			else{
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