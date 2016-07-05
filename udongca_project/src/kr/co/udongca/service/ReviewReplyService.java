package kr.co.udongca.service;

import kr.co.udongca.vo.ReviewReply;

public interface ReviewReplyService {
	public ReviewReply addReply(ReviewReply reply);
	public ReviewReply addReReply(ReviewReply reply);
	public ReviewReply selectReplyByReplyNo (int replyNo);
	public int deleteReply (int replyNo);
}
