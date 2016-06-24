package kr.co.udongca.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.*;

/**
 * 홍보글 검색에 관련된 Controller
 * @author 박재훈
 *
 */
@Controller
@RequestMapping("/search/")
public class SearchController {
	/**
	 * 홍보글 검색 관련 Service 객체.
	 * 객체는 Spring Container가 주입.
	 */
	@Autowired
	private SearchService service;
	
	/**
	 * 구현 완료
	 * @return
	 */
	@RequestMapping("selectAllMajorAddress.udc")
	@ResponseBody
	public List<Address> selectAllMajorAddress(){
		return service.selectAllMajorAddress();
	}
	
	/**
	 * 구현 완료
	 * @param majorCategoryNo
	 * @return
	 */
	@RequestMapping("selectMiddleAddressByMajorCategoryNo.udc")
	@ResponseBody
	public List<Address> selectMiddleAddressByMajorCategoryNo(int majorCategoryNo){
		return service.selectMiddleAddressByMajorCategoryNo(majorCategoryNo);
	}
	
	/**
	 * 구현 완료
	 * @param cafeAddress
	 * @param page
	 * @return
	 */
	@RequestMapping("locationSearchResult.udc")
	@ResponseBody
	public List<PRBoard> locationSearchResult(String cafeAddress, int page){
		HashMap map = new HashMap();
		map.put ("cafeAddress", cafeAddress);
		map.put ("page", page);
		map.put ("itemsPerPage", 10);
		System.out.println("locationSearchResult: " + map);
		return service.selectPRBoardListByAddress(map);
	}
	
	/**
	 * 구현 완료
	 * @param cafeFeature
	 * @param page
	 * @return
	 */
	@RequestMapping("themeSearchResult.udc")
	@ResponseBody
	public List<PRBoard> themeSearchResult(String cafeFeature, int page){
		HashMap map = new HashMap();
		map.put ("cafeFeature", cafeFeature);
		map.put ("page", page);
		map.put ("itemsPerPage", 10);
		return service.selectPRBoardListByFeature(map);
	}
}