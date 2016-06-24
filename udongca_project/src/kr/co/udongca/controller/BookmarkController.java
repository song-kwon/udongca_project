package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.BookmarkService;
import kr.co.udongca.vo.Member;

@Controller
@RequestMapping("/member/")
public class BookmarkController {

	@Autowired
	private BookmarkService service;

	public BookmarkController() {
	}

	@RequestMapping("memberBookmarkListPaging.udc")
	public ModelAndView memberBookmarkListPaging(@RequestParam(required = false) String no, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		if (login == null) {
			return new ModelAndView("login.tailes", "error", "로그인이 필요한 서비스 입니다.");
		} else {
			int page = 1;
			try {
				page = Integer.parseInt(no);
				System.out.println(no);
			} catch (Exception e) {
			}
			try {
				return service.memberBookmarkListPaging(page, login.getMemberId());
			} catch (Exception e) {
				e.printStackTrace();
				return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
			}
		}
	}
}
