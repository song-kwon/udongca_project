package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.BookmarkService;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.service.NoticeBoardService;
import kr.co.udongca.vo.Member;

@Controller
public class MainPageController {

	@Autowired
	private BookmarkService bookmarkService;
	
	@Autowired
	private NoticeBoardService noticeService;
	
	@Autowired
	private MemberService memberService;
	
	
	@RequestMapping("main.udc")
	public String mainPage(ModelMap map, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		
		if(login == null){
			return "main.tiles";
		}
		
		if(login.getMemberType().equals("generalMember")){
			map.put("bookmark", bookmarkService.selectBookmarkAndPRBoardByMemberId(login.getMemberId()));
			map.put("notice", noticeService.selectNoticeBoardTopTen());
			map.put("preferLocation",memberService.selectMemberPreferLocationAddress(login.getMemberId()));
			return "main.tiles";
		}else{
			return "main.tiles";
		}
	}
}
