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
	
	String userId =null;
	if(session.getAttribute("userId") !=null ){
		userId = (String)session.getAttribute("userId");
	}
	if(session.getAttribute("userId")==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하셔야만 게시글 삭제가 가능합니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	String bbsId = null;
	if(request.getParameter("bbsId")!=null){
		bbsId = (String)request.getParameter("bbsId");
	}
	if(bbsId==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비정상적인 접근입니다')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		BbsDAO bbsDAO = new BbsDAO();
		if(userId.equals(bbsDAO.getBbs(bbsId).getbbsUserId())){
			int result = bbsDAO.delete(bbsId);
			if(result==-1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('삭제가 이루어지지 않았습니다')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('정상적으로 삭제되었습니다')");
				script.println("history.back()");
				script.println("</script>");
			}
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('작성자만 삭제할수있습니다')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		
	}
	
%>
</body>
</html>