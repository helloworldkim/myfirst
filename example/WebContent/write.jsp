<%@ page language="java" contentType="text/html; charset=UTF-8"

	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" href="css/bootstrap.css">

<title>jsp 게시판 웹사이트</title>

</head>

<body>
<%
	String userId =null;
	if(session.getAttribute("userId") !=null){
		userId= (String)session.getAttribute("userId");
	}
	if(userId == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인한 회원만 글쓰기가 가능합니다')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		//실행할부분
	}
%>
<%
	if(userId==null){
%>
	<a href="login.jsp">로그인</a>
	<%} else{ %>
	<a href="bbs">게시판</a>
	<a href="logoutAction.jsp">로그아웃</a>
	<form action="writeAction.jsp" method="post">
		<table class="table" style="text-align: center">
			<thead>
				<tr>
					<th colspan="2" style="text-align: center; border: 1px solid black">글쓰기 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" name="bbsTitle" placeholder="게시글 제목"></td>
				</tr>
			</tbody>
		</table>
		<textarea class="form-control" style="text-align: left; border: 1px solid black; 
		height:350px"name="bbsContent" placeholder="게시글 내용" maxlength="2048"></textarea>
		<input type="submit" class="btn btn-primary" value="작성">
		<input type="reset" class="btn btn-primary" value="초기화">
		<a href="bbs" class="btn btn-primary">게시판</a>
	</form>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
	<%} %>
</body>
</html>
