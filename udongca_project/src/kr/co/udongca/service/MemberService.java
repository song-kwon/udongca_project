package kr.co.udongca.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;

public interface MemberService {

	public Member login(String id, String password) throws Exception;

	public int memberModify(String name, String password, HttpSession session);

	public List<Address> AddressList();

	public int generalMemberJoin(Member member);

	public int licenseeMemberJoin(Member member);

	public int countSameId(String memberId);

	public Member findById(String memberId);
	
	public List<Member> memberList();
}
