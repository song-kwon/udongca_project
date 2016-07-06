package kr.co.udongca.dao;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.ReviewBoard;
import kr.co.udongca.vo.ReviewReply;

public interface ReviewBoardDao {
	
	public int countMyReview(String memberId);

	public List<ReviewBoard> myReviewListPaging(Map map);
	
	public ReviewBoard reviewDetail(Map<String, Integer>	map);
	
	public List<ReviewReply> ReviewReplyList(int reviewNo);
	
	public int reviewGourpCount(int reviewNo);
	
	public int countCafeReview(int cafeNo);
	
	public List<ReviewBoard> cafeReviewListPaging(Map map);
	
	public ReviewBoard selectReview(int reviewNo);
	
	public int insertReview(ReviewBoard review);
	
	public int updateReview(ReviewBoard review);
	
	public int deleteReview(int reviewNo);
	
	public int selectNextReviewBoardSequence();
	
	public List<ReviewBoard> selectMainReviewList();
	
	public List<Integer> selectReviewNoByCafeNo(int cafeNo);
	
	public int deleteReviewByCafeNo(int cafeNo);
}
