package kr.co.udongca.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import kr.co.udongca.dao.SearchDao;
import kr.co.udongca.vo.PRBoard;

public class SearchDaoImpl implements SearchDao {
	private String namespace = "prBoardMapper.";
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<PRBoard> selectPRBoardListByAddress(String cafeAddress) {
		return session.selectList(namespace + "selectPRBoardListByAddress", cafeAddress);
	}

	@Override
	public List<PRBoard> selectPRBoardListByFeature(String cafeFeature) {
		return session.selectList(namespace + "selectPRBoardListByFeature", cafeFeature);
	}
}
