<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script>
	$(document).ready(function(){
		$(".btn").hover(function(){
			$(this).css({
				"background" : "skyblue",
				"transition" : "0.7s"
			})
		}, function(){
			$(this).css({
				"background" : "white",
				"transition" : "0.3s"
			})
		})
	});
</script>

</head>
<body>

<table class="table table-striped">
	<thead>
		<p style="font-size:20px; font-weight:bold; ">[ 데이터 수정완료!(수정된데이터를 확인하세요!)]</p>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>국어점수</th>
			<th>수학점수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${b}" var="bb">
			<tr>
				<td><c:out value="${bb.gid}"/>	</td>
				<td><c:out value="${bb.name}"/></td>
				<td><c:out value="${bb.korea}"/></td>
				<td><c:out value="${bb.math}"/></td>
			</tr>
		</c:forEach>
	</tbody>
	
</table>	
	<button type="submit" class="btn" onclick="location=href='/green/list.jsp'">list로 돌아가기</button>
</html>