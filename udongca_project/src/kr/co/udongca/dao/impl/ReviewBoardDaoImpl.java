package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.ReviewBoardDao;
import kr.co.udongca.vo.ReviewBoard;
import kr.co.udongca.vo.ReviewReply;

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
	
	@Override
	public ReviewBoard reviewDetail(Map<String, Integer> map) {
		return session.selectOne("reviewBoardMapper.reviewDetail",map);
	}
	
	@Override
	public List<ReviewReply> ReviewReplyList(int reviewNo) {
		return session.selectList("reviewBoardMapper.reviewReplyList",reviewNo);
	}
	
	@Override
	public int reviewGourpCount(int reviewNo) {
		return session.selectOne("reviewBoardMapper.reviewGourpCount",reviewNo);
	}

	@Override
	public int countCafeReview(int cafeNo) {
		return session.selectOne("reviewBoardMapper.countCafeReview", cafeNo);
	}

	@Override
	public List<ReviewBoard> cafeReviewListPaging(Map map) {
		return session.selectList("reviewBoardMapper.cafeReviewListPaging",map);
	}

	@Override
	public ReviewBoard selectReview(int reviewNo) {
		return session.selectOne("reviewBoardMapper.selectReview", reviewNo);
	}

	@Override
	public int insertReview(ReviewBoard review) {
		return session.insert("reviewBoardMapper.insertReview", review);
	}

	@Override
	public int updateReview(ReviewBoard review) {
		return session.update("reviewBoardMapper.updateReview", review);
	}

	@Override
	public int deleteReview(int reviewNo) {
		return session.delete("reviewBoardMapper.deleteReview", reviewNo);
	}

	@Override
	public int selectNextReviewBoardSequence() {
		return session.selectOne("reviewBoardMapper.selectNextReviewBoardSequence");
	}
	
	@Override
	public List<ReviewBoard> selectMainReviewList() {
		return session.selectList("reviewBoardMapper.selectMainReviewList");
	}

	@Override
	public List<Integer> selectReviewNoByCafeNo(int cafeNo) {
		return session.selectList("reviewBoardMapper.selectReviewNoByCafeNo", cafeNo);
	}

	@Override
	public int deleteReviewByCafeNo(int cafeNo) {
		return session.delete("reviewBoardMapper.deleteReviewByCafeNo", cafeNo);
	}
}
