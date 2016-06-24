package kr.co.udongca.service.impl;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.dao.SearchDao;
import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.*;

/**
 * 홍보글 검색에 관련된 Service Interface를 구현한 Class
 * @author 박재훈
 *
 */
@Service
public class SearchServiceImpl implements SearchService{
	@Autowired
	private SearchDao dao;
	
	@Override
	public List<Address> selectAllMajorAddress() {
		return dao.selectAllMajorAddress();
	}

	@Override
	public List<Address> selectMiddleAddressByMajorCategoryNo(int majorCategoryNo) {
		return dao.selectMiddleAddressByMajorCategoryNo(majorCategoryNo);
	}
	
	@Override
	public List<PRBoard> selectPRBoardListByAddress(Map map) {
		System.out.println("selectPRBoardListByAddress: " + map);
		return dao.selectPRBoardListByAddress(map);
	}

	@Override
	public List<PRBoard> selectPRBoardListByFeature(Map map) {
		return dao.selectPRBoardListByFeature(map);
	}
}