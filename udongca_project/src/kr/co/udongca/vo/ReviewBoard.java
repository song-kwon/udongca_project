package kr.co.udongca.vo;

import java.util.Date;

public class ReviewBoard {

	private String reviewNo;
	private String reviewTitle;
	private Date reviewDate;
	private String reviewContent;
	private String reviewGrade;
	private String memberId;
	private String reviewRealImage;
	private String reviewFakeImage;
	private int cafeNo;
	private PRBoard prBoard;
	
	public ReviewBoard() {
	}

	public ReviewBoard(String reviewNo, String reviewTitle, Date reviewDate, String reviewContent, String reviewGrade,
			String memberId, String reviewRealImage, String reviewFakeImage, int cafeNo) {
		super();
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewDate = reviewDate;
		this.reviewContent = reviewContent;
		this.reviewGrade = reviewGrade;
		this.memberId = memberId;
		this.reviewRealImage = reviewRealImage;
		this.reviewFakeImage = reviewFakeImage;
		this.cafeNo = cafeNo;
	}

	public ReviewBoard(String reviewNo, String reviewTitle, Date reviewDate, String reviewContent, String reviewGrade,
			String memberId, String reviewRealImage, String reviewFakeImage, int cafeNo, PRBoard prBoard) {
		super();
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewDate = reviewDate;
		this.reviewContent = reviewContent;
		this.reviewGrade = reviewGrade;
		this.memberId = memberId;
		this.reviewRealImage = reviewRealImage;
		this.reviewFakeImage = reviewFakeImage;
		this.cafeNo = cafeNo;
		this.prBoard = prBoard;
	}

	public String getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(String reviewNo) {
		this.reviewNo = reviewNo;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public String getReviewGrade() {
		return reviewGrade;
	}

	public void setReviewGrade(String reviewGrade) {
		this.reviewGrade = reviewGrade;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getReviewRealImage() {
		return reviewRealImage;
	}

	public void setReviewRealImage(String reviewRealImage) {
		this.reviewRealImage = reviewRealImage;
	}

	public String getReviewFakeImage() {
		return reviewFakeImage;
	}

	public void setReviewFakeImage(String reviewFakeImage) {
		this.reviewFakeImage = reviewFakeImage;
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
		result = prime * result + cafeNo;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((prBoard == null) ? 0 : prBoard.hashCode());
		result = prime * result + ((reviewContent == null) ? 0 : reviewContent.hashCode());
		result = prime * result + ((reviewDate == null) ? 0 : reviewDate.hashCode());
		result = prime * result + ((reviewFakeImage == null) ? 0 : reviewFakeImage.hashCode());
		result = prime * result + ((reviewGrade == null) ? 0 : reviewGrade.hashCode());
		result = prime * result + ((reviewNo == null) ? 0 : reviewNo.hashCode());
		result = prime * result + ((reviewRealImage == null) ? 0 : reviewRealImage.hashCode());
		result = prime * result + ((reviewTitle == null) ? 0 : reviewTitle.hashCode());
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
		ReviewBoard other = (ReviewBoard) obj;
		if (cafeNo != other.cafeNo)
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (prBoard == null) {
			if (other.prBoard != null)
				return false;
		} else if (!prBoard.equals(other.prBoard))
			return false;
		if (reviewContent == null) {
			if (other.reviewContent != null)
				return false;
		} else if (!reviewContent.equals(other.reviewContent))
			return false;
		if (reviewDate == null) {
			if (other.reviewDate != null)
				return false;
		} else if (!reviewDate.equals(other.reviewDate))
			return false;
		if (reviewFakeImage == null) {
			if (other.reviewFakeImage != null)
				return false;
		} else if (!reviewFakeImage.equals(other.reviewFakeImage))
			return false;
		if (reviewGrade == null) {
			if (other.reviewGrade != null)
				return false;
		} else if (!reviewGrade.equals(other.reviewGrade))
			return false;
		if (reviewNo == null) {
			if (other.reviewNo != null)
				return false;
		} else if (!reviewNo.equals(other.reviewNo))
			return false;
		if (reviewRealImage == null) {
			if (other.reviewRealImage != null)
				return false;
		} else if (!reviewRealImage.equals(other.reviewRealImage))
			return false;
		if (reviewTitle == null) {
			if (other.reviewTitle != null)
				return false;
		} else if (!reviewTitle.equals(other.reviewTitle))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReviewBoard [reviewNo=" + reviewNo + ", reviewTitle=" + reviewTitle + ", reviewDate=" + reviewDate
				+ ", reviewContent=" + reviewContent + ", reviewGrade=" + reviewGrade + ", memberId=" + memberId
				+ ", reviewRealImage=" + reviewRealImage + ", reviewFakeImage=" + reviewFakeImage + ", cafeNo=" + cafeNo
				+ ", prBoard=" + prBoard + "]";
	}

	
}

