<%@page import="Dto.MemberDto"%>
<%@page import="Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	
	MemberDao mDao = new MemberDao();
	MemberDto memberInfo = null;
	memberInfo = mDao.getMemberInfo(id);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script>
		$(function() {
			$("#submitBtn").click(function() {
				let id = $("#id").val();
				let pw = $("#pw").val();
				let name = $("#name").val();
				let point = $("#point").val();
				$.ajax({
					type: 'post',
					url: 'memberAlterAjaxServlet',
					data: {
						"id":id,
						"pw":pw,
						"name":name,
						"point":point
					},
					success: function() {
						alert("수정되었습니다.");
						location.href = 'adminPage.jsp';
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
		})
	</script>
</head>
<body>
	<h1>회원관리-수정관리자</h1>
	ID <input type="text" id="id" value="<%=memberInfo.getId() %>" readonly/><br/>
	PW <input type="text" id="pw" value="<%=memberInfo.getPw() %>"/><br/>
	Name <input type="text" id="name" value="<%=memberInfo.getName() %>"/><br/>
	Point <input type="text" id="point" value="<%=memberInfo.getPoint() %>"/><br/>	
	<input type="button" id="submitBtn" value="제출"/>
	
</body>
</html>