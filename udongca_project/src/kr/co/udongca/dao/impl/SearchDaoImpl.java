package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.SearchDao;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.PRBoard;

@Repository
public class SearchDaoImpl implements SearchDao {
	private String prNamespace = "prBoardMapper.";
	private String addressNamespace = "addressMapper.";
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public List<Address> selectAllMajorAddress() {
		return session.selectList(addressNamespace + "selectAllMajorAddress");
	}

	@Override
	public List<Address> selectMiddleAddressByMajorCategoryNo(int majorCategoryNo) {
		return session.selectList(addressNamespace + "selectMiddleAddressByMajorCategoryNo", majorCategoryNo);
	}
	
	@Override
	public List<PRBoard> selectPRBoardListByAddress(Map map) {
		System.out.println("selectPRBoardListByAddress: " + map);
		return session.selectList(prNamespace + "selectPRBoardListByAddress", map);
	}

	@Override
	public List<PRBoard> selectPRBoardListByFeature(Map map) {
		return session.selectList(prNamespace + "selectPRBoardListByFeature", map);
	}
}