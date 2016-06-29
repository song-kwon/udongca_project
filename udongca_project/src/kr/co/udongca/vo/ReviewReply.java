package kr.co.udongca.vo;

import java.util.Date;

public class ReviewReply {
	
	private int replyNo;
	private String replyId;
	private String replyContent;
	private Date replyDate;
	private int replyGroup;
	private int parentReply;
	private String targetName;
	private int reviewNo;
	private ReviewBoard reviewBoard;
	
	public ReviewReply() {
	}

	public ReviewReply(int replyNo, String replyId, String replyContent, Date replyDate, int replyGroup,
			int parentReply, String targetName, int reviewNo, ReviewBoard reviewBoard) {
		super();
		this.replyNo = replyNo;
		this.replyId = replyId;
		this.replyContent = replyContent;
		this.replyDate = replyDate;
		this.replyGroup = replyGroup;
		this.parentReply = parentReply;
		this.targetName = targetName;
		this.reviewNo = reviewNo;
		this.reviewBoard = reviewBoard;
	}

	public int getReplyNo() {
		return replyNo;
	}

	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}

	public String getReplyId() {
		return replyId;
	}

	public void setReplyId(String replyId) {
		this.replyId = replyId;
	}

	public String getReplyContent() {
		return replyContent;
	}

	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}

	public Date getReplyDate() {
		return replyDate;
	}

	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}

	public int getReplyGroup() {
		return replyGroup;
	}

	public void setReplyGroup(int replyGroup) {
		this.replyGroup = replyGroup;
	}

	public int getParentReply() {
		return parentReply;
	}

	public void setParentReply(int parentReply) {
		this.parentReply = parentReply;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public ReviewBoard getReviewBoard() {
		return reviewBoard;
	}

	public void setReviewBoard(ReviewBoard reviewBoard) {
		this.reviewBoard = reviewBoard;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + parentReply;
		result = prime * result + ((replyContent == null) ? 0 : replyContent.hashCode());
		result = prime * result + ((replyDate == null) ? 0 : replyDate.hashCode());
		result = prime * result + replyGroup;
		result = prime * result + ((replyId == null) ? 0 : replyId.hashCode());
		result = prime * result + replyNo;
		result = prime * result + ((reviewBoard == null) ? 0 : reviewBoard.hashCode());
		result = prime * result + reviewNo;
		result = prime * result + ((targetName == null) ? 0 : targetName.hashCode());
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
		ReviewReply other = (ReviewReply) obj;
		if (parentReply != other.parentReply)
			return false;
		if (replyContent == null) {
			if (other.replyContent != null)
				return false;
		} else if (!replyContent.equals(other.replyContent))
			return false;
		if (replyDate == null) {
			if (other.replyDate != null)
				return false;
		} else if (!replyDate.equals(other.replyDate))
			return false;
		if (replyGroup != other.replyGroup)
			return false;
		if (replyId == null) {
			if (other.replyId != null)
				return false;
		} else if (!replyId.equals(other.replyId))
			return false;
		if (replyNo != other.replyNo)
			return false;
		if (reviewBoard == null) {
			if (other.reviewBoard != null)
				return false;
		} else if (!reviewBoard.equals(other.reviewBoard))
			return false;
		if (reviewNo != other.reviewNo)
			return false;
		if (targetName == null) {
			if (other.targetName != null)
				return false;
		} else if (!targetName.equals(other.targetName))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReviewReply [replyNo=" + replyNo + ", replyId=" + replyId + ", replyContent=" + replyContent
				+ ", replyDate=" + replyDate + ", replyGroup=" + replyGroup + ", parentReply=" + parentReply
				+ ", targetName=" + targetName + ", reviewNo=" + reviewNo + ", reviewBoard=" + reviewBoard + "]";
	}


	
	
}
