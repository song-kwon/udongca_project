package kr.co.udongca.vo;

import java.io.Serializable;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

public class Member implements Serializable{
	@NotEmpty(message="아이디를 입력해주세요.")
	@Length(min=6, max=10, message="아이디는 6~10자 사이만 가능합니다.")
	private String memberId;
	@NotEmpty(message="이름을 입력해주세요.")
	private String memberName;
	private String memberPassword;
	@NotEmpty(message="이메일을 입력해주세요.")
	private String memberEmail;
	@NotNull(message="벌점입력 해주세요")
	@Range(min=0,max=3,message="벌점은 0~3점 까지입니다.")
	private int memberPenalty;
	private String loginPossibility;
	private String memberType;
	
	public Member() {
	}
	
	public Member(String memberId,String memberPassword){
		this.memberId = memberId;
		this.memberPassword = memberPassword;
	}
	
	public Member(String memberId, String memberName, String memberPassword, String memberEmail, int memberPenalty,
			String loginPossibility) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.memberPassword = memberPassword;
		this.memberEmail = memberEmail;
		this.memberPenalty = memberPenalty;
		this.loginPossibility = loginPossibility;
	}

	public Member(String memberId, String memberName, String memberPassword, String memberEmail, int memberPenalty,
			String loginPossibility, String memberType) {
		super();
		this.memberId = memberId;
		this.memberName = memberName;
		this.memberPassword = memberPassword;
		this.memberEmail = memberEmail;
		this.memberPenalty = memberPenalty;
		this.loginPossibility = loginPossibility;
		this.memberType = memberType;
	}
	
	

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberPassword() {
		return memberPassword;
	}

	public void setMemberPassword(String memberPassword) {
		this.memberPassword = memberPassword;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public int getMemberPenalty() {
		return memberPenalty;
	}

	public void setMemberPenalty(int memberPenalty) {
		this.memberPenalty = memberPenalty;
	}

	public String getLoginPossibility() {
		return loginPossibility;
	}

	public void setLoginPossibility(String loginPossibility) {
		this.loginPossibility = loginPossibility;
	}

	public String getMemberType() {
		return memberType;
	}

	public void setMemberType(String memberType) {
		this.memberType = memberType;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((loginPossibility == null) ? 0 : loginPossibility.hashCode());
		result = prime * result + ((memberEmail == null) ? 0 : memberEmail.hashCode());
		result = prime * result + ((memberId == null) ? 0 : memberId.hashCode());
		result = prime * result + ((memberName == null) ? 0 : memberName.hashCode());
		result = prime * result + ((memberPassword == null) ? 0 : memberPassword.hashCode());
		result = prime * result + memberPenalty;
		result = prime * result + ((memberType == null) ? 0 : memberType.hashCode());
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
		Member other = (Member) obj;
		if (loginPossibility == null) {
			if (other.loginPossibility != null)
				return false;
		} else if (!loginPossibility.equals(other.loginPossibility))
			return false;
		if (memberEmail == null) {
			if (other.memberEmail != null)
				return false;
		} else if (!memberEmail.equals(other.memberEmail))
			return false;
		if (memberId == null) {
			if (other.memberId != null)
				return false;
		} else if (!memberId.equals(other.memberId))
			return false;
		if (memberName == null) {
			if (other.memberName != null)
				return false;
		} else if (!memberName.equals(other.memberName))
			return false;
		if (memberPassword == null) {
			if (other.memberPassword != null)
				return false;
		} else if (!memberPassword.equals(other.memberPassword))
			return false;
		if (memberPenalty != other.memberPenalty)
			return false;
		if (memberType == null) {
			if (other.memberType != null)
				return false;
		} else if (!memberType.equals(other.memberType))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberName=" + memberName + ", memberPassword=" + memberPassword
				+ ", memberEmail=" + memberEmail + ", memberPenalty=" + memberPenalty + ", loginPossibility="
				+ loginPossibility + ", memberType=" + memberType + "]";
	}
}
