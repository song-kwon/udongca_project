package kr.co.udongca.service;

import java.util.List;

import kr.co.udongca.vo.PRBoard;

public interface SearchService {
	public List<PRBoard> selectPRBoardListByAddress (String cafeAddress);
	public List<PRBoard> selectPRBoardListByFeature (String cafeFeature);
}