package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.PrBoardDao;
import kr.co.udongca.vo.Menu;
import kr.co.udongca.vo.PRBoard;

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
		return session.selectOne(prBoardNamespace + "selectPRBoardById", cafeNo);
	}

	@Override
	public PRBoard selectPRBoardByCoporateNumb(String coporateNumb) {
		return session.selectOne(prBoardNamespace + "selectCoporateNumbFromPRBoard", coporateNumb);
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
	public Menu selectMenuByMenuNo(int menuNo) {
		return session.selectOne(menuNamespace + "selectMenuByMenuNo", menuNo);
	}
}
