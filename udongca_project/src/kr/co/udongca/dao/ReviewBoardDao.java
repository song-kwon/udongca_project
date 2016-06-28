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
}
