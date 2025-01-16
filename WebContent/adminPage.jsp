<%@page import="Dto.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");
	if(!id.equals("admin")) { %>
		<script>
			location.href = 'mainPage.jsp?id='+id;
		</script>
<% }
	MemberDao mDao = new MemberDao();
	ArrayList<MemberDto> memberList = null;
	try {
		memberList = mDao.getAllMembers();
	} catch(Exception e) {}
%>
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
			$("#loginBtn").click(function() {
				location.href = 'loginPage.jsp';
			})
			$(".alertBtn").click(function() {
				let id = $(this).parent().parent().find('td:first-child').text();
				location.href = 'memberAlterPage.jsp?id='+id;
			})
			$(".delBtn").click(function() {
				let id = $(this).parent().parent().find('td:first-child').text();
				$.ajax({
					type: 'post',
					url: 'memberDelAjaxServlet',
					data: {"id":id},
					success: function() {
						alert("삭제되었습니다.");
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			$("#scheduleStartBtn").click(function() {
				let memberCnt = $(".alertBtn").length;
				alert("스케줄러가 시작되었음");
				$.ajax({
					type: 'post',
					url: 'schedulerStartAjaxServlet',
					data: {"memberCnt":memberCnt},
					success: function() {},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			$("#scheduleEndBtn").click(function() {
				alert("스케줄러의 실행이 종료되었음");
				$.ajax({
					type: 'post',
					url: 'schedulerEndAjaxServlet',
					data: {},
					success: function() {},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
		})
	</script>
	<style>
		* {
			padding: 0;
			margin: 0;
			box-sizing: border-box;
		}
		#bodyDiv {
			position: relative;
			width: 1200px;
			height: 100vh;
		}
		#loginBtn {
			position: absolute;
			right: 50px;
			width: 100px;
			height: 30px;
		}
		#schedulerTable {
			margin: 0 auto;
			margin-top: 80px;
			margin-bottom: 20px;
			width: 90%;
			height: 400px;
			border-collapse: collapse;
			text-align: center;
		}
		#schedulerTable td, th {
			border: 1px solid black;
		}
		#footerBox {
			margin-top: 20px;
		}
	</style>
</head>
<body>
	<div id="bodyDiv">	
		<h1>회원 관리</h1>
		<button id="loginBtn">로그인</button>
		<table id="schedulerTable">
			<tr>
				<th>ID</th>
				<th>PW</th>
				<th>Name</th>
				<th>Point</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<%for(MemberDto dto : memberList) { %>
				<tr>
					<td><%=dto.getId() %></td>
					<td><%=dto.getPw() %></td>
					<td><%=dto.getName() %></td>
					<td><%=dto.getPoint() %></td>
					<td><button class="alertBtn">수정</button></td>
					<td><button class="delBtn">삭제</button></td>
				</tr>
			<%} %>
		</table>
		<h1>스케줄러관리</h1>
		<div id="footerBox">
			<button id="scheduleStartBtn">스케줄러(20초마다 포인트1 증가) 실행 시작</button>
			<button id="scheduleEndBtn">스케줄러 실행 종료</button>
		</div>
	</div>
</body>
</html>