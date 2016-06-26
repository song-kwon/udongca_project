package kr.co.udongca.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.SendEmailConfig;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.validator.GeneralMemberValidator;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PreferLocation;

@Controller
@RequestMapping("/member/")
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
	    if (login.getMemberType().equals("master"))
		return "master/master_page.tiles";
	    else
		return "member/mypage.tiles";
	} else {
	    return "redirect:/loginPage.udc";
	}
    }

    @RequestMapping("master_page.udc")
    public ModelAndView masterPage(HttpSession session) {
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master"))
	    return new ModelAndView("/master/master_page.tiles");
	else
	    return new ModelAndView("loginPage.udc","error"," 마스터 로그인이 필요합니다.");
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
		if (login == null || login.getLoginPossibility().equals("Impossible")) {
			return new ModelAndView("login.tiles", "error", "회원이 아니거나 정지된 회원입니다.");
		} else {
			session.setAttribute("login", login);
			return new ModelAndView("main.tiles");
		}
	}

    @RequestMapping("memberId_find_success.udc")
    public ModelAndView memberIdFindSuccess(Member success) {
	return new ModelAndView("/member_find_success_form.udc", "success", success);
    }

    

    @RequestMapping("memberInfoMaster.udc")
    public String memberInfoMaster(@RequestParam("id") String id ,@RequestParam(value="page",required=false,defaultValue="1") int page, HttpSession session, Model model) {
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master")){
	       	model.addAttribute("memberInfo", memberService.memberIdMaster(id));
        	model.addAttribute("code", memberService.loginPossibility("login_possibility"));
        	model.addAttribute("page",page);
        	return "master/master_memberInfo.tiles";
	}else{
	    return "redirect:/main.udc"; 
	}
    }
    @RequestMapping("memberUpdate.udc")
    public String memberUpdate(@RequestParam("page") String page, @ModelAttribute Member member,Model model,HttpSession session,
	    BindingResult errors) {
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master")){
	    if (errors.hasErrors()) {
		return "redirect:/member/memberInfoMaster.udc?id="+member.getMemberId()+"&page="+page;
	    } else {
		int a = memberService.memberUpdateMaster(member);
		return "redirect:/member/memberListPaging.udc?pnum=" + page +"&success="+a;
	    }
	}else{
	    return "redirect:/main.udc"; 
	}
    }
	@RequestMapping("generalMemberJoin.udc")
	public String generalMemberJoin(@ModelAttribute("member") @Valid Member member, String emailAddress,
			BindingResult errors) throws UnsupportedEncodingException {
		if (errors.hasErrors()) {
			return "generalMemberJoinform.tiles";
		} else {
			String email = member.getMemberEmail() + "@" + emailAddress;
			member.setMemberEmail(email);
			memberService.generalMemberJoin(member);
			String memberId = member.getMemberId();
			
			SendEmailConfig sendEmail = new SendEmailConfig();
			sendEmail.sendEmail(member, "<a href='http://127.0.0.1:5000/udongca_project/member/memberLoginPossible.udc?memberId="+memberId+"'><input type='button' value='이메일 인증 완료'></a>");
			return "redirect:/member/joinSuccess.udc?memberId=" + memberId;
		}
	}

	@RequestMapping("licenseeMemberJoin.udc")
	public String licenseeMemberJoin(@ModelAttribute("member") @Valid Member member, String emailAddress,
			BindingResult errors) throws UnsupportedEncodingException {
		if (errors.hasErrors()) {
			return "licenseeMemberJoinform.tiles";
		} else {
			String email = member.getMemberEmail() + "@" + emailAddress;
			member.setMemberEmail(email);
			memberService.licenseeMemberJoin(member);
			
			String memberId = member.getMemberId();
			
			SendEmailConfig sendEmail = new SendEmailConfig();
			sendEmail.sendEmail(member, "<a href='http://127.0.0.1:5000/udongca_project/member/memberLoginPossible.udc?memberId="+memberId+"'><input type='button' value='이메일 인증 완료'></a>");
			return "redirect:/member/joinSuccess.udc?memberId=" + member.getMemberId();
		}
	}
	
	@RequestMapping("memberLoginPossible.udc")
	public ModelAndView memberLoginPossible(String memberId){
		Member member = memberService.findById(memberId);
		memberService.loginPossible(member);
		return new ModelAndView("loginPossible.tiles", "member", member);
	}

	@RequestMapping("joinSuccess.udc")
	public ModelAndView joinSuccess(String memberId) {
		Member member = memberService.findById(memberId);
		return new ModelAndView("joinSuccess.tiles", "member", member);
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
	public String memberModifyForm(HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login != null && !login.getMemberType().equals("master"))
			return "member/member_modify_form.tiles";
		else
			return "redirect:/loginPage.udc";
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
			mav = new ModelAndView("loginPage.udc", "error", "로그인이 필요하다네");
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
		System.out.println(location[0]+" "+location[1]+" "+location[2]);
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

	@RequestMapping("memberList.udc")
	@ResponseBody
	public List<Member> memberList() {
		return memberService.memberList();
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
	public ModelAndView memberIdFind(String memberName, String memberEmail, String emailAddress)
			throws UnsupportedEncodingException {
		Member findMember = new Member();
		findMember.setMemberName(memberName);
		findMember.setMemberEmail(memberEmail + "@" + emailAddress);
		return memberService.memberIdFind(findMember);
	}
	@RequestMapping("memberListPaging.udc")
	    public String memberListPageing(@RequestParam(required = false) String pnum, Model model,HttpSession session) {
		int page = 1;
		Member master = (Member) session.getAttribute("login");
		if (master != null && master.getMemberType().equals("master")){
		try {
		    page = Integer.parseInt(pnum);
		} catch (Exception e) {}
		try {
		    Map<String, Object> map = memberService.memberList(page);
		    model.addAttribute("page",page);
		    model.addAttribute("map",map);
		    return "master/master_memberList.tiles";
		} catch (Exception e) {
		    e.printStackTrace();
		    return "error.tiles";
		}
		}else{
		    return "redirect:/main.udc"; 
		}
	    }
	@RequestMapping("memberPassword_find.udc")
	public ModelAndView memberPasswordFind(String memberId, String memberName, String memberEmail, String emailAddress)
			throws UnsupportedEncodingException {
		Member findMember = new Member();
		findMember.setMemberId(memberId);
		findMember.setMemberName(memberName);
		findMember.setMemberEmail(memberEmail + "@" + emailAddress);
		return memberService.memberPasswordFind(findMember);
	}
	
	@RequestMapping("memberInquiryListPaging.udc")
	public ModelAndView memberInquiryListPageing(@RequestParam(required = false) String pnum,HttpSession session) {
		Member login = (Member)session.getAttribute("login");
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			Map<String, Object> map = memberService.memberInquiryList(page,login.getMemberId());
			return new ModelAndView("member/member_inquiryList.tiles", map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("error.tiles", "error_message", e.getMessage());
		}
	}
}
