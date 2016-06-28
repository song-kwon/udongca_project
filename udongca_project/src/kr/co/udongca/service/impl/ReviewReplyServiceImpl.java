package kr.co.udongca.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.dao.ReviewReplyDao;
import kr.co.udongca.vo.ReviewReply;

@Service
public class ReviewReplyServiceImpl {

	@Autowired
	private ReviewReplyDao  dao;
	
	public ReviewReplyServiceImpl() {
	}
	
	public int addReply(ReviewReply reply){
		if(reply.getReplyContent().trim().length()!=0 && reply !=null){
			return dao.addReply(reply);
		}else{
			return 0;
		}
	}
}
