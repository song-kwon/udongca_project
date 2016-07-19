package kr.co.udongca.service;

import java.util.*;

import kr.co.udongca.vo.*;

/**
 * 홍보글 검색에 관련된 Service
 * @author 박재훈
 *
 */
public interface SearchService {
	/**
	 * 시/도에 따라 구분한 대한민국 행정 구역 목록 출력
	 * @return 시/도 목록과 통계정 한국행정구역분류에서 사용되는 고유 대분류 번호 출력
	 */
	public List<Address> selectAllMajorAddress();
	/**
	 * 선택한 시/도에 포함되는, 군/구에 따라 구분한 대한민국 행정 구역 목록 출력
	 * @param majorCategoryNo 선택한 시/도의 고유 대분류 번호
	 * @return 군/구 목록과 통계정 한국행정구역분류에서 사용되는 고유 중분류 번호 출력
	 */
	public List<Address> selectMiddleAddressByMajorCategoryNo(int majorCategoryNo);
	/**
	 * 선택한 주소에 맞는 카페 홍보글 목록 출력
	 * @param map 선택한 주소 및 현재 페이지와 페이지 당 글 목록 수가 담긴 Map
	 * @return 선택한 주소에 맞는 카페 홍보글 객체 목록
	 */
	public Map selectPRBoardListByAddress (Map map);
	/**
	 * 선택한 테마에 맞는 카페 홍보글 목록 출력
	 * @param map 선택한 테마 및 현재 페이지와 페이지 당 글 목록 수가 담긴 Map
	 * @return 선택한 테마에 맞는 카페 홍보글 객체 목록
	 */
	public Map selectPRBoardListByFeature (Map map);
	
	public List<Code> selectThemeCategroy();
	
	public Map selectPRBoardListByFeatureOther(Map map);
}