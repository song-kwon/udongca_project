package kr.co.udongca.vo;

import java.util.Date;

public class NoticeBoard {

	private int noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private String importance;
	private Date noticeDate;
	
	public NoticeBoard() {
	}

	public NoticeBoard(int noticeNo, String noticeTitle, String noticeContent, String importance, Date noticeDate) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.importance = importance;
		this.noticeDate = noticeDate;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getImportance() {
		return importance;
	}

	public void setImportance(String importance) {
		this.importance = importance;
	}

	public Date getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((importance == null) ? 0 : importance.hashCode());
		result = prime * result + ((noticeContent == null) ? 0 : noticeContent.hashCode());
		result = prime * result + ((noticeDate == null) ? 0 : noticeDate.hashCode());
		result = prime * result + noticeNo;
		result = prime * result + ((noticeTitle == null) ? 0 : noticeTitle.hashCode());
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
		NoticeBoard other = (NoticeBoard) obj;
		if (importance == null) {
			if (other.importance != null)
				return false;
		} else if (!importance.equals(other.importance))
			return false;
		if (noticeContent == null) {
			if (other.noticeContent != null)
				return false;
		} else if (!noticeContent.equals(other.noticeContent))
			return false;
		if (noticeDate == null) {
			if (other.noticeDate != null)
				return false;
		} else if (!noticeDate.equals(other.noticeDate))
			return false;
		if (noticeNo != other.noticeNo)
			return false;
		if (noticeTitle == null) {
			if (other.noticeTitle != null)
				return false;
		} else if (!noticeTitle.equals(other.noticeTitle))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "NoticeBoard [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", importance=" + importance + ", noticeDate=" + noticeDate + "]";
	}
	
	

}
