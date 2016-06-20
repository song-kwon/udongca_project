package kr.co.udongca.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.PRBoard;

@Controller
@RequestMapping("/search/")
public class SearchController {
	@Autowired
	private SearchService service;
	
	@RequestMapping("locationSearchResult.udc")
	public List<PRBoard> locationSearchResult(String cafeAddress){
		return service.selectPRBoardListByAddress(cafeAddress);
	}
	
	@RequestMapping("themeSearchResult.udc")
	public List<PRBoard> themeSearchResult(String cafeFeature){
		return service.selectPRBoardListByFeature(cafeFeature);
	}
}