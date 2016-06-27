package kr.co.udongca.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.BookmarkService;
import kr.co.udongca.vo.Bookmark;
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
			return new ModelAndView("login.tiles", "error", "로그인이 필요한 서비스 입니다.");
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
	
	@RequestMapping("deleteBookmark.udc")
	@ResponseBody
	public boolean deleteBookmark(int cafeNo, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		System.out.println("delete1");
		
		if (login == null || !(login.getMemberType().equals("generalmember"))){
			System.out.println("delete2");
			return false;
		}
		
		System.out.println(cafeNo);
		
		int result = service.deleteBookmark(cafeNo, login.getMemberId());
		
		if(result == 1)
			return true;
		else
			return false;
	}
	
	@RequestMapping("insertBookmark.udc")
	@ResponseBody
	public boolean insertBookmark(int cafeNo, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		System.out.println("insert1");
		
		if (login == null || !(login.getMemberType().equals("generalmember"))){
			System.out.println("insert2");
			return false;
		}
		
		System.out.println(cafeNo);
		
		int result = service.insertBookmark(cafeNo, login.getMemberId());
		
		if(result == 1)
			return true;
		else
			return false;
	}
	
	@RequestMapping("isBookmarkAdded.udc")
	@ResponseBody
	public boolean isBookmarkAdded(int cafeNo, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		
		if (login == null || !(login.getMemberType().equals("generalmember"))){
			return false;
		}
		
		List<Bookmark> bookmarkList = service.selectBookmarkByMemberId(login.getMemberId());
		
		for(Bookmark bookmark : bookmarkList){
			if (bookmark.getCafeNo() == cafeNo){
				return true;
			}
		}
		
		return false;
	}
}
