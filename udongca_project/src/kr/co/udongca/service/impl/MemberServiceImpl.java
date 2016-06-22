package kr.co.udongca.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PreferLocation;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDaoImpl;

	@Override
	public Member login(String id, String password) throws Exception {
		Member login = memberDaoImpl.login(id, password);
		System.out.println(login);
		if (login == null) {
			System.out.println("로그인 실패");
			throw new Exception();
		}
		return login;
	}

	@Override
	public int memberModify(String name, String password, HttpSession session) {
		Member modifyMember = (Member) session.getAttribute("login");
		modifyMember.setMemberName(name);
		if (password != null)
			modifyMember.setMemberPassword(password);

		return memberDaoImpl.memberModify(modifyMember);
	}

	@Override
	public List<Address> majorList() {
		return memberDaoImpl.selectMajor();
	}
	
	@Override
	public List<Address> middleList(int majorNo) {
		// TODO Auto-generated method stub
		return memberDaoImpl.selectMiddle(majorNo);
	}
	
	public int countSameId(String memberId) {
		return memberDaoImpl.countSameId(memberId);
	}

	@Override
	public Member findById(String memberId) {
		return memberDaoImpl.findById(memberId);
	}

	@Override
	public int generalMemberJoin(Member member) {
		return memberDaoImpl.insertGeneralMember(member);
	}

	@Override
	public int licenseeMemberJoin(Member member) {
		return memberDaoImpl.insertLicenseeMember(member);
	}
	public List<Member> memberList(){
	    return memberDaoImpl.selectList();
	}
	
	@Override
	public int managePreferLocation(PreferLocation location) {
		if(memberDaoImpl.countPreferLocationByMemberId(location.getMemberId()) ==0)
			return memberDaoImpl.addPreferLocationByMemberId(location);
		else
			return memberDaoImpl.updatePreferLocationByMemberId(location);
		
	}
	
	@Override
	public List myPreferLocation(String memberId) {
		if(memberDaoImpl.countPreferLocationByMemberId(memberId)!=0){
			Map map = memberDaoImpl.selectPreferLocationByMemberId(memberId);
			List list = new ArrayList<>();
			for(int i = 1 ; i <= 3 ; i++ ){
				int no =(int) map.get("address"+i);
				list.add(memberDaoImpl.selectPreferLocationByMiddleCategoryNo(no));
			}
			return list;
		}
		return null;
	}
	
	@Override
	public ModelAndView myPreferLocationPage(String memberId) {
		Map map = new HashMap<>();
		
		List majorCategory = majorList();
		
		List myLocationList = myPreferLocation(memberId);
		map.put("majorList", majorCategory);
		
		if(myLocationList == null){
			return new ModelAndView("member/member_preferLocation_form.tiles","category",map);
		}
		
		List middleCategory = new ArrayList<>();
		
		for(int idx= 0; idx< myLocationList.size(); idx++){
			if(myLocationList.get(idx) != null){
				Address address = (Address)myLocationList.get(idx);
				middleCategory.add(middleList(address.getMajorCategoryNo()));
			}
		}
		
		map.put("myLocationList", myLocationList);
		map.put("middleList", middleCategory);
		return new ModelAndView("member/member_preferLocation_form.tiles","category",map);
	}
	
	@Override
	public int memberDrop(String memberId) {
		return memberDaoImpl.memberDrop(memberId);
	}
	
	@Override
	public ModelAndView memberIdFind(Member member) {
		ModelAndView mav = null;
		if(memberDaoImpl.countMemberIdFind(member)==0){
			mav = new ModelAndView("/udongca_project/memberId_find_form.udc","error","가입 정보가 없습니다.");
			return mav;
		}else{
			System.out.println(memberDaoImpl.memberIdFind(member));
			mav= new ModelAndView("/udongca_project/member/memberId_find_success_form.udc","success",memberDaoImpl.memberIdFind(member));
			System.out.println(mav);
			return mav;
		}
	}
}
