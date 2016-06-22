package kr.co.udongca.service;

import java.util.*;

import kr.co.udongca.vo.*;

public interface SearchService {
	public List<Address> selectAllMajorAddress();
	public List<Address> selectMiddleAddressByMajorAddressNo(int majorAddressNo);
	public List<PRBoard> selectPRBoardListByAddress (Map map);
	public List<PRBoard> selectPRBoardListByFeature (Map map);
}