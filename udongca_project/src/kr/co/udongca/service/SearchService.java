package kr.co.udongca.service;

import java.util.List;

import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.PRBoard;

public interface SearchService {
	public List<Address> selectAllMajorAddress();
	public List<Address> selectMiddleAddressByMajorAddressNo(int majorAddressNo);
	public List<PRBoard> selectPRBoardListByAddress (String cafeAddress);
	public List<PRBoard> selectPRBoardListByFeature (String cafeFeature);
}