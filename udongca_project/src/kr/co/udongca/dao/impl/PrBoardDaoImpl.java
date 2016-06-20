package kr.co.udongca.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.PrBoardDao;
import kr.co.udongca.vo.PRBoard;

@Repository
public class PrBoardDaoImpl implements PrBoardDao{
	private String namespace = "prBoardMapper.";
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertPRBoard(PRBoard prBoard) {
		return session.insert(namespace + "insertPRBoard", prBoard);
	}

	@Override
	public int updatePRBoard(PRBoard prBoard) {
		return session.update(namespace + "updatePRBoard", prBoard);
	}

	@Override
	public int deletePRBoard(int cafeNo) {
		return session.delete(namespace + "deletePRBoard", cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByNo(int cafeNo) {
		return session.selectOne(namespace + "selectPRBoardById", cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByCoporateNumb(String coporateNumb) {
		return session.selectOne(namespace + "selectCoporateNumbFromPRBoard", coporateNumb);
	}
}
