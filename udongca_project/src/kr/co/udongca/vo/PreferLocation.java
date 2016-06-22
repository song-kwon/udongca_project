package kr.co.udongca.vo;

public class PreferLocation {

	private int preferLocationNo;
	private int address1;
	private int address2;
	private int address3;
	private String memberId;
	private Member member;

	public PreferLocation() {
	}

	public PreferLocation(int preferLocationNo, int address1, int address2, int address3, String memberId) {
		super();
		this.preferLocationNo = preferLocationNo;
		this.address1 = address1;
		this.address2 = address2;
		this.address3 = address3;
		this.memberId = memberId;
	}

	public PreferLocation(int preferLocationNo, int address1, int address2, int address3, String memberId,
			Member member) {
		super();
		this.preferLocationNo = preferLocationNo;
		this.address1 = address1;
		this.address2 = address2;
		this.address3 = address3;
		this.memberId = memberId;
		this.member = member;
	}

	public int getPreferLocationNo() {
		return preferLocationNo;
	}

	public void setPreferLocationNo(int preferLocationNo) {
		this.preferLocationNo = preferLocationNo;
	}

	public int getAddress1() {
		return address1;
	}

	public void setAddress1(int address1) {
		this.address1 = address1;
	}

	public int getAddress2() {
		return address2;
	}

	public void setAddress2(int address2) {
		this.address2 = address2;
	}

	public int getAddress3() {
		return address3;
	}

	public void setAddress3(int address3) {
		this.address3 = address3;
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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + address1;
		result = prime * result + address2;
		result = prime * result + address3;
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + preferLocationNo;
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
		PreferLocation other = (PreferLocation) obj;
		if (address1 != other.address1)
			return false;
		if (address2 != other.address2)
			return false;
		if (address3 != other.address3)
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
		if (preferLocationNo != other.preferLocationNo)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PreferLocation [preferLocationNo=" + preferLocationNo + ", address1=" + address1 + ", address2="
				+ address2 + ", address3=" + address3 + ", memberId=" + memberId + ", member=" + member + "]";
	}

	
}
