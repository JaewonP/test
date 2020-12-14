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
	$(document).ready(function() {
	    $(".get").click(function(e) {
	      // e.preventDefault();
	       console.log($(this).attr("href")); // ""안에 이름 준 속성값을 가져오거나 바꿔줌 
	       $(this).attr("href", "update?gid=" + $(this).attr("href")); //href를 찾아서 다른기능으로 바꿀수있다.
	    })
	 })
</script>
<style>
	.delbtn {
		border : 1px solid gray;
		background-color : rgba(0,0,0,0);
		color : gray;
		border-radius : 5px;
	}
	.delbtn :hover{
		color : white;
		background-color : lightgray;
	}
</style>
</head>
<body>
<table class="table table-striped">
	<thead>
		<p style="font-size:20px; font-weight:bold; ">[ 전체리스트  ]</p>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>국어점수</th>
			<th>수학점수</th>
			<th>삭제<th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${a}" var="i">
		<tr>
			<td><a class="get" href='<c:out value="${i.gid}"/>'> <!-- 이거만들기 힘드니까 제이쿼리를쓴다 -->
				<c:out value="${i.gid}"/>	
			</a></td>
			<td><c:out value="${i.name}"/></td>
			<td><c:out value="${i.korea}"/></td>
			<td><c:out value="${i.math}"/></td>
			<td><button type="button" class="delbtn" onclick="location.href='/green/delete?gid=${i.gid}'">삭제</button></td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>