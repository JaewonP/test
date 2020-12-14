<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter"%>      <!-- 자바스크립트를 사용하기 위함/ 라이브러리 불러오기 -->
<%@ page import = "lbm.Lbm"%> 
<%@ page import = "lbm.LbmDAO"%> 
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
		int lbmID = 0;
		if(request.getParameter("lbmID") != null) {
			lbmID = Integer.parseInt(request.getParameter("lbmID"));
		}
		if(lbmID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지않은 글입니다.')");
			script.println("location.href = 'lbm.jsp'");
			script.println("</script>");
		}
		Lbm lbm = new LbmDAO().getLbm(lbmID);
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
						<th colspan="3" style="background-color : #eeeeee; text-align: center;">게시판 글보기</th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= lbm.getLbmTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&lt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= lbm.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= lbm.getLbmDate().substring(0, 11) + lbm.getLbmDate().substring(11, 13) + "시"+ lbm.getLbmDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height:200px; text-align:left;"><%= lbm.getLbmContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt;").replaceAll(">", "&lt;").replaceAll("\n", "<br>") %></td>
					</tr>
	
				</tbody>
			</table>
			<a href="lbm.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(lbm.getUserID())){
			%>		
				<a href="update.jsp?lbmID=<%= lbmID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?lbmID=<%= lbmID %>" class="btn btn-primary">삭제</a>
			<% 
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>