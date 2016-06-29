package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.ReviewBoardDao;
import kr.co.udongca.service.ReviewBoardService;

@Service
public class ReviewBoardServiceImpl implements ReviewBoardService{
	
	@Autowired
	private ReviewBoardDao dao;
	
	public ReviewBoardServiceImpl() {
	}
	
	@Override
	public ModelAndView myReviewListPaging(int page,String memberId) {
		ModelAndView mav;
		if(dao.countMyReview(memberId) == 0){
			mav = new ModelAndView("member/member_review_list.tiles","error","등록된 리뷰가 없습니다.");
		}else{
			Map map = new HashMap<>();
			map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			
			List list = dao.myReviewListPaging(map);
			
			PagingBean pagingBean = new PagingBean(dao.countMyReview(memberId), page);
			
			map.put("list", list);
			map.put("pageBean", pagingBean);
			mav = new ModelAndView("member/member_review_list.tiles","reviewList",map);
		}
		
		return mav;
	}
	

	@Override
	public Map reviewDetail(int cafeNo, int reviewNo) {
		Map<String,Integer> map = new HashMap<>();
		map.put("cafeNo", cafeNo);
		map.put("reviewNo", reviewNo);
		
		Map<String,Object> reviewBoard= new HashMap<>();
		reviewBoard.put("countGroup", dao.reviewGourpCount(reviewNo));
		reviewBoard.put("review",dao.reviewDetail(map));
		reviewBoard.put("reply", dao.ReviewReplyList(reviewNo));
		return reviewBoard;
	}
}
