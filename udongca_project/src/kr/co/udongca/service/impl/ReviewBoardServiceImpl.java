package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.PrBoardDao;
import kr.co.udongca.dao.ReviewBoardDao;
import kr.co.udongca.dao.ReviewReplyDao;
import kr.co.udongca.service.ReviewBoardService;
import kr.co.udongca.vo.ReviewBoard;

@Service
public class ReviewBoardServiceImpl implements ReviewBoardService{
	
	@Autowired
	private ReviewBoardDao reviewDao;
	@Autowired
	private PrBoardDao prBoardDao;
	@Autowired
	private ReviewReplyDao replyDao;
	
	public ReviewBoardServiceImpl() {
	}
	
	@Override
	public ModelAndView myReviewListPaging(int page,String memberId) {
		ModelAndView mav;
		if(reviewDao.countMyReview(memberId) == 0){
			mav = new ModelAndView("member/member_review_list.tiles","error","등록된 리뷰가 없습니다.");
		}else{
			Map map = new HashMap<>();
			map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			
			List list = reviewDao.myReviewListPaging(map);
			
			PagingBean pagingBean = new PagingBean(reviewDao.countMyReview(memberId), page);
			
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
		reviewBoard.put("countGroup", reviewDao.reviewGourpCount(reviewNo));
		reviewBoard.put("review",reviewDao.reviewDetail(map));
		reviewBoard.put("reply", reviewDao.ReviewReplyList(reviewNo));
		return reviewBoard;
	}

	@Override
	public Map cafeReviewListPaging(int page, int cafeNo) {
		Map map = new HashMap();
		map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
		map.put("page", page);
		map.put("cafeNo", cafeNo);
		
		List list = reviewDao.cafeReviewListPaging(map);
		
		PagingBean pagingBean = new PagingBean(reviewDao.countCafeReview(cafeNo), page);
		
		map.put("list", list);
		map.put("pageBean", pagingBean);
		return map;
	}

	@Override
	public ReviewBoard selectReview(int reviewNo) {
		return reviewDao.selectReview(reviewNo);
	}
	
	@Override
	public int insertReview(ReviewBoard review) {
		return reviewDao.insertReview(review);
	}

	@Override
	public int updateReview(ReviewBoard review) {
		return reviewDao.updateReview(review);
	}

	@Override
	public int deleteReview(int reviewNo) {
		replyDao.deleteReplyByReviewNo(reviewNo);
		return reviewDao.deleteReview(reviewNo);
	}

	@Override
	public int selectNextReviewBoardSequence() {
		return reviewDao.selectNextReviewBoardSequence();
	}
	
	@Override
	public List<ReviewBoard> selectMainReviewList() {
		return reviewDao.selectMainReviewList();
	}
	
}

