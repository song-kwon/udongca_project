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

	@RequestMapping("loginTest.udc")
	public String loginTest(String id, String pwd,HttpSession session){
		session.setAttribute("id", id);
		System.out.println(id);
		System.out.println(memberService.test());
		return "redirect:/main.udc";
	}
	
	@RequestMapping("logout.udc")
	public String loginTest(HttpSession session){
		System.out.println(session.getAttribute("id"));
		session.invalidate();
		return "redirect:/main.udc";
	}
}
