package kr.co.udongca.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.udongca.vo.Member;

public class GeneralMemberValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return clazz.isAssignableFrom(Member.class);
	}

	@Override
	public void validate(Object target, Errors errors) {
		Member member = (Member)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberId", "", "아이디를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberPassword", "", "패스워드를 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberName", "", "이름을 입력해주세요.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "memberEmail", "", "이메일을 입력해주세요.");
		
		if(member.getMemberId().length()<6){
			errors.rejectValue("id", "", "아이디는 6글자 이상입니다.");
		}
		if(member.getMemberPassword().length()<8){
			errors.rejectValue("password", "", "패스워드는 8글자 이상입니다.");
		}
	}
	
}
