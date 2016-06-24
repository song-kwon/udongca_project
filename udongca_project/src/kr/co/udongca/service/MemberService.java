package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PreferLocation;

public interface MemberService {

	public Member login(String id, String password) throws Exception;

	public int memberModify(String name, String password, HttpSession session);
	

	public List<Address> majorList();

	public int generalMemberJoin(Member member);

	public int licenseeMemberJoin(Member member);

	public int countSameId(String memberId);

	public Member findById(String memberId);
	
	public List<Member> memberList();
	
	public List<Address> middleList(int majorNo);
	
	public Map<String, Object> memberList(int page);
	public int managePreferLocation(PreferLocation location);
	
	public List myPreferLocation(String memberId);
	
	public ModelAndView myPreferLocationPage(String memberId);
	
	public int memberDrop(String memberId);
	
	public ModelAndView memberIdFind(Member member);
	
	public Member memberIdMaster(String memberId);
	
	public List loginPossibility(String code);
	
	public int memberUpdateMaster(Member member);
}
