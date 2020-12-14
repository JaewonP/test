<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.UserDAO" %>    
<%@ page import = "java.io.PrintWriter" %>  					<!-- 자바스크립트를 사용하기 위함(printwriter -->
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
		String userID = null;                    //27줄까지 이미 로그인된사람은 다시 로그인할 수 없도록 막아줌(세션이용하여 막아주기) 여기서 userID는 DAO의 아이디가아닌 session아이디 
		if(session.getAttribute("userID") != null) {        //userID라는 이름을 붙어 세션ID를 가져오고 그걸 userID에 저장해준다
			userID = (String)session.getAttribute("userID");    //
		}
		if(userID != null){                        //세션ID가 있다면 아래의 쿼리가 진행됨
			session.setAttribute("userID", user.getUserID());              
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인되어있습니다')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}// 여기까지는 이미 로그인되어있는지 아닌지 거르는 파트 
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());   //userDAO 에서 리턴된 -2~1까지의 값이 result에 담긴다 
		if(result == 1){
			session.setAttribute("userID", user.getUserID());     // 로그인이 되었다면 세션을 설정하여, 아이디를 서버에서 저장하게한다(세션이 존재하는 시간동안) 세션ID로 로그인여부확인가능
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