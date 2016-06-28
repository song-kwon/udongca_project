package kr.co.udongca.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.ReviewReplyDao;
import kr.co.udongca.vo.ReviewReply;

@Repository
public class ReviewReplyDaoImpl implements ReviewReplyDao{

	@Autowired
	private SqlSessionTemplate session;
	
	public ReviewReplyDaoImpl() {
	}
	
	@Override
	public int addReply(ReviewReply reply) {
		return session.insert("reviewReplyMapper.addReply",reply);
	}
	
}
