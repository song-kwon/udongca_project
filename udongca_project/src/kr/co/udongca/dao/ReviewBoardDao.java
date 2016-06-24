package kr.co.udongca.dao;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.ReviewBoard;

public interface ReviewBoardDao {
	
	public int countMyReview(String memberId);

	public List<ReviewBoard> myReviewListPaging(Map map);
}
