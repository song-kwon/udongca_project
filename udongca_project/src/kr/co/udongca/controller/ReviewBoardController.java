package kr.co.udongca.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.ReviewBoardService;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.ReviewBoard;

@Controller
@RequestMapping({"/member/","/review/"})
public class ReviewBoardController {

	@Autowired
	private ReviewBoardService service;
	
	public ReviewBoardController() {
	}

	@RequestMapping("memberReviewListPaging.udc")
	public ModelAndView memberReviewListPageing(@RequestParam(required = false) String pnum,HttpSession session) {
		Member login = (Member)session.getAttribute("login");
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			 
			return service.myReviewListPaging(page, login.getMemberId());
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
		}
	}
	
	@RequestMapping("reviewDetail.udc")
	public ModelAndView reviewDetail(int cafeNo,int reviewNo){
		
		Map map = service.reviewDetail(cafeNo, reviewNo);
		return new ModelAndView("/testView/testReply.jsp",map);
	}
	
	@RequestMapping("cafeReviewListPaging.udc")
	@ResponseBody
	public Map cafeReviewListPageing(@RequestParam(required = false) String pnum, 
			int cafeNo, HttpSession session) {
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			return service.cafeReviewListPaging(page, cafeNo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("reviewRead.udc")
	@ResponseBody
	public ReviewBoard reviewRead(int reviewNo){
		return service.selectReview(reviewNo);
	}
}
