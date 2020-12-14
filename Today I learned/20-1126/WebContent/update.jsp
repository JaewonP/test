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
		//userID가 확인이안되면 로그인해라
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인해주세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		//ID값이 있다면 가져와서 저장하고, 그 값이 0이면 까버려라
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
		//만약 작성한 아이디와 서버에저장된 아이디랑 다르다면 까버려라
		Lbm lbm = new LbmDAO().getLbm(lbmID);
		if(!userID.equals(lbm.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'lbm.jsp'");
			script.println("</script>");
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
		</div>
	</nav>
	<div class="container">            <!-- 테이블 양옆에 빈칸까지 포함 -->
		<div class="row">              <!-- 테이블아래 버튼파트까지 포함 -->
		<form method="post" action="updateAction.jsp?lbmID=<%=lbmID%>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color : #eeeeee; text-align: center;">게시판 글 수정양식</th>

					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="lbmTitle" maxlength="50" value="<%= lbm.getLbmTitle() %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글 내용" name="lbmContent" maxlength="2048" style="height: 350px;"> <%=lbm.getLbmContent() %></textarea></td>
					</tr>
				</tbody>
				<input type="submit" class="btn btn-primary pull-right" value="글 수정하기">
			</table>
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>