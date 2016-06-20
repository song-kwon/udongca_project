package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.PRBoard;

public interface SearchDao {
	public List<PRBoard> selectPRBoardListByAddress (String cafeAddress);
	public List<PRBoard> selectPRBoardListByFeature (String cafeFeature);
}
