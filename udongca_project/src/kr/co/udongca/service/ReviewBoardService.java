package kr.co.udongca.service;


import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.vo.ReviewBoard;

public interface ReviewBoardService {
	public ModelAndView myReviewListPaging(int page,String memberId);
	
	public Map reviewDetail(int cafeNo,int reviewNo);
	
	public Map cafeReviewListPaging(int page,int cafeNo);
}
