package kr.co.udongca.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.udongca.service.MemberService;
import kr.co.udongca.vo.Member;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	private MemberService memberService;

	@RequestMapping("login.udc")
	public String login(String id, String password,HttpSession session) throws Exception{
		session.setAttribute("login", memberService.login(id, password));
		return "redirect:/main.udc";
	}
	
	@RequestMapping("logout.udc")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/main.udc";
	}
	
	@RequestMapping("member_myPage.udc")
	public String myPage(HttpSession session){
		Member login = (Member)session.getAttribute("login");
		if(login != null){
			if(login.getMemberType().equals("master"))
				return "master_page.tiles";
			else
				return "myPage.tiles";
		}else{
		return "redirect:/loginPage.udc";
		}
	}
	
	@RequestMapping("master_page.udc")
	public String masterPage(HttpSession session){
		Member master = (Member)session.getAttribute("login");
		if(master != null && master.getMemberType().equals("master"))
			return "masterPage.tiles";
		else
			return "redirect:/main.udc";
	}
	
	@RequestMapping("generalMemberJoin.udc")
	public String generalMemberJoin(@ModelAttribute @Valid Member member){
		return "redirect:/joinSuccess.udc";
	}
	
	@RequestMapping("licenseeMemberJoin.udc")
	public String licenseeMemberJoin(@ModelAttribute @Valid Member member){
		return "redirect:/joinSuccess.udc";
	}
	
	@RequestMapping("member_modify_form.udc")
	public String memberModify(HttpSession session){
		Member login = (Member)session.getAttribute("login");
		if(login != null && !login.getMemberType().equals("master"))
			return "member_verify.tiles";
		else
			return "redirect:/login.udc";
	}
	
	@RequestMapping("verify.udc")
	@ResponseBody
	public String passwordVerify(String id, String password, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		if(id.equals(login.getMemberId()) && password.equals(login.getMemberPassword())){
			return "true";
		}else
			return "false";
	}
	
	@RequestMapping("modify_form.udc")
	public String memberModifyForm(HttpSession session){
		Member login=(Member)session.getAttribute("login");
		if(login != null && !login.getMemberType().equals("master"))
			return "member_modify.tiles";
		else
			return "redirect:/login.udc";
	}
	
	@RequestMapping("member_modify.udc")
	@ResponseBody
	public String memberModify(String name, String password, HttpSession session){
		Member login=(Member)session.getAttribute("login");
		if(login != null && !login.getMemberType().equals("master")){
			if(memberService.memberModify(name, password, session) == 1)
				return "success";
			else return "fail";
		}
		else{
			return "fail";
		}
	}
	@RequestMapping("memberList.udc")
	@ResponseBody
	public List memberList(){
	    List list = memberService.memberList();
	    return list;
	}
	
}
