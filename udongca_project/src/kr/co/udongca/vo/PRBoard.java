package kr.co.udongca.vo;

import java.io.Serializable;
import java.sql.Date;

public class PRBoard implements Serializable{
	
	private int cafeNo;
	private String cafeName;
	private String cafeIntro;
	private String cafeTel;
	private String cafeFeature;
	private String cafeAddress;
	private String coporateNumber;
	private String operationHour;
	private String managerName;
	private String managerTel;
	private String cafeRealImage;
	private String cafeFakeImage;
	private String memberId;
	private int cafeRating;
	private int cafeReviewCount;
	private Date registrationDate;
	private Member member;
	
	public PRBoard(){}
	
	public PRBoard(int cafeNo, String cafeName, String cafeIntro, String cafeTel, String cafeFeature,
			String cafeAddress, String coporateNumber, String operationHour, String managerName, String managerTel,
			String cafeRealImage, String cafeFakeImage, String memberId, int cafeRating, int cafeReviewCount,
			Date registrationDate) {
		super();
		this.cafeNo = cafeNo;
		this.cafeName = cafeName;
		this.cafeIntro = cafeIntro;
		this.cafeTel = cafeTel;
		this.cafeFeature = cafeFeature;
		this.cafeAddress = cafeAddress;
		this.coporateNumber = coporateNumber;
		this.operationHour = operationHour;
		this.managerName = managerName;
		this.managerTel = managerTel;
		this.cafeRealImage = cafeRealImage;
		this.cafeFakeImage = cafeFakeImage;
		this.memberId = memberId;
		this.cafeRating = cafeRating;
		this.cafeReviewCount = cafeReviewCount;
		this.registrationDate = registrationDate;
	}

	public int getCafeNo() {
		return cafeNo;
	}

	public String getCafeName() {
		return cafeName;
	}

	public String getCafeIntro() {
		return cafeIntro;
	}

	public String getCafeTel() {
		return cafeTel;
	}

	public String getCafeFeature() {
		return cafeFeature;
	}

	public String getCafeAddress() {
		return cafeAddress;
	}

	public String getCoporateNumber() {
		return coporateNumber;
	}

	public String getOperationHour() {
		return operationHour;
	}

	public String getManagerName() {
		return managerName;
	}

	public String getManagerTel() {
		return managerTel;
	}

	public String getCafeRealImage() {
		return cafeRealImage;
	}

	public String getCafeFakeImage() {
		return cafeFakeImage;
	}

	public String getMemberId() {
		return memberId;
	}

	public int getCafeRating() {
		return cafeRating;
	}

	public int getCafeReviewCount() {
		return cafeReviewCount;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public Member getMember() {
		return member;
	}

	public void setCafeNo(int cafeNo) {
		this.cafeNo = cafeNo;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public void setCafeIntro(String cafeIntro) {
		this.cafeIntro = cafeIntro;
	}

	public void setCafeTel(String cafeTel) {
		this.cafeTel = cafeTel;
	}

	public void setCafeFeature(String cafeFeature) {
		this.cafeFeature = cafeFeature;
	}

	public void setCafeAddress(String cafeAddress) {
		this.cafeAddress = cafeAddress;
	}

	public void setCoporateNumber(String coporateNumber) {
		this.coporateNumber = coporateNumber;
	}

	public void setOperationHour(String operationHour) {
		this.operationHour = operationHour;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public void setManagerTel(String managerTel) {
		this.managerTel = managerTel;
	}

	public void setCafeRealImage(String cafeRealImage) {
		this.cafeRealImage = cafeRealImage;
	}

	public void setCafeFakeImage(String cafeFakeImage) {
		this.cafeFakeImage = cafeFakeImage;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public void setCafeRating(int cafeRating) {
		this.cafeRating = cafeRating;
	}

	public void setCafeReviewCount(int cafeReviewCount) {
		this.cafeReviewCount = cafeReviewCount;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((registrationDate == null) ? 0 : registrationDate.hashCode());
		result = prime * result + ((cafeAddress == null) ? 0 : cafeAddress.hashCode());
		result = prime * result + ((cafeFakeImage == null) ? 0 : cafeFakeImage.hashCode());
		result = prime * result + ((cafeFeature == null) ? 0 : cafeFeature.hashCode());
		result = prime * result + ((cafeIntro == null) ? 0 : cafeIntro.hashCode());
		result = prime * result + ((cafeName == null) ? 0 : cafeName.hashCode());
		result = prime * result + cafeNo;
		result = prime * result + cafeRating;
		result = prime * result + ((cafeRealImage == null) ? 0 : cafeRealImage.hashCode());
		result = prime * result + cafeReviewCount;
		result = prime * result + ((cafeTel == null) ? 0 : cafeTel.hashCode());
		result = prime * result + ((coporateNumber == null) ? 0 : coporateNumber.hashCode());
		result = prime * result + ((managerName == null) ? 0 : managerName.hashCode());
		result = prime * result + ((managerTel == null) ? 0 : managerTel.hashCode());
		result = prime * result + ((member == null) ? 0 : member.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((operationHour == null) ? 0 : operationHour.hashCode());
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
		PRBoard other = (PRBoard) obj;
		if (registrationDate == null) {
			if (other.registrationDate != null)
				return false;
		} else if (!registrationDate.equals(other.registrationDate))
			return false;
		if (cafeAddress == null) {
			if (other.cafeAddress != null)
				return false;
		} else if (!cafeAddress.equals(other.cafeAddress))
			return false;
		if (cafeFakeImage == null) {
			if (other.cafeFakeImage != null)
				return false;
		} else if (!cafeFakeImage.equals(other.cafeFakeImage))
			return false;
		if (cafeFeature == null) {
			if (other.cafeFeature != null)
				return false;
		} else if (!cafeFeature.equals(other.cafeFeature))
			return false;
		if (cafeIntro == null) {
			if (other.cafeIntro != null)
				return false;
		} else if (!cafeIntro.equals(other.cafeIntro))
			return false;
		if (cafeName == null) {
			if (other.cafeName != null)
				return false;
		} else if (!cafeName.equals(other.cafeName))
			return false;
		if (cafeNo != other.cafeNo)
			return false;
		if (cafeRating != other.cafeRating)
			return false;
		if (cafeRealImage == null) {
			if (other.cafeRealImage != null)
				return false;
		} else if (!cafeRealImage.equals(other.cafeRealImage))
			return false;
		if (cafeReviewCount != other.cafeReviewCount)
			return false;
		if (cafeTel == null) {
			if (other.cafeTel != null)
				return false;
		} else if (!cafeTel.equals(other.cafeTel))
			return false;
		if (coporateNumber == null) {
			if (other.coporateNumber != null)
				return false;
		} else if (!coporateNumber.equals(other.coporateNumber))
			return false;
		if (managerName == null) {
			if (other.managerName != null)
				return false;
		} else if (!managerName.equals(other.managerName))
			return false;
		if (managerTel == null) {
			if (other.managerTel != null)
				return false;
		} else if (!managerTel.equals(other.managerTel))
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
		if (operationHour == null) {
			if (other.operationHour != null)
				return false;
		} else if (!operationHour.equals(other.operationHour))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PRBoard [cafeNo=" + cafeNo + ", cafeName=" + cafeName + ", cafeIntro=" + cafeIntro + ", cafeTel="
				+ cafeTel + ", cafeFeature=" + cafeFeature + ", cafeAddress=" + cafeAddress + ", coporateNumber="
				+ coporateNumber + ", operationHour=" + operationHour + ", managerName=" + managerName + ", managerTel="
				+ managerTel + ", cafeRealImage=" + cafeRealImage + ", cafeFakeImage=" + cafeFakeImage + ", memberId="
				+ memberId + ", cafeRating=" + cafeRating + ", cafeReviewCount=" + cafeReviewCount
				+ ", registrationDate=" + registrationDate + ", member=" + member + "]";
	}
}