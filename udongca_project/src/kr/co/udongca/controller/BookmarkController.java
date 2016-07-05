package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	@ResponseBody
	public Map memberBookmarkListPaging(@RequestParam(required = false) String no, HttpSession session) {
		Member login = (Member) session.getAttribute("login");
		Map map = new HashMap<>();
		if (login == null) {
			map.put("error", "로그인이 필요한 서비스 입니다.");
			return map;
		} else {
			int page = 1;
			try {
				page = Integer.parseInt(no);
			} catch (Exception e) {
			}
			try {
				return service.memberBookmarkListPaging(page, login.getMemberId());
			} catch (Exception e) {
				e.printStackTrace();
				map.put("error_message", e.getMessage());
				return map;
			}
		}
	}
	
	@RequestMapping("deleteBookmark.udc")
	@ResponseBody
	public boolean deleteBookmark(int cafeNo, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		
		if (login == null || !(login.getMemberType().equals("generalMember"))){
			return false;
		}
		
		
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
		
		if (login == null || !(login.getMemberType().equals("generalMember"))){
			return false;
		}
		
		
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
		
		if (login == null || !(login.getMemberType().equals("generalMember"))){
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
