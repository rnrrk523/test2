<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>회원 가입</h1>
	<form action="joinAction.jsp" method="post">
		ID : <input type="text" name="newId"/><br/>
		PW : <input type="password" name="newPw"/><br/>
		NAME : <input type="text" name="newName"/>
		<input type="submit" value="작성완료"/>
	</form>
</body>
</html>