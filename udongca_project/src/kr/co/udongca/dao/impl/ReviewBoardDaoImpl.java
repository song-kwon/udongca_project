package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.ReviewBoardDao;
import kr.co.udongca.vo.ReviewBoard;

@Repository
public class ReviewBoardDaoImpl implements ReviewBoardDao{

	@Autowired
	private SqlSessionTemplate session;
	
	public ReviewBoardDaoImpl() {
	}

	@Override
	public int countMyReview(String memberId) {
		return session.selectOne("reviewBoardMapper.countMyReview",memberId);
	}
	
	@Override
	public List<ReviewBoard> myReviewListPaging(Map map) {
		return session.selectList("reviewBoardMapper.myReviewListPaging",map);
	}
}
