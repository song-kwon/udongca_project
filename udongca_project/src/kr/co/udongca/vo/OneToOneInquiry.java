package kr.co.udongca.vo;

public class OneToOneInquiry {

	private String inquiryNo;
	private String inquiryTitle;
	private String inquiryType;
	private String inquiryContent;
	private String inquiryReply;	
	private String memberId;
	private Member member;
	
	public OneToOneInquiry() {
	}

	public OneToOneInquiry(String inquiryNo, String inquiryTitle, String inquiryType, String inquiryContent,
			String inquiryReply, String memberId) {
		super();
		this.inquiryNo = inquiryNo;
		this.inquiryTitle = inquiryTitle;
		this.inquiryType = inquiryType;
		this.inquiryContent = inquiryContent;
		this.inquiryReply = inquiryReply;
		this.memberId = memberId;
	}

	public OneToOneInquiry(String inquiryNo, String inquiryTitle, String inquiryType, String inquiryContent,
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

	public String getInquiryNo() {
		return inquiryNo;
	}

	public void setInquiryNo(String inquiryNo) {
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

	@Override
	public String toString() {
		return "OneToOneInquiry [inquiryNo=" + inquiryNo + ", inquiryTitle=" + inquiryTitle + ", inquiryType="
				+ inquiryType + ", inquiryContent=" + inquiryContent + ", inquiryReply=" + inquiryReply + ", memberId="
				+ memberId + ", member=" + member + "]";
	}
	
	
}
