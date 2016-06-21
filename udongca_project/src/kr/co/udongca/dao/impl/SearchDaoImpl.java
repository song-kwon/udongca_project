package kr.co.udongca.dao.impl;

import java.util.List;

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
	public List<Address> selectMiddleAddressByMajorAddressNo(int majorAddressNo) {
		return session.selectList(addressNamespace + "selectMiddleAddressByMajorAddressNo", majorAddressNo);
	}
	
	@Override
	public List<PRBoard> selectPRBoardListByAddress(String cafeAddress) {
		return session.selectList(prNamespace + "selectPRBoardListByAddress", cafeAddress);
	}

	@Override
	public List<PRBoard> selectPRBoardListByFeature(String cafeFeature) {
		return session.selectList(prNamespace + "selectPRBoardListByFeature", cafeFeature);
	}
}