package kr.co.udongca.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import kr.co.udongca.vo.Member;

public class GeneralMemberValidator implements Validator{

	@Override
	public boolean supports(Class<?> arg0) {
		return false;
	}

	@Override
	public void validate(Object target, Errors errors) {
		Member member = (Member)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "id", "아이디를 입력해주세요.");
		
		if(member.getMemberPassword()==null || member.getMemberPassword().trim().isEmpty()){
			errors.rejectValue("password", "", "패스워드는 필수 입력사항입니다.");
		}
		
	}
	
}
