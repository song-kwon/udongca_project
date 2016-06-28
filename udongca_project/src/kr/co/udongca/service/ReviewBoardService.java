package kr.co.udongca.service;


import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

public interface ReviewBoardService {
	public ModelAndView myReviewListPaging(int page,String memberId);
	
	public Map reviewDetail(int cafeNo,int reviewNo);
}
