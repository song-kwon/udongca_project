package kr.co.udongca.service;


import org.springframework.web.servlet.ModelAndView;

public interface ReviewBoardService {
	public ModelAndView myReviewListPaging(int page,String memberId);
}
