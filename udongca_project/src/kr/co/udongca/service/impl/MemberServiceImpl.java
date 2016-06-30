package kr.co.udongca.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.SendEmailConfig;
import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.CodeDao;
import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.dao.impl.CodeDaoImpl;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PRBoard;
import kr.co.udongca.vo.PreferLocation;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDaoImpl;
	@Autowired
	private CodeDao codeDaoImpl;

	@Override
	public Member login(String id, String password) {
		if (memberDaoImpl.countSameId(id) == 0) {
			return null;
		} else {
			Member login = memberDaoImpl.login(id, password);
			return login;
		}
	}

	@Override
	public int loginPossible(Member member) {
		return memberDaoImpl.loginPossible(member);
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
	public int countSameId(String memberId) {
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

	public int generalMemberJoin(Member member) {
		return memberDaoImpl.insertGeneralMember(member);
	}

	@Override
	public int licenseeMemberJoin(Member member) {
		return memberDaoImpl.insertLicenseeMember(member);
	}

	
	public List memberList(int page) {
		List list = memberDaoImpl.selectList(page);
		
		return list;
	}
	public PagingBean page(int page){
	    return new PagingBean(memberDaoImpl.countMember(), page);
	}

	@Override
	public int managePreferLocation(PreferLocation location) {
		if (memberDaoImpl.countPreferLocationByMemberId(location.getMemberId()) == 0)
			return memberDaoImpl.addPreferLocationByMemberId(location);
		else
			return memberDaoImpl.updatePreferLocationByMemberId(location);

	}

	@Override
	public List myPreferLocation(String memberId) {
		if (memberDaoImpl.countPreferLocationByMemberId(memberId) != 0) {
			Map map = memberDaoImpl.selectPreferLocationByMemberId(memberId);
			List list = new ArrayList<>();
			for (int i = 1; i <= 3; i++) {
				int no = (int) map.get("address" + i);
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

		if (myLocationList == null) {
			return new ModelAndView("member/member_preferLocation_form.tiles", "category", map);
		}

		List middleCategory = new ArrayList<>();

		for (int idx = 0; idx < myLocationList.size(); idx++) {
			if (myLocationList.get(idx) != null) {
				Address address = (Address) myLocationList.get(idx);
				middleCategory.add(middleList(address.getMajorCategoryNo()));
			} else {
				middleCategory.add(null);
			}
		}
		map.put("myLocationList", myLocationList);
		map.put("middleList", middleCategory);
		return new ModelAndView("member/member_preferLocation_form.tiles", "category", map);
	}

	@Override
	public int memberDrop(String memberId) {
		return memberDaoImpl.memberDrop(memberId);
	}

	@Override
	public ModelAndView memberIdFind(Member member) throws UnsupportedEncodingException {
		ModelAndView mav = null;
		if (memberDaoImpl.countMemberIdFind(member) == 0) {
			mav = new ModelAndView("/WEB-INF/view/udongca-tiles/memberId_find_form.jsp", "error", "회원 정보가 없습니다.");
			return mav;
		} else {
			Member findMember = memberDaoImpl.memberIdFind(member);
			SendEmailConfig send = new SendEmailConfig();
			String content = String.format(
					"%s님의 아이디는 %s 입니다. <br> <a href='http://192.168.0.116:4322/udongca_project/'>우동카</a>로 이동",
					findMember.getMemberName(), findMember.getMemberId());
			send.sendEmail(findMember, content);
			mav = new ModelAndView("/WEB-INF/view/udongca-tiles/memberId_find_success_form.jsp", "success",
					memberDaoImpl.memberIdFind(member));
			return mav;
		}
	}

	public Member memberIdMaster(String memberId) {
		return memberDaoImpl.memberInfo(memberId);
	}

	public List loginPossibility(String code) {
		return codeDaoImpl.selectCode(code);
	}

	public int memberUpdateMaster(Member member) {
		return memberDaoImpl.memberUpdate(member);
	}

	@Override
	public ModelAndView memberPasswordFind(Member member) throws UnsupportedEncodingException {
		ModelAndView mav = null;
		if (memberDaoImpl.countMemberPasswordFind(member) == 0) {
			mav = new ModelAndView("/WEB-INF/view/udongca-tiles/memberPassword_find_form.jsp", "error", "회원 정보가 없습니다.");
			return mav;
		} else {
			Member findMember = memberDaoImpl.memberIdFind(member);
			SendEmailConfig send = new SendEmailConfig();
			String content = String.format(
					"%s님의 아이디는 %s , 비밀번호는 %s 입니다. <br> <a href='http://192.168.0.116:4322/udongca_project/'>우동카</a>로 이동",
					findMember.getMemberName(), findMember.getMemberId(), findMember.getMemberPassword());
			mav = new ModelAndView("/WEB-INF/view/udongca-tiles/memberPassword_find_success_form.jsp", "success",
					memberDaoImpl.memberIdFind(member));
			return mav;
		}
	}

	@Override
	public Map memberInquiryList(int page, String memberId) {
		HashMap map = new HashMap();

		if (memberDaoImpl.countMemberInquiryList(memberId) == 0) {
			map.put("error", "문의 내역이 없습니다.");
		}
			map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			List list = memberDaoImpl.memberInquriyList(map);
			PagingBean pagingBean = new PagingBean(memberDaoImpl.countMemberInquiryList(memberId), page);
			map.put("list", list);
			map.put("pageBean", pagingBean);
			return map;
	}
	
	@Override
	public Map memberPRBoardList(int page, String memberId) {
		HashMap map = new HashMap();
		if (memberDaoImpl.countMemberPRBoard(memberId) == 0) {
			map.put("error", "작성한 홍보글이 없습니다..");
		}
			map.put("itemsPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			List list = memberDaoImpl.memberPRBoardList(map);
			PagingBean pagingBean = new PagingBean(memberDaoImpl.countMemberInquiryList(memberId), page);
			map.put("list", list);
			map.put("pageBean", pagingBean);
			return map;
	}
}
