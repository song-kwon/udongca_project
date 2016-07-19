package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.service.SearchService;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Code;

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
	public Map locationSearchResult(String cafeAddress, int page){
		HashMap map = new HashMap();
		map.put ("cafeAddress", cafeAddress);
		map.put ("page", page);
		map.put ("itemsPerPage", Constants.ITEMS_PER_PAGE);
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
	public Map themeSearchResult(String cafeFeature, int page){
		if(!cafeFeature.equals("cafeTheme6")){
			HashMap map = new HashMap();
			map.put ("cafeFeature", cafeFeature);
			map.put ("page", page);
			map.put ("itemsPerPage", Constants.ITEMS_PER_PAGE);
			return service.selectPRBoardListByFeature(map);
		}else{
			HashMap map = new HashMap();
			map.put ("page", page);
			map.put ("itemsPerPage", Constants.ITEMS_PER_PAGE);
			return service.selectPRBoardListByFeatureOther(map);
		}
	}
	
	/**
	 * code table - select theme
	 */
	@RequestMapping("selectThemeCategory.udc")
	@ResponseBody
	public List<Code> selectThemeCategory(){
		return service.selectThemeCategroy();
	}
	
	@RequestMapping("address_search_result.udc")
	public String mainAddressSearchResult(String address1,String address2,ModelMap map){
		String cafeAddress = null;
		if(address2.equals("전체")){
			cafeAddress=address1;
		}else{
			cafeAddress = address1+" "+address2;
		}
		if(cafeAddress.equals("세종특별자치시 세종시")) cafeAddress="세종특별자치시";
		
		map.put("result", locationSearchResult(cafeAddress, 1));
		map.put("searchType", "address");
		return "search/search_result.tiles";
	}
	
	@RequestMapping("theme_search_result.udc")
	public String mainThemeSearchResult(String cafeFeature,ModelMap map){
			map.put("result", themeSearchResult(cafeFeature, 1));
			map.put("searchType", "theme");
			return "search/search_result.tiles";
	}
	
}