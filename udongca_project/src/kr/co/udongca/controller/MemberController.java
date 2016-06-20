package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.impl.MemberServiceImpl;
import kr.co.udongca.vo.Member;

@Controller
@RequestMapping("/member/")
public class MemberController {
	
	@Autowired
	private MemberServiceImpl memberService;

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
}
