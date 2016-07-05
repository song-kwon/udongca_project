package kr.co.udongca.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.dao.ReviewReplyDao;
import kr.co.udongca.service.ReviewReplyService;
import kr.co.udongca.vo.ReviewReply;

@Service
public class ReviewReplyServiceImpl implements ReviewReplyService {
	@Autowired
	private ReviewReplyDao dao;
	
	public ReviewReplyServiceImpl() {}
	
	public ReviewReply addReply(ReviewReply reply){
		if(reply.getReplyContent().trim().length()!=0 && reply !=null){
			int no = dao.replySequenceNo();
			reply.setReplyNo(no);
			dao.addReply(reply);
			return dao.selectReplyByReplyNo(no);
		}else{
			return null;
		}
	}
	
	@Override
	public ReviewReply addReReply(ReviewReply reply) {
		if(reply.getReplyContent().trim().length()!=0 && reply !=null){
			int no = dao.replySequenceNo();
			reply.setReplyNo(no);
			dao.addReReply(reply);
			return dao.selectReplyByReplyNo(no);
		}else{
			return null;
		}
	}
	
	@Override
	public ReviewReply selectReplyByReplyNo(int replyNo) {
		return dao.selectReplyByReplyNo(replyNo);
	}
	
	@Override
	public int deleteReply(int replyNo) {
		return dao.deleteReply(replyNo);
	}
}