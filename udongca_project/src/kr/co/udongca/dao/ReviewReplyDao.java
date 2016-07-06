package kr.co.udongca.dao;

import kr.co.udongca.vo.ReviewReply;

public interface ReviewReplyDao {
	public int addReply(ReviewReply reply);
	
	public int replySequenceNo();
	
	public int addReReply(ReviewReply reply);
	
	public ReviewReply selectReplyByReplyNo(int replyNo);
	
	public int deleteReply(int replyNo);
	
	public int deleteReplyByReviewNo(int reviewNo);
}
