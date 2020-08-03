<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form action="registerAction.jsp" method="post">
	<table style="border: 1px solid black;">
		<thead>
			<tr>
				<th colspan="3">회원가입 양식</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="userId">아이디</td>
			</tr>
			<tr>
				<td><input type="password" name="userPassword">비밀번호</td>
			</tr>
			<tr>
				<td><input type="text" name="userName">이름</td>
			</tr>
			<tr>
				<td><input type="text" name="userAge">나이</td>
			</tr>
		</tbody>
	</table>
	<input type="submit" value="가입">
	<input type="reset" value="초기화">	
</form>
	<a href="login.jsp">로그인</a>
	<a href="bbs">게시판</a>
	<a href="logoutAction.jsp">로그아웃</a>

</body>
</html>