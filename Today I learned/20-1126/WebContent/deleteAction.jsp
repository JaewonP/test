<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "lbm.LbmDAO" %>    
<%@ page import = "lbm.Lbm" %>    
<%@ page import = "java.io.PrintWriter" %>  					<!-- 자바스크립트를 사용하기 위함 -->
<% request.setCharacterEncoding("UTF-8"); %>  					<!-- 건너오는 모든값들을 인코딩 -->


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
		//만약 작성한 아이디와 서버에저장된 아이디랑 다르다면 까버려라
		Lbm lbm = new LbmDAO().getLbm(lbmID);
		if(!userID.equals(lbm.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'lbm.jsp'");
			script.println("</script>");
		}else {
			LbmDAO lbmDAO = new LbmDAO();
			int result = lbmDAO.delete(lbmID);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다(db오류)')");
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

	%>
</body>
</html>