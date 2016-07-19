package kr.co.udongca.dao.impl;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.PrBoardDao;
import kr.co.udongca.vo.*;

/**
 * 홍보글 관련 DAO Interface를 구현한 Class
 * @author 박재훈
 *
 */
@Repository
public class PrBoardDaoImpl implements PrBoardDao{
	private String prBoardNamespace = "prBoardMapper.";
	private String menuNamespace = "menuMapper.";
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertPRBoard(PRBoard prBoard) {
		return session.insert(prBoardNamespace + "insertPRBoard", prBoard);
	}

	@Override
	public int updatePRBoard(PRBoard prBoard) {
		return session.update(prBoardNamespace + "updatePRBoard", prBoard);
	}

	@Override
	public int deletePRBoard(int cafeNo) {
		return session.delete(prBoardNamespace + "deletePRBoard", cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByNo(int cafeNo) {
		return session.selectOne(prBoardNamespace + "selectPRBoardByNo", cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByCoporateNumber(String coporateNumber) {
		return session.selectOne(prBoardNamespace + "selectPRBoardByCoporateNumber", coporateNumber);
	}
	
	@Override
	public int selectNextPRBoardSequence() {
		return session.selectOne(prBoardNamespace + "selectNextPRBoardSequence");
	}

	@Override
	public int insertMenu(Menu menu) {
		return session.insert(menuNamespace + "insertMenu", menu);
	}

	@Override
	public int updateMenu(Menu menu) {
		return session.update(menuNamespace + "updateMenu", menu);
	}

	@Override
	public int deleteMenu(int menuNo) {
		return session.delete(menuNamespace + "deleteMenu", menuNo);
	}

	@Override
	public List<Menu> selectMenuListByCafeNoAndMenuType(Map map) {
		return session.selectList(menuNamespace + "selectMenuListByCafeNoAndMenuType", map);
	}
	
	@Override
	public List<Menu> selectMenuListByCafeNo (int cafeNumber){
		return session.selectList(menuNamespace + "selectMenuListByCafeNo", cafeNumber);
	}

	@Override
	public Menu selectMenuByMenuNo(int menuNo) {
		return session.selectOne(menuNamespace + "selectMenuByMenuNo", menuNo);
	}

	@Override
	public int selectNextMenuSequence() {
		return session.selectOne(menuNamespace + "selectNextMenuSequence");
	}
	
	@Override
	public List<PRBoard> selectMainPRBoardByAddress(String cafeAddress) {
		return session.selectList(prBoardNamespace+"selectMainPRBoardByAddress",cafeAddress);
	}
	
	@Override
	public List<PRBoard> selectMainPRBoardByRating() {
		return session.selectList(prBoardNamespace+"selectMainPRBoardByRating");
	}
	
	@Override
	public List<PRBoard> selectMainPRBoardByRegistrationDate() {
		return session.selectList(prBoardNamespace+"selectMainPRBoardByRegistrationDate");
	}

	@Override
	public int updateCafeReviewCountInPRBoard(Map<String, Integer> map) {
		return session.update(prBoardNamespace+"updateCafeReviewCountInPRBoard", map);
	}

	@Override
	public int updateCafeRatingInPRBoard(Map<String, Integer> map) {
		return session.update(prBoardNamespace+"updateCafeRatingInPRBoard", map);
	}

	@Override
	public int selectCafeReviewCountInPRBoard(int cafeNo) {
		return session.selectOne(prBoardNamespace+"selectCafeReviewCountInPRBoard", cafeNo);
	}

	@Override
	public int selectCafeRatingInPRBoard(int cafeNo) {
		return session.selectOne(prBoardNamespace+"selectCafeRatingInPRBoard", cafeNo);
	}
	
}