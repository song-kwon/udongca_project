package kr.co.udongca.vo;

import java.sql.Date;

public class ReviewBoard {

	private int myReviewNo;
	private int reviewNo;
	private String reviewTitle;
	private Date reviewDate;
	private String reviewContent;
	private int ratingStars;
	private String memberId;
	private String reviewRealImage;
	private String reviewFakeImage;
	private int cafeNo;
	private PRBoard prBoard;
	
	public ReviewBoard(){}
	
	public ReviewBoard(int reviewNo, String reviewTitle, Date reviewDate, String reviewContent, int ratingStars,
			String memberId, String reviewRealImage, String reviewFakeImage, int cafeNo,int myReviewNo) {
		super();
		this.reviewNo = reviewNo;
		this.reviewTitle = reviewTitle;
		this.reviewDate = reviewDate;
		this.reviewContent = reviewContent;
		this.ratingStars = ratingStars;
		this.memberId = memberId;
		this.reviewRealImage = reviewRealImage;
		this.reviewFakeImage = reviewFakeImage;
		this.cafeNo = cafeNo;
		this.myReviewNo=myReviewNo;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public String getReviewTitle() {
		return reviewTitle;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public int getRatingStars() {
		return ratingStars;
	}

	public String getMemberId() {
		return memberId;
	}

	public String getReviewRealImage() {
		return reviewRealImage;
	}

	public String getReviewFakeImage() {
		return reviewFakeImage;
	}

	public int getCafeNo() {
		return cafeNo;
	}

	public PRBoard getPrBoard() {
		return prBoard;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public void setRatingStars(int ratingStars) {
		this.ratingStars = ratingStars;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public void setReviewRealImage(String reviewRealImage) {
		this.reviewRealImage = reviewRealImage;
	}

	public void setReviewFakeImage(String reviewFakeImage) {
		this.reviewFakeImage = reviewFakeImage;
	}

	public void setCafeNo(int cafeNo) {
		this.cafeNo = cafeNo;
	}

	public void setPrBoard(PRBoard prBoard) {
		this.prBoard = prBoard;
	}
	

	public int getMyReviewNo() {
		return myReviewNo;
	}

	public void setMyReviewNo(int myReviewNo) {
		this.myReviewNo = myReviewNo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + cafeNo;
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + myReviewNo;
		result = prime * result + ((prBoard == null) ? 0 : prBoard.hashCode());
		result = prime * result + ratingStars;
		result = prime * result + ((reviewContent == null) ? 0 : reviewContent.hashCode());
		result = prime * result + ((reviewDate == null) ? 0 : reviewDate.hashCode());
		result = prime * result + ((reviewFakeImage == null) ? 0 : reviewFakeImage.hashCode());
		result = prime * result + reviewNo;
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
		if (myReviewNo != other.myReviewNo)
			return false;
		if (prBoard == null) {
			if (other.prBoard != null)
				return false;
		} else if (!prBoard.equals(other.prBoard))
			return false;
		if (ratingStars != other.ratingStars)
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
		if (reviewNo != other.reviewNo)
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
		return "ReviewBoard [myReviewNo=" + myReviewNo + ", reviewNo=" + reviewNo + ", reviewTitle=" + reviewTitle
				+ ", reviewDate=" + reviewDate + ", reviewContent=" + reviewContent + ", ratingStars=" + ratingStars
				+ ", memberId=" + memberId + ", reviewRealImage=" + reviewRealImage + ", reviewFakeImage="
				+ reviewFakeImage + ", cafeNo=" + cafeNo + ", prBoard=" + prBoard + "]";
	}
}