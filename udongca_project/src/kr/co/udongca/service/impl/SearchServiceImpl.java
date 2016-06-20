package kr.co.udongca.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.udongca.dao.SearchDao;
import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.PRBoard;

@Service
public class SearchServiceImpl implements SearchService{
	@Autowired
	private SearchDao dao;
	
	@Override
	public List<PRBoard> selectPRBoardListByAddress(String cafeAddress) {
		return dao.selectPRBoardListByAddress(cafeAddress);
	}

	@Override
	public List<PRBoard> selectPRBoardListByFeature(String cafeFeature) {
		return dao.selectPRBoardListByFeature(cafeFeature);
	}
}
