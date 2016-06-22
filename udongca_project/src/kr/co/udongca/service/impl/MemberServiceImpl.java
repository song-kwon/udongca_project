package kr.co.udongca.service.impl;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao dao;
	
	@Override
	public Member login(String id, String password) throws Exception {
		Member login = dao.login(id, password);
		System.out.println(login);
		if(login == null){
			System.out.println("로그인 실패");
			throw new Exception();
		}
		return login;
	}
	
	@Override
	public int memberModify(String name, String password, HttpSession session) {
		Member modifyMember = (Member)session.getAttribute("login");
		modifyMember.setMemberName(name);
		if(password != null) modifyMember.setMemberPassword(password);
		
		return dao.memberModify(modifyMember);
	}
	
	@Override
	public int countSameId(String memberId){
		return dao.countSameId(memberId);
	}
	
	@Override
	public Member findById(String memberId){
		return dao.findById(memberId);
	}
	
	@Override
	public int generalMemberJoin(Member member){
		return dao.insertGeneralMember(member);
	}
	
	@Override
	public int licenseeMemberJoin(Member member){
		return dao.insertLicenseeMember(member);
	}
}
