package kr.co.udongca.service.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	
	private SqlSessionTemplate session;
	
	@Autowired
	public MemberServiceImpl(SqlSessionTemplate session) {
		this.session=session;
	}
	
	public String test(){
		return "안녕";
	}
}
