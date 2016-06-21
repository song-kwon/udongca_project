package kr.co.udongca.controller;

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
		System.out.println("selectAllMajorAddress");
		System.out.println(service.selectAllMajorAddress());
		return service.selectAllMajorAddress();
	}
	
	@RequestMapping("selectMiddleAddressByMajorAddressNo.udc")
	@ResponseBody
	public List<Address> selectMiddleAddressByMajorAddressNo(int majorAddressNo){
		return service.selectMiddleAddressByMajorAddressNo(majorAddressNo);
	}
	
	@RequestMapping("locationSearchResult.udc")
	@ResponseBody
	public List<PRBoard> locationSearchResult(String cafeAddress){
		return service.selectPRBoardListByAddress(cafeAddress);
	}
	
	@RequestMapping("themeSearchResult.udc")
	@ResponseBody
	public List<PRBoard> themeSearchResult(String cafeFeature){
		return service.selectPRBoardListByFeature(cafeFeature);
	}
}