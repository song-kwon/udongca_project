package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/")
public class MemberController {

	@RequestMapping("loginTest.udc")
	public String loginTest(String id, String pwd,HttpSession session){
		session.setAttribute("id", id);
		System.out.println(id);
		return "redirect:/main.udc";
	}
	
	@RequestMapping("logout.udc")
	public String loginTest(HttpSession session){
		System.out.println(session.getAttribute("id"));
		session.invalidate();
		return "redirect:/main.udc";
	}
}
