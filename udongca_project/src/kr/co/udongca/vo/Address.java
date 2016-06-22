package kr.co.udongca.vo;

import java.io.Serializable;

public class Address implements Serializable{
	private int majorCategoryNo;
	private int middleCategoryNo;
	private String AddressName;
	
	public Address(){}

	public Address(int majorCategoryNo, int middleCategoryNo, String addressName) {
		super();
		this.majorCategoryNo = majorCategoryNo;
		this.middleCategoryNo = middleCategoryNo;
		AddressName = addressName;
	}

	public int getMajorCategoryNo() {
		return majorCategoryNo;
	}

	public void setMajorCategoryNo(int majorCategoryNo) {
		this.majorCategoryNo = majorCategoryNo;
	}

	public int getMiddleCategoryNo() {
		return middleCategoryNo;
	}

	public void setMiddleCategoryNo(int middleCategoryNo) {
		this.middleCategoryNo = middleCategoryNo;
	}

	public String getAddressName() {
		return AddressName;
	}

	public void setAddressName(String addressName) {
		AddressName = addressName;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((AddressName == null) ? 0 : AddressName.hashCode());
		result = prime * result + majorCategoryNo;
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
		Address other = (Address) obj;
		if (AddressName == null) {
			if (other.AddressName != null)
				return false;
		} else if (!AddressName.equals(other.AddressName))
			return false;
		if (majorCategoryNo != other.majorCategoryNo)
			return false;
		if (middleCategoryNo != other.middleCategoryNo)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Address [majorCategoryNo=" + majorCategoryNo + ", middleCategoryNo=" + middleCategoryNo
				+ ", AddressName=" + AddressName + "]";
	}

	
}
