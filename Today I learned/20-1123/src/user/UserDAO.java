package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//db접속part
	public UserDAO() {  //기본생성자이므로, 자동실행되는 부분
		try {
			String dbURL = "jdbc:mysql://localhost:3306/lbm?serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");              //db연결을 위한 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			System.out.println("접속완료");
		}catch (Exception e) {
			System.out.println("접속실패");
			e.printStackTrace();          // 에러가 나도 예쁘게 나기위함. 처음호출-에러발생한 끝까지 전체내용 확인
		}
	}
	
	//login시도 part
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userpassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else
					return 0; // 비밀번호 불일치 
			}
			return -1;   //id가 없음 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;   // db오류
	}
	
	//회원가입join시도 part
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			System.out.println("db에저장완료");
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	
}
