package kr.co.udongca.service;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PreferLocation;

public interface MemberService {

	public Member login(String id, String password);

	public int memberModify(String name, String password, HttpSession session);

	public List<Address> majorList();

	public int generalMemberJoin(Member member);

	public int licenseeMemberJoin(Member member);

	public int countSameId(String memberId);

	public Member findById(String memberId);

	public List<Address> middleList(int majorNo);

	public List<Member> memberList(int page);

	public int managePreferLocation(PreferLocation location);

	public List myPreferLocation(String memberId);

	public ModelAndView myPreferLocationPage(String memberId);

	public int memberDrop(String memberId);
	
	public String memberIdFind(Member member,String title) throws UnsupportedEncodingException;

	public Member memberIdMaster(String memberId);

	public List loginPossibility(String code);

	public int memberUpdateMaster(Member member);

	public String memberPasswordFind(Member member,String title) throws UnsupportedEncodingException;

	public Map memberInquiryList(int page, String memberId);

	public int loginPossible(Member member);

	public PagingBean page(int page);

	public Map memberPRBoardList(int page, String memberId);
	
	public List selectMemberPreferLocationAddress(String memberId);
	
	public List memberReportList(int page,String memberId);

	public Member findByEmail(String memberEmail);

	public int countSameEmail(String memberEmail);
}
