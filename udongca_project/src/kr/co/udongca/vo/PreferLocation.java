package kr.co.udongca.vo;

public class PreferLocation {

	private int preferLocationNo;
	private String address1;
	private String address2;
	private String memberId;
	private Member member;

	public PreferLocation() {
	}

	public PreferLocation(int preferLocationNo, String address1, String address2, String memberId) {
		super();
		this.preferLocationNo = preferLocationNo;
		this.address1 = address1;
		this.address2 = address2;
		this.memberId = memberId;
	}

	public PreferLocation(int preferLocationNo, String address1, String address2, String memberId, Member member) {
		super();
		this.preferLocationNo = preferLocationNo;
		this.address1 = address1;
		this.address2 = address2;
		this.memberId = memberId;
		this.member = member;
	}

	public int getPreferLocationNo() {
		return preferLocationNo;
	}

	public void setPreferLocationNo(int preferLocationNo) {
		this.preferLocationNo = preferLocationNo;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
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
		return "PreferLocation [preferLocationNo=" + preferLocationNo + ", address1=" + address1 + ", address2="
				+ address2 + ", memberId=" + memberId + ", member=" + member + "]";
	}

}
