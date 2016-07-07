package kr.co.udongca.service;


import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.vo.ReviewBoard;

public interface ReviewBoardService {
	public ModelAndView myReviewListPaging(int page,String memberId);
	
	public Map reviewDetail(int cafeNo,int reviewNo);
	
	public Map cafeReviewListPaging(int page,int cafeNo);
	
	public ReviewBoard selectReview(int reviewNo);
	
	public int insertReview(ReviewBoard review);
	
	public int updateReview(ReviewBoard review);
	
	public int deleteReview(int reviewNo);
	
	public int selectNextReviewBoardSequence();
	
	public List<ReviewBoard> selectMainReviewList();
	
}
