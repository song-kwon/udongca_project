package kr.co.udongca.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.SendEmailConfig;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PreferLocation;

@Controller
@RequestMapping({ "/member/", "/", "/master/" })
public class MemberController {

	@Autowired
	private MemberService memberService;

	@RequestMapping("logout.udc")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main.udc";
	}

	@RequestMapping("member_myPage.udc")
	public String myPage(HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login != null) {
			if (login.getMemberType().equals("master")) {
				return "master/master_page.tiles";
			} else {
				return "member/mypage.tiles";
			}
		} else {
			return "redirect:/loginPage.udc";
		}
	}

	@RequestMapping("master_page.udc")
	public ModelAndView masterPage(HttpSession session) {
		Member master = (Member) session.getAttribute("login");
		if (master != null && master.getMemberType().equals("master"))
			return new ModelAndView("master/master_page.tiles");
		else
			return new ModelAndView("/loginPage.udc", "error", " 마스터 로그인이 필요합니다.");
	}

	@RequestMapping("countSameId.udc")
	@ResponseBody
	public String countSameId(String memberId) {
		String number = "" + memberService.countSameId(memberId);
		return number;
	}

	@RequestMapping("findById.udc")
	public Member findById(String memberId) {
		Member member = memberService.findById(memberId);
		return member;
	}

	@RequestMapping("login.udc")
	public ModelAndView login(String id, String password, HttpSession session) throws Exception {
		Member login = memberService.login(id, password);
		if (login == null || login.getLoginPossibility().equals("impossible")) {
			return new ModelAndView("etc/login.tiles", "error", "회원이 아니거나 정지된 회원입니다.");
		} else if (session.getAttribute("login") != null) {
			return new ModelAndView("redirect:/main.udc");
		} else {
			session.setAttribute("login", login);

			// 메인 화면 뿌려줄 카페 , 공지, 리뷰 리스트 받아오기
			return new ModelAndView("redirect:/main.udc");
		}
	}

	@RequestMapping("memberInfoMaster.udc")
	@ResponseBody
	public Map memberInfoMaster(@RequestParam("id") String id, HttpSession session, Model model) {
		Member master = (Member) session.getAttribute("login");
		HashMap map = new HashMap();
		if (master != null && master.getMemberType().equals("master")) {
			map.put("memberInfo", memberService.memberIdMaster(id));
			map.put("code", memberService.loginPossibility("login_possibility"));
			return map;
		} else {
			return map;
		}
	}

	@RequestMapping("memberUpdate.udc")
	@ResponseBody
	@Transactional
	public String memberUpdate(@ModelAttribute Member member, HttpSession session) {
		Member master = (Member) session.getAttribute("login");
		if (master != null && master.getMemberType().equals("master")) {
			if (memberService.memberUpdateMaster(member) == 1) {
				return "true";
			} else {
				return "false";
			}
		} else {
			return "권한이 없습니다.";
		}
	}

	@RequestMapping("generalMemberJoin.udc")
	public String generalMemberJoin(@ModelAttribute("member") @Valid Member member, String emailAddress,
			BindingResult errors) throws UnsupportedEncodingException {
		if (errors.hasErrors()) {
			return "member/generalMemberJoinform.tiles";
		} else {
			String email = member.getMemberEmail() + "@" + emailAddress;
			member.setMemberEmail(email);
			memberService.generalMemberJoin(member);
			String memberId = member.getMemberId();

			SendEmailConfig sendEmail = new SendEmailConfig();
			sendEmail.sendEmail(member,
					"<a href='http://192.168.0.116:5000/udongca_project/member/memberLoginPossible.udc?memberId="
							+ memberId + "'><input type='button' value='이메일 인증 완료'></a>",
					"회원가입 - 이메일 인증");
			return "redirect:/member/joinSuccess.udc?memberId=" + memberId;
		}
	}

	@RequestMapping("licenseeMemberJoin.udc")
	public String licenseeMemberJoin(@ModelAttribute("member") @Valid Member member, String emailAddress,
			BindingResult errors) throws UnsupportedEncodingException {
		if (errors.hasErrors()) {
			return "member/licenseeMemberJoinform.tiles";
		} else {
			String email = member.getMemberEmail() + "@" + emailAddress;
			member.setMemberEmail(email);
			memberService.licenseeMemberJoin(member);

			String memberId = member.getMemberId();

			SendEmailConfig sendEmail = new SendEmailConfig();
			sendEmail.sendEmail(member,
					"<a href='http://192.168.0.116:5000/udongca_project/member/memberLoginPossible.udc?memberId="
							+ memberId + "'><input type='button' value='이메일 인증 완료'></a>",
					"회원가입 - 이메일 인증");
			return "redirect:/member/joinSuccess.udc?memberId=" + member.getMemberId();
		}
	}

	@RequestMapping("memberLoginPossible.udc")
	public ModelAndView memberLoginPossible(String memberId) {
		Member member = memberService.findById(memberId);
		memberService.loginPossible(member);
		return new ModelAndView("etc/loginPossible.tiles", "member", member);
	}

	@RequestMapping("joinSuccess.udc")
	public ModelAndView joinSuccess(String memberId) {
		Member member = memberService.findById(memberId);
		return new ModelAndView("etc/joinSuccess.tiles", "member", member);
	}

	@RequestMapping("member_verify.udc")
	public String memberModify(HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login != null && !login.getMemberType().equals("master"))
			return "member/member_verify.tiles";
		else
			return "redirect:/loginPage.udc";
	}

	@RequestMapping("verify.udc")
	@ResponseBody
	public String passwordVerify(String id, String password, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (id.equals(login.getMemberId()) && password.equals(login.getMemberPassword())) {
			return "true";
		} else
			return "false";
	}

	@RequestMapping("member_modify_form.udc")
	public String memberModifyForm(@RequestParam(required = false, defaultValue = "false") String flag,
			HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login != null && !login.getMemberType().equals("master")) {
			if (flag.equals("true")) {
				return "member/member_modify_form.tiles";
			} else {
				return "redirect:/member_verify.udc";
			}
		} else {
			return "redirect:/loginPage.udc";
		}
	}

	@RequestMapping("member_modify.udc")
	@ResponseBody
	public String memberModify(String name, String password, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login != null && !login.getMemberType().equals("master")) {
			if (memberService.memberModify(name, password, session) == 1)
				return "success";
			else
				return "fail";
		} else {
			return "fail";
		}
	}

	@RequestMapping("member_preferLocation_form.udc")
	public ModelAndView PreferLocationPage(HttpSession session) {
		ModelAndView mav;
		Member login = (Member) session.getAttribute("login");
		if (login != null && !login.getMemberType().equals("master")) {
			mav = memberService.myPreferLocationPage(login.getMemberId());
			return mav;
		} else {
			mav = new ModelAndView("redirect:/loginPage.udc");
			return mav;
		}

	}

	@RequestMapping("majorCategory.udc")
	@ResponseBody
	public List<Address> majorList() {
		return memberService.majorList();
	}

	@RequestMapping("middleCategory.udc")
	@ResponseBody
	public List<Address> middleList(int majorNo) {
		return memberService.middleList(majorNo);
	}

	@RequestMapping("modify_preferLocation.udc")
	@ResponseBody
	public String modifyPreferLocation(int[] location, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		PreferLocation pl = new PreferLocation(0, location[0], location[1], location[2], login.getMemberId());
		if (login != null && !login.getMemberType().equals("master")) {
			memberService.managePreferLocation(pl);
			return "sucess";
		} else {
			return "fail";
		}

	}

	@RequestMapping("my_preferLocation.udc")
	@ResponseBody
	public List myPreferLocation(HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login != null && !login.getMemberType().equals("master")) {
			return memberService.myPreferLocation(login.getMemberId());
		} else {
			return null;
		}
	}

	@RequestMapping("member_drop.udc")
	public String memberDrop(HttpSession session) {
		Member login = (Member) session.getAttribute("login");

		if (login != null && !login.getMemberType().equals("master")) {
			memberService.memberDrop(login.getMemberId());
			session.invalidate();
			return "redirect:/main.udc";
		} else {
			return "redirect:/loginPage.udc";
		}
	}

	@RequestMapping("memberId_find.udc")
	@ResponseBody
	public String memberIdFind(String memberName, String memberEmail) throws UnsupportedEncodingException {
		Member findMember = new Member();
		findMember.setMemberName(memberName);
		findMember.setMemberEmail(memberEmail);
		return memberService.memberIdFind(findMember, "아이디 찾기");
	}

	@RequestMapping("memberList.udc")
	@ResponseBody
	public Map<String, Object> memberListPageing(
			@RequestParam(required = false) String pnum, Model model, HttpSession session) {
		int page = 1;
		Member master = (Member) session.getAttribute("login");
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (master != null && master.getMemberType().equals("master")) {
			try {
				page = Integer.parseInt(pnum);
			} catch (Exception e) {
			}
			map.put("list", memberService.memberList(page));
			map.put("page", memberService.page(page));
			return map;
		} else {
			map.put("권한", "권한이 없습니다.");
			return map;
		}
	}

	@RequestMapping("memberPassword_find.udc")
	@ResponseBody
	public String memberPasswordFind(String memberId, String memberName, String memberEmail, String emailAddress)
			throws UnsupportedEncodingException {
		Member findMember = new Member();
		findMember.setMemberId(memberId);
		findMember.setMemberName(memberName);
		findMember.setMemberEmail(memberEmail);
		return memberService.memberPasswordFind(findMember, "비밀번호 찾기");
	}

	@RequestMapping("memberInquiryListPaging.udc")
	public ModelAndView memberInquiryListPageing(@RequestParam(required = false) String pnum, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			Map<String, Object> map = memberService.memberInquiryList(page, login.getMemberId());
			return new ModelAndView("member/member_inquiryList.tiles", map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error.tiles", "error_message", e.getMessage());
		}
	}

	@RequestMapping("member_prBoard_list.udc")
	public ModelAndView memberPRBoardList(@RequestParam(required = false) String pnum, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			Map<String, Object> map = memberService.memberPRBoardList(page, login.getMemberId());
			return new ModelAndView("member/member_prBoard_list.tiles", map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error.tiles", "error_message", e.getMessage());
		}
	}

	@RequestMapping("member_myPage_loading.udc")
	@ResponseBody
	public Map memberMyPage(HttpSession session) {

		Map map = new HashMap<>();

		Member login = (Member) session.getAttribute("login");

		if (login == null) {
			map.put("loginError", "로그인이 필요한 페이지 입니다.");
			return map;
		}

		map.put("loginInfo", memberService.login(login.getMemberId(), login.getMemberPassword()));
		if (memberService.memberReportList(1, login.getMemberId()).size() == 0) {
			map.put("reportError", "신고 내역이 없습니다.");
		} else {
			map.put("reportList", memberService.memberReportList(1, login.getMemberId()));
		}
		map.put("inquiryList", memberService.memberInquiryList(1, login.getMemberId()));
		return map;
	}

}
