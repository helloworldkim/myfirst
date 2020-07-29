<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인페이지</title>
</head>
<body>
<form action="loginAction.jsp" method="post">
	<table style="border: 1px solid black;">
		<thead>
			<tr>
				<th colspan="3">로그인 양식</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="userId">아이디</td>
			</tr>
			<tr>
				<td><input type="password" name="userPassword">비밀번호</td>
			</tr>
		</tbody>
	</table>
	<input type="submit" value="로그인">
	<input type="reset" value="초기화">	
</form>
	<a href="register.jsp">회원가입</a>
	<a href="write.jsp">글쓰기</a>
	<a href="bbs">게시판</a>
</body>
</html>