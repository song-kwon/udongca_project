package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.PRBoard;

@Controller
@RequestMapping("/search/")
public class SearchController {
	@Autowired
	private SearchService service;
	
	@RequestMapping("selectAllMajorAddress.udc")
	@ResponseBody
	public List<Address> selectAllMajorAddress(){
		return service.selectAllMajorAddress();
	}
	
	@RequestMapping("selectMiddleAddressByMajorCategoryNo.udc")
	@ResponseBody
	public List<Address> selectMiddleAddressByMajorCategoryNo(int majorCategoryNo){
		return service.selectMiddleAddressByMajorCategoryNo(majorCategoryNo);
	}
	
	@RequestMapping("locationSearchResult.udc")
	@ResponseBody
	public List<PRBoard> locationSearchResult(String cafeAddress, int page, int itemsPerPage){
		HashMap map = new HashMap();
		map.put ("cafeAddress", cafeAddress);
		map.put ("page", page);
		map.put ("itemsPerPage", itemsPerPage);
		System.out.println("locationSearchResult: " + map);
		return service.selectPRBoardListByAddress(map);
	}
	
	@RequestMapping("themeSearchResult.udc")
	@ResponseBody
	public List<PRBoard> themeSearchResult(String cafeFeature, int page, int itemsPerPage){
		HashMap map = new HashMap();
		map.put ("cafeFeature", cafeFeature);
		map.put ("page", page);
		map.put ("itemsPerPage", itemsPerPage);
		return service.selectPRBoardListByFeature(map);
	}
}