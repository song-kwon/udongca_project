package kr.co.udongca.vo;

import java.io.Serializable;

public class Address implements Serializable{
	private String AddressId;
	private String AddressName;
	
	public Address(){}
	public Address(String addressId, String addressName) {
		AddressId = addressId;
		AddressName = addressName;
	}
	
	public String getAddressId() {
		return AddressId;
	}
	public String getAddressName() {
		return AddressName;
	}
	public void setAddressId(String addressId) {
		AddressId = addressId;
	}
	public void setAddressName(String addressName) {
		AddressName = addressName;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((AddressId == null) ? 0 : AddressId.hashCode());
		result = prime * result + ((AddressName == null) ? 0 : AddressName.hashCode());
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
		if (AddressId == null) {
			if (other.AddressId != null)
				return false;
		} else if (!AddressId.equals(other.AddressId))
			return false;
		if (AddressName == null) {
			if (other.AddressName != null)
				return false;
		} else if (!AddressName.equals(other.AddressName))
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "Address [AddressId=" + AddressId + ", AddressName=" + AddressName + "]";
	}
}
