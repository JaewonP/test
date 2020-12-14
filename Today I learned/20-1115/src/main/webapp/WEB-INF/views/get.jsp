<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script>
	$(document).ready(function(){
		$(".submit").hover(function(){
			$(this).css({
				"background" : "skyblue",
				"transition" : "0.7s"
			})
		}, function(){
			$(this).css({
				"background" : "white",
				"transition" : "0.5s"
			})
		})
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>
<br>
<hr>
	<form action="get" method="post">
		번호    <input type="text" name="gid"/>
		<input class="submit" type="submit" value="전송">
<hr>	
	<table class="table table-striped">
		<thead>
			<p style="font-size:20px; font-weight:bold; ">[조회하고싶은 번호를 입력하세요]</p>
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>국어점수</th>
				<th>수학점수</th>
			</tr>
		</thead>
		<tbody>
			<td><c:out value="${a.gid}" /></td>
			<td><c:out value="${a.name}" /></td>
			<td><c:out value="${a.korea}" /></td>
			<td><c:out value="${a.math}" /></td>
		</tbody>
	</form>
</table>
</body>
</html>