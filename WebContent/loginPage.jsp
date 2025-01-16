<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		$(function() {
			$("#joinBtn").click(function() {
				location.href = 'joinPage.jsp';
			})
		})
	</script>
</head>
<body>
	<form action="loginAction.jsp" method="post">
		ID : <input type="text" name="id"/><br/>
		PW : <input type="password" name="pw"/><br/>
		<input type="submit" value="로그인"/><br/>
		<input type="button" id="joinBtn" value="회원가입"/><br/>
	</form>
</body>
</html>