<%@page import="bbs.Bbs"%>
<%@page import="java.util.ArrayList"%>
<%@page import="bbs.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>게시판</title>
</head>
<body>
	<div class="container">
	 <nav>
	 	
	 	
	 	
	 	<%-- <c:if test="${session.userId == null}"> --%>
	 	
	 	<c:if test="${sessionScope.userId == null}">
	 	<div>
	 		<a href="login.jsp" class="btn btn-primary pull-right">로그인</a>
	 		<a href="register.jsp" class="btn btn-primary pull-right">회원가입</a>
	 		<a href="main.jsp" class="btn btn-primary pull-right">메인</a>
	 		<a href="bbs" class="btn btn-primary pull-right">게시판</a>
	 		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
	 	</div>
	 	</c:if>
	 	<%-- <c:if test="${session.userId != null}" > --%>
	 	<c:if test="${sessionScope.userId != null}" >
	 	<div>
	 		<a href="logoutAction.jsp" class="btn btn-primary pull-right">로그아웃</a>
	 		<a href="main.jsp" class="btn btn-primary pull-right">메인</a>
	 		<a href="bbs" class="btn btn-primary pull-right">게시판</a>
	 		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
	 	</div>
	 	</c:if>	
	 </nav>
	</div>
	<!-- 게시판 -->
	
	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">게시글 번호</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">코멘트내용</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="l" items="${list}">
					<tr>
						<td>${l.bbsId}</td>
						<c:set var="date" value="${l.commentDate}" scope="page"></c:set>
						<td>${fn:substring(date,0,16)}</td>	
						<td>${l.bbsUserId}</td>
						<td>${l.commentContent}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>


	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>