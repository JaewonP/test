package lbm;

// 게시물에 넣고 가져올 정보에 대한 자바빈
public class Lbm {
	private int lbmID;
	private String lbmTitle;
	private String userID;
	private String lbmDate;             //db에서는 date타입이었지만, 여기서는 string으로 관리하기로함
	private String lbmContent;
	private int lbmAvailable;
	
	public int getLbmID() {
		return lbmID;
	}
	public void setLbmID(int lbmID) {
		this.lbmID = lbmID;
	}
	public String getLbmTitle() {
		return lbmTitle;
	}
	public void setLbmTitle(String lbmTitle) {
		this.lbmTitle = lbmTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLbmDate() {
		return lbmDate;
	}
	public void setLbmDate(String lbmDate) {
		this.lbmDate = lbmDate;
	}
	public String getLbmContent() {
		return lbmContent;
	}
	public void setLbmContent(String lbmContent) {
		this.lbmContent = lbmContent;
	}
	public int getLbmAvailable() {
		return lbmAvailable;
	}
	public void setLbmAvailable(int lbmAvailable) {
		this.lbmAvailable = lbmAvailable;
	}
	
	
}
