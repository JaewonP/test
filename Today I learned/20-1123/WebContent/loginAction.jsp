<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>    
<%@ page import = "java.io.PrintWriter" %>  					<!-- 자바스크립트를 사용하기 위함 -->
<% request.setCharacterEncoding("UTF-8"); %>  					<!-- 건너오는 모든값들을 인코딩 -->
<jsp:useBean id="user" class="user.User" scope="page" />         <!-- 해당클래스를 bean으로 사용한다. 매회 객체의 클래스이름으로 가져오는게아니라 usebean으로 클래스와 id값을 연결하고 id값을 통해 객체의 프로퍼티에 접근 -->
<jsp:setProperty name="user" property="userID" />        		<!-- jsp페이지에서 넘어온 값을 받는자리 -->
<jsp:setProperty name="user" property="userPassword" />        <!-- jsp페이지에서 넘어온 값을 받는자리 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹 사이트</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());   //userDAO 에서 리턴된 -2~1까지의 값이 result에 담긴다 
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('db오류발생! 관리자에게 문의하세요')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
</body>
</html>