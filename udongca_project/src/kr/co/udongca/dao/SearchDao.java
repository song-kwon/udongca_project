package kr.co.udongca.dao;

import java.util.*;

import kr.co.udongca.vo.*;

public interface SearchDao {
	public List<Address> selectAllMajorAddress();
	public List<Address> selectMiddleAddressByMajorCategoryNo(int majorCategoryNo);
	public List<PRBoard> selectPRBoardListByAddress (Map map);
	public List<PRBoard> selectPRBoardListByFeature (Map map);
}
