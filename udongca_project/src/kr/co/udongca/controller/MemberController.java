package kr.co.udongca.controller;

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

    @RequestMapping("login.udc")
    public String login(String id, String password, HttpSession session) throws Exception {
	Member login = memberService.login(id, password);
	if (login.getLoginPossibility().equals("false")) {
	    return "redirect:/loginPage.udc";
	} else {
	    session.setAttribute("login", login);
	    return "redirect:/main.udc";
	}
    }

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
    public String masterPage(HttpSession session) {
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master"))
	    return "master/master_page.tiles";
	else
	    return "redirect:/main.udc";
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

    @RequestMapping("generalMemberJoin.udc")
    public String generalMemberJoin(@ModelAttribute("member") @Valid Member member, String emailAddress,
	    BindingResult errors) {
	if (errors.hasErrors()) {
	    return "generalMemberJoinform.tiles";
	} else {
	    String email = member.getMemberEmail() + "@" + emailAddress;
	    member.setMemberEmail(email);
	    memberService.generalMemberJoin(member);
	    return "redirect:/member/joinSuccess.udc?memberId=" + member.getMemberId();
	}
    }

    @RequestMapping("licenseeMemberJoin.udc")
    public String licenseeMemberJoin(@ModelAttribute("member") @Valid Member member, String emailAddress,
	    BindingResult errors) {
	if (errors.hasErrors()) {
	    return "licenseeMemberJoinform.tiles";
	} else {
	    String email = member.getMemberEmail() + "@" + emailAddress;
	    member.setMemberEmail(email);
	    memberService.generalMemberJoin(member);
	    return "redirect:/member/joinSuccess.udc?memberId=" + member.getMemberId();
	}
    }

    @RequestMapping("joinSuccess.udc")
    public ModelAndView joinSuccess(String memberId) {
	Member member = memberService.findById(memberId);
	return new ModelAndView("joinSuccess.tiles", "member", member);
    }

    @RequestMapping("member_modify_form.udc")
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

    @RequestMapping("modify_form.udc")
    public String memberModifyForm(HttpSession session) {
	Member login = (Member) session.getAttribute("login");
	if (login != null && !login.getMemberType().equals("master"))
	    return "member/member_modify.tiles";
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
	Member login = (Member) session.getAttribute("login");
	if (login != null && !login.getMemberType().equals("master")) {

	    ModelAndView mav = memberService.myPreferLocationPage(login.getMemberId());

	    return mav;
	} else {
	    return null;
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
    public ModelAndView memberIdFind(String memberName, String memberEmail, String emailAddress) {
	Member findMember = new Member();
	findMember.setMemberName(memberName);
	findMember.setMemberEmail(memberEmail + "@" + emailAddress);

	return memberService.memberIdFind(findMember);
    }

    @RequestMapping("memberId_find_success.udc")
    public ModelAndView memberIdFindSuccess(Member success) {
	return new ModelAndView("/member_find_success_form.udc", "success", success);
    }

    @RequestMapping("memberListPaging.udc")
    public ModelAndView memberListPageing(@RequestParam(required = false) String pnum, Model model) {
	int page = 1;
	try {
	    page = Integer.parseInt(pnum);
	    System.out.println(pnum);
	} catch (Exception e) {
	}
	try {
	    Map<String, Object> map = memberService.memberList(page);
	    model.addAttribute("page",page);
	    return new ModelAndView("memberListPaging.tilse", map);
	} catch (Exception e) {
	    e.printStackTrace();
	    return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
	}
    }

    @RequestMapping("memberInfoMaster.udc")
    public String memberInfoMaster(@RequestParam("id") String id ,@RequestParam(value="page",required=false,defaultValue="1") int page, Model model) {
	model.addAttribute("memberInfo", memberService.memberIdMaster(id));
	model.addAttribute("code", memberService.loginPossibility("login_possibility"));
	model.addAttribute("page",page);
	return "master/master_memberInfo.tiles";
    }
    @RequestMapping("memberUpdate.udc")
    public String memberUpdate(@RequestParam("page") String page, @ModelAttribute Member member,
	    BindingResult errors) {
	GeneralMemberValidator validator = new GeneralMemberValidator();
	validator.validate(member, errors);
	if (errors.hasErrors()) {
	    System.out.println(5);
	    System.out.println(member);
	    return "redirect:/member/memberInfoMaster.udc?id="+member.getMemberId()+"&page="+page;
	} else {
	    System.out.println(member);
	    int a = memberService.memberUpdateMaster(member);
	    System.out.println(a);
	    return "redirect:/member/memberListPaging.udc?pnum=" + page;
	}
    }

}
