package kr.co.udongca.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.SearchDao;
import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.PRBoard;

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
	public Map selectPRBoardListByAddress(Map map) {
		int total = dao.countCafeAddress(map.get("cafeAddress").toString());
		int page = (int)map.get("page");
		String majorAddress= (map.get("cafeAddress").toString()).split(" ")[0];
		int majorNo=dao.selectMajorCategoryNoByAddress(majorAddress);
		PagingBean pagingBean = new PagingBean(total,page);
		map.put("majorCategory",dao.selectMajor());
		map.put("middleCategory",dao.selectMiddle(majorNo));
		map.put("pageBean", pagingBean);
		
		List list = dao.selectPRBoardListByAddress(map);
		if(list.isEmpty()){
			map.put("error", "검색 결과가 없습니다.");
		}
		
		map.put("list",list);
		return map;
		
	}

	@Override
	public Map selectPRBoardListByFeature(Map map) {
		int total = dao.countThemeCafe(map.get("cafeFeature").toString());
		int page = (int)map.get("page");
		PagingBean pagingBean = new PagingBean(total,page);
		map.put("pageBean", pagingBean);
		map.put("majorCategory",dao.selectMajor());
		List list = dao.selectPRBoardListByFeature(map);
		if(list.isEmpty()){
			map.put("error", "검색결과가 없습니다.");
		}
		map.put("list",dao.selectPRBoardListByFeature(map));
		return map;
	}
	
	@Override
	public List<Code> selectThemeCategroy() {
		return dao.selectThemeCategory();
	}
	
	@Override
	public Map selectPRBoardListByFeatureOther(Map map) {
		int total = dao.countOtherFeature();
		int page = (int)map.get("page");
		PagingBean pagingBean = new PagingBean(total,page);
		map.put("pageBean", pagingBean);
		map.put("majorCategory",dao.selectMajor());
		List list = dao.selectPRBoardListByFeature(map);
		if(list.isEmpty()){
			map.put("error", "검색결과가 없습니다.");
		}
		map.put("list",dao.selectPRBoardListByFeatureOther(map));
		return map;
	}
}