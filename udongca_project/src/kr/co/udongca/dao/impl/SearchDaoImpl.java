package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.SearchDao;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.PRBoard;

/**
 * 홍보글 검색에 관련된 DAO Interface를 구현한 Class
 * @author 박재훈
 *
 */
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
		return session.selectList(prNamespace + "selectPRBoardListByAddress", map);
	}

	@Override
	public List<PRBoard> selectPRBoardListByFeature(Map map) {
		return session.selectList(prNamespace + "selectPRBoardListByFeature", map);
	}
	
	@Override
	public List<Code> selectThemeCategory() {
		return session.selectList("codeMapper.select_code","cafe_theme");
	}
	
	@Override
	public int countThemeCafe(String cafeFeature) {
		return session.selectOne(prNamespace+"countThemeCafe",cafeFeature);
	}
	
	@Override
	public int countCafeAddress(String cafeAddress) {
		// TODO Auto-generated method stub
		return session.selectOne(prNamespace+"countCafeAddress",cafeAddress);
	}
	
	@Override
	public List<Address> selectMajor() {
		return session.selectList("addressMapper.selectAllMajorAddress");
	}

	@Override
	public List<Address> selectMiddle(int majorNo) {
		// TODO Auto-generated method stub
		return session.selectList("addressMapper.selectMiddleAddressByMajorCategoryNo", majorNo);
	}
	
	@Override
	public int selectMajorCategoryNoByAddress(String majorAddress) {
		return session.selectOne("addressMapper.selectMajorCategoryNoByAddress",majorAddress);
	}
	
	@Override
	public List<PRBoard> selectPRBoardListByFeatureOther(Map map) {
		return session.selectList("prBoardMapper.selectPRBoardListByFeatureOther",map);
	}
	
	@Override
	public int countOtherFeature() {
		return session.selectOne("prBoardMapper.countOtherFeature");
	}
}