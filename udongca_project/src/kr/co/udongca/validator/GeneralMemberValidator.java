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
		
		if(member.getMemberPenalty()>4 && member.getMemberPenalty()<0 ){
		    	errors.rejectValue("penalty", "","벌점은 0~3까지 입니다.");
		}
	}
	
	
}
