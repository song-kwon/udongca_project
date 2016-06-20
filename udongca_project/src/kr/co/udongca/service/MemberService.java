package kr.co.udongca.service;

import javax.servlet.http.HttpSession;

import kr.co.udongca.vo.Member;

public interface MemberService {

	public Member login(String id,String password) throws Exception;
	public int memberModify(String name, String password, HttpSession session);
}
