package kr.co.udongca.vo;

public class MiddleCategory {
	
	private int middleCategoryNo;
	private String address2;
	
	public MiddleCategory() {
		// TODO Auto-generated constructor stub
	}

	public MiddleCategory(int middleCategoryNo, String address2) {
		super();
		this.middleCategoryNo = middleCategoryNo;
		this.address2 = address2;
	}

	public int getMiddleCategoryNo() {
		return middleCategoryNo;
	}

	public void setMiddleCategoryNo(int middleCategoryNo) {
		this.middleCategoryNo = middleCategoryNo;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((address2 == null) ? 0 : address2.hashCode());
		result = prime * result + middleCategoryNo;
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
		MiddleCategory other = (MiddleCategory) obj;
		if (address2 == null) {
			if (other.address2 != null)
				return false;
		} else if (!address2.equals(other.address2))
			return false;
		if (middleCategoryNo != other.middleCategoryNo)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "MiddleCategory [middleCategoryNo=" + middleCategoryNo + ", address2=" + address2 + "]";
	}

	
	
}
