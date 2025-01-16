<%@page import="Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	MemberDao mDao = new MemberDao();
	boolean check = mDao.loginCheck(id, pw);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		<% 
			if(check) {
			session.setAttribute("id", id);
		%>
			<% if(id.equals("admin")) { %>
				location.href = 'adminPage.jsp';
			<% }else {%>
				location.href = 'mainPage.jsp';
			<% }%>
		<% }else {%>
			alert("아이디/비밀번호를 다시 확인하세요");
			location.href = 'loginPage.jsp';
		<% }%>
	</script>
</head>
<body>

</body>
</html>