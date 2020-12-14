<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>    
<%@ page import = "java.io.PrintWriter" %>  					<!-- 자바스크립트를 사용하기 위함 -->
<% request.setCharacterEncoding("UTF-8"); %>  					<!-- 건너오는 모든값들을 인코딩 -->
<jsp:useBean id="user" class="user.User" scope="page" />         <!-- 해당클래스를 bean으로 사용한다. 매회 객체의 클래스이름으로 가져오는게아니라 usebean으로 클래스와 id값을 연결하고 id값을 통해 객체의 프로퍼티에 접근 -->
<jsp:setProperty name="user" property="userID" />        		<!-- jsp페이지에서 넘어온 값을 받는자리 -->
<jsp:setProperty name="user" property="userPassword" />        <!-- jsp페이지에서 넘어온 값을 받는자리 -->
<jsp:setProperty name="user" property="userName" /> 
<jsp:setProperty name="user" property="userGender" /> 
<jsp:setProperty name="user" property="userEmail" /> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹 사이트</title>
</head>
<body>
	<%
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든칸을 입력해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);   //userDAO 에서 리턴된 -2~1까지의 값이 result에 담긴다 
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 id입니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			
		}
		

	%>
</body>
</html>