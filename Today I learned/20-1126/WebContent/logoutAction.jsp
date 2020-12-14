<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹 사이트</title>
</head>
<body>
	<%
		session.invalidate();                 //userID값이 저장된 세션을 빼앗으면서 로그아웃.
	%>
	<script>
		locaion.href = 'main.jsp';
	</script>
</body>
</html>