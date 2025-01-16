<%@page import="Dto.MemberDto"%>
<%@page import="Dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("id");

	MemberDao mDao = new MemberDao();
	MemberDto memberInfo = null;
	try {
		memberInfo = mDao.getMemberInfo(id);
	} catch(Exception e) {}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<% 	if(id == null) { %>
	<script>
		alert("로그인하세요.");
		location.href = 'loginPage.jsp';
	</script>
<%	} %>
	<script>
		$(function() {
			$("#logoutBtn").click(function() {
				location.href = 'logoutAction.jsp';
			})
			$("#item1").click(function() {
				let priceStr = $(this).next().next().text();
				let price = priceStr.replace("포인트", "").replace(",", "");
				$.ajax({ 
					type: 'post',
					url: 'purchaseAjaxServlet',
					data: {
						"price":price,
						"id":"<%=id %>"
					},
					success: function(data) {
						console.log(data);
						if(data.yn == 'Y') {
							alert("컨텐츠(intro)를 구입하였습니다.");
						}else {
							alert("포인트가 부족합니다. 광고를 클릭하세요.");
						}
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			$("#item2").click(function() {
				let priceStr = $(this).next().next().text();
				let price = priceStr.replace("포인트", "").replace(",", "");
				$.ajax({ 
					type: 'post',
					url: 'purchaseAjaxServlet',
					data: {
						"price":price,
						"id":"<%=id %>"
					},
					success: function(data) {
						console.log(data);
						if(data.yn == 'Y') {
							alert("컨텐츠(java)를 구입하였습니다.");
						}else {
							alert("포인트가 부족합니다. 광고를 클릭하세요.");
						}
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			$("#item3").click(function() {
				let priceStr = $(this).next().next().text();
				let price = priceStr.replace("포인트", "").replace(",", "");
				$.ajax({ 
					type: 'post',
					url: 'purchaseAjaxServlet',
					data: {
						"price":price,
						"id":"<%=id %>"
					},
					success: function(data) {
						console.log(data);
						if(data.yn == 'Y') {
							alert("컨텐츠(c++)를 구입하였습니다.");
						}else {
							alert("포인트가 부족합니다. 광고를 클릭하세요.");
						}
						location.reload();
					},
					error: function(r, s, e) {
						console.log(r.status);
						console.log(r.responseText);
						console.log(e);
					}
				})
			})
			$("#footerBox").click(function() {
				let random = Math.floor(Math.random() * 1000) + 1;
				$.ajax({
					type: 'post',
					url: 'pointPlusAjaxServlet',
					data: {
						"id":"<%=id %>",
						"plus":random
					},
					success: function() {
						alert(random+"점이 적립되었습니다.");
						location.href = 'https://koreaisacademy.com/';
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
	<style>
		* {
			padding: 0;
			margin: 0;
			box-sizing: border-box;
		}
		#bodyDiv {
			position: relative;
			width: 1100px;
			height: 100vh;
		}
		#memberInfoBox{
			position: absolute;
			top: 100px;
			right: 20px;
			width: 180px;
			font-size: 18px;
		}
		#contentWrap {
			margin-top: 150px;
		}
		#contentsBox {
			display: flex;
			align-items: center;
			justify-content: center;
			margin-top: 20px;
			width: 100%;
		}
		#contentsBox div {
			text-align: center;
		}
		.items {
			cursor : pointer;
		}
		#footerBox {
			position: absolute;
			bottom: 20px;
			right: 20px;
			border: 1px solid black;
			cursor: pointer;
		}
	</style>
</head>
<body>
	<div id="bodyDiv">
		<h1>메인페이지</h1>
		<div id="memberInfoBox">
			<%if(id != null) { %>
				<span><%=memberInfo.getName() %>(<%=memberInfo.getId() %>)</span> <button id="logoutBtn">로그아웃</button><br/>
				포인트 : <%=memberInfo.getPoint() %>점
			<%} %>
		</div>
		<div id="contentWrap">
			<h2>구입할 컨텐츠를 선택하세요.</h2>
			<div id="contentsBox">
				<div>
					<img src="image/Intro_350_408.png" class="items" id="item1"/><br/>
					<span>100,000포인트</span>
				</div>
				<div>
					<img src="image/Java_350_408.png" class="items" id="item2"/><br/>
					<span>500,000포인트</span>
				</div>
				<div>
					<img src="image/Cpp_350_408.png" class="items" id="item3"/><br/>
					<span>300,000포인트</span>
				</div>
			</div>
			<div id="footerBox">
				<span>&lt;광고&gt;</span><br/>
				<img src="image/korea_it.png"/>
			</div>
		</div>
	</div>
</body>
</html>