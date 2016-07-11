package kr.co.udongca.vo;

public class OneToOneInquiry {

	private int myInquiryNo;
	private int inquiryNo;
	private String inquiryTitle;
	private String inquiryType;
	private String inquiryContent;
	private String inquiryReply;	
	private String memberId;
	private Member member;
	
	public OneToOneInquiry() {
	}
	
	public OneToOneInquiry(int inquiryNo, String inquiryTitle, String inquiryType, String inquiryContent,
			String memberId) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryType = inquiryType;
		this.inquiryContent = inquiryContent;
		this.memberId = memberId;
	}
	
	public OneToOneInquiry(int inquiryNo, String inquiryTitle, String inquiryType, String inquiryContent,
			String memberId, Member member) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryType = inquiryType;
		this.inquiryContent = inquiryContent;
		this.memberId = memberId;
		this.member = member;
	}

	public OneToOneInquiry(int inquiryNo, String inquiryTitle, String inquiryType, String inquiryContent,
			String inquiryReply, String memberId) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryType = inquiryType;
		this.inquiryContent = inquiryContent;
		this.inquiryReply = inquiryReply;
		this.memberId = memberId;
	}

	public OneToOneInquiry(int inquiryNo, String inquiryTitle, String inquiryType, String inquiryContent,
			String inquiryReply, String memberId, Member member) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryType = inquiryType;
		this.inquiryContent = inquiryContent;
		this.inquiryReply = inquiryReply;
		this.memberId = memberId;
		this.member = member;
	}

	public int getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(int inquiryNo) {
		this.inquiryNo = inquiryNo;
	}

	public String getInquiryTitle() {
		return inquiryTitle;
	}

	public void setInquiryTitle(String inquiryTitle) {
		this.inquiryTitle = inquiryTitle;
	}

	public String getInquiryType() {
		return inquiryType;
	}

	public void setInquiryType(String inquiryType) {
		this.inquiryType = inquiryType;
	}

	public String getInquiryContent() {
		return inquiryContent;
	}

	public void setInquiryContent(String inquiryContent) {
		this.inquiryContent = inquiryContent;
	}

	public String getInquiryReply() {
		return inquiryReply;
	}

	public void setInquiryReply(String inquiryReply) {
		this.inquiryReply = inquiryReply;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	
	
	public int getMyInquiryNo() {
		return myInquiryNo;
	}

	public void setMyInquiryNo(int myInquiryNo) {
		this.myInquiryNo = myInquiryNo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((inquiryContent == null) ? 0 : inquiryContent.hashCode());
		result = prime * result + inquiryNo;
		result = prime * result + ((inquiryReply == null) ? 0 : inquiryReply.hashCode());
		result = prime * result + ((inquiryTitle == null) ? 0 : inquiryTitle.hashCode());
		result = prime * result + ((inquiryType == null) ? 0 : inquiryType.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
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
		OneToOneInquiry other = (OneToOneInquiry) obj;
		if (inquiryContent == null) {
			if (other.inquiryContent != null)
				return false;
		} else if (!inquiryContent.equals(other.inquiryContent))
			return false;
		if (inquiryNo != other.inquiryNo)
			return false;
		if (inquiryReply == null) {
			if (other.inquiryReply != null)
				return false;
		} else if (!inquiryReply.equals(other.inquiryReply))
			return false;
		if (inquiryTitle == null) {
			if (other.inquiryTitle != null)
				return false;
		} else if (!inquiryTitle.equals(other.inquiryTitle))
			return false;
		if (inquiryType == null) {
			if (other.inquiryType != null)
				return false;
		} else if (!inquiryType.equals(other.inquiryType))
			return false;
		if (member == null) {
			if (other.member != null)
				return false;
		} else if (!member.equals(other.member))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "OneToOneInquiry [inquiryNo=" + inquiryNo + ", inquiryTitle=" + inquiryTitle + ", inquiryType="
				+ inquiryType + ", inquiryContent=" + inquiryContent + ", inquiryReply=" + inquiryReply + ", memberId="
				+ memberId + ", member=" + member + "]";
	}
	
	
}
