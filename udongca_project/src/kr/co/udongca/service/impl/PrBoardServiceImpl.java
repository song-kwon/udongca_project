package kr.co.udongca.service.impl;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.dao.*;
import kr.co.udongca.service.PrBoardService;
import kr.co.udongca.vo.*;

/**
 * 홍보글 관련 Service Interface를 구현한 Class
 * @author 박재훈
 *
 */
@Service
public class PrBoardServiceImpl implements PrBoardService{
	@Autowired
	private PrBoardDao dao;
	@Autowired
	private CodeDao codeDao;
	
	@Override
	public int insertPRBoard(PRBoard prBoard) {
		return dao.insertPRBoard(prBoard);
	}

	@Override
	public int updatePRBoard(PRBoard prBoard) {
		return dao.updatePRBoard(prBoard);
	}

	@Override
	public int deletePRBoard(int cafeNo) {
		return dao.deletePRBoard(cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByNo(int cafeNo) {
		return dao.selectPRBoardByNo(cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByCoporateNumb(String coporateNumb) {
		return dao.selectPRBoardByCoporateNumb(coporateNumb);
	}
	
	@Override
	public int selectNextPRBoardSequence() {
		return dao.selectNextPRBoardSequence();
	}

	@Override
	public int insertMenu(Menu menu) {
		return dao.insertMenu(menu);
	}

	@Override
	public int updateMenu(Menu menu) {
		return dao.updateMenu(menu);
	}

	@Override
	public int deleteMenu(int menuNo) {
		return dao.deleteMenu(menuNo);
	}

	@Override
	public List<Menu> selectMenuListByCafeNoAndMenuType(Map map) {
		return dao.selectMenuListByCafeNoAndMenuType(map);
	}
	
	@Override
	public List<Menu> selectMenuListByCafeNo (int cafeNumber){
		return dao.selectMenuListByCafeNo(cafeNumber);
	}

	@Override
	public Menu selectMenuByMenuNo(int menuNo) {
		return dao.selectMenuByMenuNo(menuNo);
	}

	@Override
	public int selectNextMenuSequence() {
		return dao.selectNextMenuSequence();
	}

	@Override
	public List<Code> selectThemeList() {
		return codeDao.selectCode("cafe_theme");
	}

	@Override
	public List<Code> selectMenuList() {
		return codeDao.selectCode("cafe_menu");
	}
	
	@Override
	public List<PRBoard> selectMainPRBoardByRating() {
		return dao.selectMainPRBoardByRating();
	}
	
	public List<PRBoard> selectMainPRBoardByRegistrationDate(){
		return dao.selectMainPRBoardByRegistrationDate();
	}
}