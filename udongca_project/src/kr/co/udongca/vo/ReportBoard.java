package kr.co.udongca.vo;

public class ReportBoard {

	private int myReportNo;
	private int reportboardNo;
	private String reportMemberId;
	private String reportReason;
	private String reportContent;
	private String reportResult;
	private String reportCancelReason;
	private String reportType;
	private int reportNO;
	private String memberId;
	private Member member;
	
	public ReportBoard() {
	}
	
	public ReportBoard(int reportboardNo, String reportMemberId, String reportReason, String reportContent,
			String reportResult, String reportCancelReason, String reportType, int reportNO, String memberId) {
		this.reportboardNo = reportboardNo;
		this.reportMemberId = reportMemberId;
		this.reportReason = reportReason;
		this.reportContent = reportContent;
		this.reportResult = reportResult;
		this.reportCancelReason = reportCancelReason;
		this.reportType = reportType;
		this.reportNO = reportNO;
		this.memberId = memberId;
	}

	public ReportBoard(int reportboardNo, String reportMemberId, String reportReason, String reportContent,
			String reportResult, String reportCancelReason, String reportType, int reportNO, String memberId,
			Member member) {
		this.reportboardNo = reportboardNo;
		this.reportMemberId = reportMemberId;
		this.reportReason = reportReason;
		this.reportContent = reportContent;
		this.reportResult = reportResult;
		this.reportCancelReason = reportCancelReason;
		this.reportType = reportType;
		this.reportNO = reportNO;
		this.memberId = memberId;
		this.member = member;
	}

	public int getReportboardNo() {
		return reportboardNo;
	}

	public String getReportMemberId() {
		return reportMemberId;
	}

	public String getReportReason() {
		return reportReason;
	}

	public String getReportContent() {
		return reportContent;
	}

	public String getReportResult() {
		return reportResult;
	}

	public String getReportCancelReason() {
		return reportCancelReason;
	}

	public String getReportType() {
		return reportType;
	}

	public int getReportNO() {
		return reportNO;
	}

	public String getMemberId() {
		return memberId;
	}

	public Member getMember() {
		return member;
	}

	public void setReportboardNo(int reportboardNo) {
		this.reportboardNo = reportboardNo;
	}

	public void setReportMemberId(String reportMemberId) {
		this.reportMemberId = reportMemberId;
	}

	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}

	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}

	public void setReportResult(String reportResult) {
		this.reportResult = reportResult;
	}

	public void setReportCancelReason(String reportCancelReason) {
		this.reportCancelReason = reportCancelReason;
	}

	public void setReportType(String reportType) {
		this.reportType = reportType;
	}

	public void setReportNO(int reportNO) {
		this.reportNO = reportNO;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	
	public int getMyReportNo() {
		return myReportNo;
	}

	public void setMyReportNo(int myReportNo) {
		this.myReportNo = myReportNo;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((reportCancelReason == null) ? 0 : reportCancelReason.hashCode());
		result = prime * result + ((reportContent == null) ? 0 : reportContent.hashCode());
		result = prime * result + ((reportMemberId == null) ? 0 : reportMemberId.hashCode());
		result = prime * result + reportNO;
		result = prime * result + ((reportReason == null) ? 0 : reportReason.hashCode());
		result = prime * result + ((reportResult == null) ? 0 : reportResult.hashCode());
		result = prime * result + ((reportType == null) ? 0 : reportType.hashCode());
		result = prime * result + reportboardNo;
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
		ReportBoard other = (ReportBoard) obj;
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
		if (reportCancelReason == null) {
			if (other.reportCancelReason != null)
				return false;
		} else if (!reportCancelReason.equals(other.reportCancelReason))
			return false;
		if (reportContent == null) {
			if (other.reportContent != null)
				return false;
		} else if (!reportContent.equals(other.reportContent))
			return false;
		if (reportMemberId == null) {
			if (other.reportMemberId != null)
				return false;
		} else if (!reportMemberId.equals(other.reportMemberId))
			return false;
		if (reportNO != other.reportNO)
			return false;
		if (reportReason == null) {
			if (other.reportReason != null)
				return false;
		} else if (!reportReason.equals(other.reportReason))
			return false;
		if (reportResult == null) {
			if (other.reportResult != null)
				return false;
		} else if (!reportResult.equals(other.reportResult))
			return false;
		if (reportType == null) {
			if (other.reportType != null)
				return false;
		} else if (!reportType.equals(other.reportType))
			return false;
		if (reportboardNo != other.reportboardNo)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ReportBoard [reportboardNo=" + reportboardNo + ", reportMemberId=" + reportMemberId + ", reportReason="
				+ reportReason + ", reportContent=" + reportContent + ", reportResult=" + reportResult
				+ ", reportCancelReason=" + reportCancelReason + ", reportType=" + reportType + ", reportNO=" + reportNO
				+ ", memberId=" + memberId + ", member=" + member + "]";
	}
	
	
}
