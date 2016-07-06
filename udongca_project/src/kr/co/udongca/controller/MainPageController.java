package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.BookmarkService;
import kr.co.udongca.service.MemberService;
import kr.co.udongca.service.NoticeBoardService;
import kr.co.udongca.service.PrBoardService;
import kr.co.udongca.service.ReviewBoardService;
import kr.co.udongca.vo.Member;

@Controller
public class MainPageController {

	@Autowired
	private BookmarkService bookmarkService;
	
	@Autowired
	private NoticeBoardService noticeService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ReviewBoardService reviewBoardService;
	
	@Autowired
	private PrBoardService prBoardService;
	
	
	@RequestMapping("main.udc")
	public String mainPage(ModelMap map, HttpSession session){
		Member login = (Member)session.getAttribute("login");
		if(login != null){
			map.put("bookmark", bookmarkService.selectBookmarkAndPRBoardByMemberId(login.getMemberId()));
			map.put("preferLocation",memberService.selectMemberPreferLocationAddress(login.getMemberId()));
		}
		map.put("cafeRating",prBoardService.selectMainPRBoardByRating());
		map.put("newCafe",prBoardService.selectMainPRBoardByRegistrationDate());
		map.put("notice", noticeService.selectNoticeBoardTopTen());
		map.put("reviewBoard", reviewBoardService.selectMainReviewList());
						
		return "main.tiles";
	}
}
