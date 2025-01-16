<%@page import="Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("newId");
	String pw = request.getParameter("newPw");
	String name = request.getParameter("newName");
	
	MemberDao mDao = new MemberDao();
	mDao.memberJoin(id, pw, name);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		alert("가입되었습니다. 로그인 해주세요.");
		location.href = 'loginPage.jsp';
	</script>
</head>
<body>
	
</body>
</html>