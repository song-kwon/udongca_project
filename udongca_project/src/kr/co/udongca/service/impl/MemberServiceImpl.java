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
		if(password != null) modifyMember.setMemberPassword(password);
		
		return memberDaoImpl.memberModify(modifyMember);
	}

	@Override
	public List<Address> majorList() {
		return memberDaoImpl.selectMajor();
	}
	
	@Override
	public int countSameId(String memberId){
		return memberDaoImpl.countSameId(memberId);
	}
	public List<Address> middleList(int majorNo) {
		// TODO Auto-generated method stub
		return memberDaoImpl.selectMiddle(majorNo);
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
	
	@Override
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
		
		List majorCategory = majorList();
		
		List myLocationList = myPreferLocation(memberId);
		List middleCategory = new ArrayList<>();
		
		for(int idx= 0; idx< myLocationList.size(); idx++){
			if(myLocationList.get(idx) != null){
				Address address = (Address)myLocationList.get(idx);
				middleCategory.add(middleList(address.getMajorCategoryNo()));
			}
		}
		System.out.println(myLocationList.get(0));
		Map map = new HashMap<>();
		map.put("majorList", majorCategory);
		map.put("myLocationList", myLocationList);
		map.put("middleList", middleCategory);
		return new ModelAndView("member/member_preferLocation_form.tiles","category",map);
	}
}
