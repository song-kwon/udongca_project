package kr.co.udongca.vo;

import java.util.Date;

public class ReviewReply {
	
	private int replyNo;
	private String replyId;
	private String replyContent;
	private Date replyDate;
	private int privparentReply;
	private String targetName;
	private String reviewNO;
	private ReviewBoard reviewBoard;
	
	public ReviewReply() {
	}

	public ReviewReply(int replyNo, String replyId, String replyContent, Date replyDate, int privparentReply,
			String targetName, String reviewNO) {
		super();
		this.replyNo = replyNo;
		this.replyId = replyId;
		this.replyContent = replyContent;
		this.replyDate = replyDate;
		this.privparentReply = privparentReply;
		this.targetName = targetName;
		this.reviewNO = reviewNO;
	}

	public ReviewReply(int replyNo, String replyId, String replyContent, Date replyDate, int privparentReply,
			String targetName, String reviewNO, ReviewBoard reviewBoard) {
		super();
		this.replyNo = replyNo;
		this.replyId = replyId;
		this.replyContent = replyContent;
		this.replyDate = replyDate;
		this.privparentReply = privparentReply;
		this.targetName = targetName;
		this.reviewNO = reviewNO;
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

	public int getPrivparentReply() {
		return privparentReply;
	}

	public void setPrivparentReply(int privparentReply) {
		this.privparentReply = privparentReply;
	}

	public String getTargetName() {
		return targetName;
	}

	public void setTargetName(String targetName) {
		this.targetName = targetName;
	}

	public String getReviewNO() {
		return reviewNO;
	}

	public void setReviewNO(String reviewNO) {
		this.reviewNO = reviewNO;
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
		result = prime * result + privparentReply;
		result = prime * result + ((replyContent == null) ? 0 : replyContent.hashCode());
		result = prime * result + ((replyDate == null) ? 0 : replyDate.hashCode());
		result = prime * result + ((replyId == null) ? 0 : replyId.hashCode());
		result = prime * result + replyNo;
		result = prime * result + ((reviewBoard == null) ? 0 : reviewBoard.hashCode());
		result = prime * result + ((reviewNO == null) ? 0 : reviewNO.hashCode());
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
		if (privparentReply != other.privparentReply)
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
		if (reviewNO == null) {
			if (other.reviewNO != null)
				return false;
		} else if (!reviewNO.equals(other.reviewNO))
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
				+ ", replyDate=" + replyDate + ", privparentReply=" + privparentReply + ", targetName=" + targetName
				+ ", reviewNO=" + reviewNO + ", reviewBoard=" + reviewBoard + "]";
	}
	
	
}
