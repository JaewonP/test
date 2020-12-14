<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter"%>      <!-- 자바스크립트를 사용하기 위함/ 라이브러리 불러오기 -->
<%@ page import = "lbm.LbmDAO"%>
<%@ page import = "lbm.Lbm"%>
<%@ page import = "java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1"> 
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP게시판 웹 사이트</title>
</head>
<body>
	<%  // 세션에 저장된 정보는 jsp - jsp사이서 가능하므로, 다른jsp쓴 세션도 갖다가 그냥쓴다
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){                           //pageNumber가 넘어오면 "pageNumber"에 담기고, 그 값이 있다면
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));    //pageNumber변수에 그 페이지를 담아준다
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
				data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>	
				<span class="icon-bar"></span>	
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">main</a></li>                     <!-- main을 액티브함, 강조색이 생김 -->
				<li class="active"><a href="lbm.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a>                                   <!--  로그인을 액티브없앰 , 이것은 강조색깔이 없어진걸 의미 -->
						<li><a href="join.jsp">회원가입</a> 
					</ul>
				</li>
			</ul>
			<%
				}else { //세션에 저장된 userID가 있다면
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>                               
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">            <!-- 테이블 양옆에 빈칸까지 포함 -->
		<div class="row">              <!-- 테이블아래 버튼파트까지 포함 -->
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color : #eeeeee; text-align: center;">번호</th>
						<th style="background-color : #eeeeee; text-align: center;">제목</th>
						<th style="background-color : #eeeeee; text-align: center;">작성자</th>
						<th style="background-color : #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<% //페이지넘버가 넘어오면, 그 페이지에맞는 데이터리스트 가져오기
					 	LbmDAO lbmDAO = new LbmDAO();
						ArrayList<Lbm> list = lbmDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i ++){
					%>
						<tr>
							<td><%= list.get(i).getLbmID() %></td>
							<td><a href="view.jsp?lbmID=<%= list.get(i).getLbmID() %>"><%= list.get(i).getLbmTitle() %></a></td>
							<td><%= list.get(i).getUserID() %></td>
							<td><%= list.get(i).getLbmDate().substring(0, 11) + list.get(i).getLbmDate().substring(11, 13) + "시"+ list.get(i).getLbmDate().substring(14, 16) + "분" %></td>
						</tr>
					<%
						}
					%>
					
				</tbody>
			</table>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>