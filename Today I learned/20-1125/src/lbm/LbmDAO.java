package lbm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LbmDAO {
	private Connection conn;
	//private PreparedStatement pstmt;   LbmDAO의 메서드가 총3개인데 서로 충돌나지않기위해 각 메서드안에 지역변수처럼 넣어준다
	private ResultSet rs;
	
	//db접속part
	public LbmDAO() {  //기본생성자이므로, 자동실행되는 부분
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lbm?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");              //db연결을 위한 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("접속완료");
		}catch (Exception e) {
			System.out.println("접속실패");
			e.printStackTrace();          // 에러가 나도 예쁘게 나기위함. 처음호출-에러발생한 끝까지 전체내용 확인
		}
	}
	
	//현재시간 가져오는함수(글 작성할때 현재 서버시간을 넣어줌)
	public String getDate() {   
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";      //db오류
	}
	
	
	//
	public int getNext() {   
		String SQL = "SELECT lbmID FROM LBM ORDER BY DESC";    //맨 마지막 번호 +1이 다음글의 글 번호이므로
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;             //마지막게시물 + 1
			}
			return 1;    // 첫번째 게시물인경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;      //db오류
	}
	
	
	public int write(String lbmTitle, String userID, String lbmContent) {
		String SQL = "INSERT INTO LBM VALUES(?,?,?,?,?,?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, lbmTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, lbmContent);
			pstmt.setInt(6, 1);         //글이 보여지는상태(available)이면 1, 아니면 0
			
			return pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;      //db오류
	}
}
