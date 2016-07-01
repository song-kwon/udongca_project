package kr.co.udongca.vo;

public class Bookmark {

	private int no;
	private String memberId;
	private String cafeName;
	private int cafeNo;
	private PRBoard prBoard;
	
	public Bookmark() {
	}

	public Bookmark(int no, String memberId, String cafeName, int cafeNo, PRBoard prBoard) {
		super();
		this.no = no;
		this.memberId = memberId;
		this.cafeName = cafeName;
		this.cafeNo = cafeNo;
		this.prBoard = prBoard;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public int getCafeNo() {
		return cafeNo;
	}

	public void setCafeNo(int cafeNo) {
		this.cafeNo = cafeNo;
	}

	public PRBoard getPrBoard() {
		return prBoard;
	}

	public void setPrBoard(PRBoard prBoard) {
		this.prBoard = prBoard;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cafeName == null) ? 0 : cafeName.hashCode());
		result = prime * result + cafeNo;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + no;
		result = prime * result + ((prBoard == null) ? 0 : prBoard.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Bookmark other = (Bookmark) obj;
		if (cafeName == null) {
			if (other.cafeName != null)
				return false;
		} else if (!cafeName.equals(other.cafeName))
			return false;
		if (cafeNo != other.cafeNo)
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (no != other.no)
			return false;
		if (prBoard == null) {
			if (other.prBoard != null)
				return false;
		} else if (!prBoard.equals(other.prBoard))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Bookmark [no=" + no + ", memberId=" + memberId + ", cafeName=" + cafeName + ", cafeNo=" + cafeNo
				+ ", prBoard=" + prBoard + "]";
	}

	
	
	
}
