<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "lbm.LbmDAO" %>    
<%@ page import = "java.io.PrintWriter" %>  					<!-- 자바스크립트를 사용하기 위함 -->
<% request.setCharacterEncoding("UTF-8"); %>  					<!-- 건너오는 모든값들을 인코딩 -->
<jsp:useBean id="lbm" class="lbm.Lbm" scope="page" />         <!-- 해당클래스를 bean으로 사용한다. 매회 객체의 클래스이름으로 가져오는게아니라 usebean으로 클래스와 id값을 연결하고 id값을 통해 객체의 프로퍼티에 접근 -->
<jsp:setProperty name="lbm" property="lbmTitle" />        		<!-- jsp페이지에서 넘어온 값을 받는자리 -->
<jsp:setProperty name="lbm" property="lbmContent" />        <!-- jsp페이지에서 넘어온 값을 받는자리 -->

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;                    //30줄까지 이미 회원가입된사람은 다시 회원가입할 수 없도록 막아줌(세션이용하여 막아주기)
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		
		
		if(userID == null){             
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인하세요')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}else {
			if(lbm.getLbmTitle() == null || lbm.getLbmContent() == null ){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모든칸을 입력해주세요')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				LbmDAO lbmDAO = new LbmDAO();
				int result = lbmDAO.write(lbm.getLbmTitle(), userID, lbm.getLbmContent());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다(db오류)')");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'lbm.jsp'");
					script.println("</script>");
				}
				
			}
			
			
		}
	
	
		
		

	%>
</body>
</html>