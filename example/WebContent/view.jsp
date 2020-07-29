<%@page import="bbs.Bbs"%>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- <jsp:useBean id="bbs" class="bbs.Bbs" scope="page"></jsp:useBean>
<jsp:setProperty property="bbsTitle" name="bbs"/>
<jsp:setProperty property="bbsContent" name="bbs"/> --%>
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
	
	<a class="btn btn-primary" href="login.jsp">로그인</a>
	<a class="btn btn-primary" href="logoutAction.jsp">로그아웃</a>
	
	<div class="container">
		<div class="row">
		<table class="table" style="text-align: center">
			<thead>
				<tr>
					<th colspan="3" style="text-align: center; border: 1px solid black">목록</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<%-- <td>글번호<br><%=request.getAttribute("bbsId")%></td> --%>
					<td>글번호<br>${bbsId}</td>
				</tr>
				<tr>
					<%-- <td>조회수<br><%=request.getAttribute("bbsHit")%></td> --%>
					<td>조회수<br>${bbsHit}</td>
				</tr>
				<tr>
				<%-- 	<td>작성자<br><%=request.getAttribute("bbsUserId")%></td> --%>
					<td>작성자<br>${bbsUserId}</td>
				</tr>
				<tr>
					<%-- <td>게시글<br><%=request.getAttribute("bbsTitle")%></td> --%>
					<td>게시글<br>${bbsTitle}</td>
				</tr>
				<tr>
				<%-- 	<td>작성시간<br><%=request.getAttribute("bbsDate")%></td> --%>
						<c:set var="date" value="${bbsDate}" scope="page"></c:set>
						<td>${fn:substring(date,0,11)} ${fn:substring(date,11,13)}시 ${fn:substring(date,14,16)}분</td>
					<%-- <td>작성시간<br>${bbsDate}</td> --%>
				</tr>
				<tr>			
				<%-- <td colspan="2" style="min-height: 200px; text-align: left;"><%=request.getAttribute("bbsContent")%></td> --%>
					<td colspan="2" style="min-height: 200px; text-align: left;">${bbsContent}</td>

				</tr>
				<tr>			
					<td colspan="2" style="min-height: 100px; text-align: left;"><a href="view?bbsId=${nextBbs.bbsId}">다음글 : ${nextBbs.bbsTitle}</a></td>
				</tr>
				<tr>			
					<td colspan="2" style="min-height: 100px; text-align: left;"><a href="view?bbsId=${prevBbs.bbsId}">이전글 : ${prevBbs.bbsTitle}</a></td>
				</tr>
			</tbody>
			</table>
		<a href="update.jsp" class="btn btn-primary">수정</a>
		<a href="deleteAction.jsp?bbsId=${bbsId}" onclick="confirm('정말로 삭제하시겠습니까?')" class="btn btn-primary">삭제</a>
		<a href="bbs" class="btn btn-primary">게시판</a>
		<a href="commentWrite.jsp?bbsId=${bbsId}" class="btn btn-primary">코멘트작성하기</a>
		</div>
	</div>
	
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
	
</body>
</html>
