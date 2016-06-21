package kr.co.udongca.vo;

public class MajorCategory {

	private int majorCategoryNo;
	private String address1;

	public MajorCategory() {
	}

	public MajorCategory(int majorCategoryNo, String address1) {
		super();
		this.majorCategoryNo = majorCategoryNo;
		this.address1 = address1;
	}
	
	public int getMajorCategoryNo() {
		return majorCategoryNo;
	}

	public void setMajorCategoryNo(int majorCategoryNo) {
		this.majorCategoryNo = majorCategoryNo;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}


	@Override
	public String toString() {
		return "MajorCategory [majorCategoryNo=" + majorCategoryNo + ", address1=" + address1 + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((address1 == null) ? 0 : address1.hashCode());
		result = prime * result + majorCategoryNo;
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
		MajorCategory other = (MajorCategory) obj;
		if (address1 == null) {
			if (other.address1 != null)
				return false;
		} else if (!address1.equals(other.address1))
			return false;
		if (majorCategoryNo != other.majorCategoryNo)
			return false;
		return true;
	}
}
