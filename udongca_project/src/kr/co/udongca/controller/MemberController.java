package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.impl.MemberServiceImpl;

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
}
