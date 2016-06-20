package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.Menu;
import kr.co.udongca.vo.PRBoard;

public interface PrBoardService {
	public int insertPRBoard(PRBoard prBoard);
	public int updatePRBoard(PRBoard prBoard);
	public int deletePRBoard(int cafeNo);
	public PRBoard selectPRBoardByNo (int cafeNo);
	public PRBoard selectPRBoardByCoporateNumb (String coporateNumb);
	public int insertMenu(Menu menu);
	public int updateMenu(Menu menu);
	public int deleteMenu(int menuNo);
	public List<Menu> selectMenuListByCafeNoAndMenuType (Map map);
	public Menu selectMenuByMenuNo(int menuNo);
}
