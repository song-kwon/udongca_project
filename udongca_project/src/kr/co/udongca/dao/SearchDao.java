package kr.co.udongca.dao;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.PRBoard;

public interface SearchDao {
	public List<Address> selectAllMajorAddress();
	public List<Address> selectMiddleAddressByMajorAddressNo(int majorAddressNo);
	public List<PRBoard> selectPRBoardListByAddress (Map map);
	public List<PRBoard> selectPRBoardListByFeature (Map map);
}
