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
	 	<div class="container">
	 		<nav>
	 			<form action="myWriteList?${myPageNumber}" method="get">
	 			<fieldset>
	 				<label class="hidden">검색분류</label>
	 				<select name="f">
	 					<option ${(param.f == "bbsTitle")?"selected":"" } value="bbsTitle">제목</option>
	 					<option ${(param.f == "bbsUserId")?"selected":"" }value="bbsUserId">작성자</option>
	 				</select>
	 				<label class="hidden">검색어</label>
	 				<input type="text" name="q" value="${param.q}"/>
	 				<input class="btn btn-search" type="submit" value="검색"/>	 				
	 			</fieldset>
	 			</form>
	 		</nav>
	 	</div>
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
	 		<a href="myWriteList" class="btn btn-primary pull-right">나의 글 목록</a>
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
						<th style="background-color: #eeeeee; text-align: center;">게시글 제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="l" items="${myList}">
					<tr>
						<td>${l.bbsId}</td>
						<td><a href="view?bbsId=${l.bbsId}">${l.bbsTitle}</a> 
							<a target="_blank" href="myCommentList?bbsId=${l.bbsId}"><span>[${l.countBbsId}]</span></a></td>
						<%-- <td>${l.bbsDate}</td> --%>
						<c:set var="date" value="${l.bbsDate}" scope="page"></c:set>
						<td>${fn:substring(date,0,11)}</td>	
						<td>${l.bbsUserId}</td>
						<td>${l.bbsHit}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	
	<!-------------------------------페이징---------------------------------------------------->
<%-- 	<c:set var="pagePerContent" value="${pagePerContent}"></c:set> --%>
		<!-- 왜인지 모르겠으나 jstl set이 적용이 안됨 -->
		<c:set var="myPageNumber" value="${(empty param.myPageNumber)?1:(param.myPageNumber)}"/>
	<c:set var="startNumber" value="${totalMyPage-(totalMyPage-1)%5}"></c:set>
	<c:set var="lastNumber" value="${lastNumber}"></c:set>
	<div class="container paginationbox">
			<c:if test="${startNumber>1}">
			<a href="myPageNumber=${startNumber-5}" class="btn btn-next btn-primary">이전</a>
			</c:if>
			<c:if test="${startNumber<=1}">
			<span class="btn btn-next btn-primary" onclick="alert('이전페이지가 없습니다')">이전</span>
			</c:if>
			<ul class="pagination">
				<c:forEach var="i" begin="0" end="4">
					<li><a href="?myPageNumber=${startNumber+i}&f=${param.f}&q=${param.q}">${startNumber+i}</a>
				</c:forEach>
			</ul>
			<c:if test="${startNumber+5<lastNumber}">
			<a href="totalMyPage=${startNumber+5}" class="btn btn-next btn-primary">다음</a>
			</c:if>
			<c:if test="${startNumber+5>lastNumber}">
				<span class="btn btn-next btn-primary" onclick="alert('다음페이지가 없습니다')">다음</span>
			</c:if>
	</div>
	
	
	
	
	<%-- <div style="text-align: cetner">총 게시물의 수<%=bbsDAO.totalContent()%></div> --%>
	<div style="text-align: cetner">총 게시물의 수 : ${totalCount}</div>
	<div style="text-align: cetner">나의 게시물의 수 : ${totalMyCount}</div>
	<div style="text-align: cetner">총 페이지 수  : ${totalMyPage}</div>
	<!-- 애니매이션 담당 JQUERY -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- 부트스트랩 JS  -->
	<script src="js/bootstrap.js"></script>
</body>
</html>