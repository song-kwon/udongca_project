package kr.co.udongca.service;

import java.util.*;

import kr.co.udongca.vo.*;

/**
 * 홍보글 관련 Service
 * @author 박재훈
 *
 */
public interface PrBoardService {
	/**
	 * 홍보글 추가
	 * @param prBoard 추가하고자 하는 홍보글 객체
	 * @return 성공 시 1 출력
	 */
	public int insertPRBoard(PRBoard prBoard);
	/**
	 * 홍보글 수정
	 * @param prBoard 수정한 내용이 반영된 홍보글 객체
	 * @return 성공 시 1 출력, 실패 시(해당하는 번호의 홍보글 없음) 0 출력
	 */
	public int updatePRBoard(PRBoard prBoard);
	/**
	 * 홍보글 삭제
	 * @param cafeNo 삭제하고자 하는 홍보글 번호
	 * @return 성공 시 1 출력, 실패 시(해당하는 번호의 홍보글 없음) 0 출력
	 */
	public int deletePRBoard(int cafeNo);
	/**
	 * 번호를 통해 선택한 홍보글 객체 출력
	 * @param cafeNo 열람하고자 하는 홍보글 객체
	 * @return 성공 시 해당 번호에 맞는 홍보글 객체 출력, 실패 시(해당하는 번호의 홍보글 없음) null 출력
	 */
	public PRBoard selectPRBoardByNo (int cafeNo);
	/**
	 * 사업자 등록 번호를 통해 홍보글 객체 선택. 사업자 등록 번호 중복 방지를 위해 사용
	 * @param coporateNumb 중복을 확인하고자 하는 사업자 등록 번호
	 * @return 성공 시 해당 사업자 등록 번호에 맞는 홍보글 객체 출력(중복), 실패 시  null 출력(중복되지 않음)
	 */
	public PRBoard selectPRBoardByCoporateNumber (String coporateNumber);
	/**
	 * 홍보글의 다음 Sequence 번호 출력. 홍보글 게시 시 사용
	 * @return 홍보글의 다음 Sequence 번호 출력 
	 */
	public int selectNextPRBoardSequence();
	/**
	 * 메뉴 추가
	 * @param menu 추가하고자 하는 메뉴 객체
	 * @return 성공 시 1 출력
	 */
	public int insertMenu(Menu menu);
	/**
	 * 메뉴 수정
	 * @param menu 수정한 내용이 반영된 홍보글 객체
	 * @return 성공 시 1 출력, 실패 시(해당하는 번호의 메뉴 없음) 0 출력
	 */
	public int updateMenu(Menu menu);
	/**
	 * 메뉴 삭제
	 * @param menuNo 삭제하고자 하는 메뉴 번호
	 * @return 성공 시 1 출력, 실패 시(해당하는 번호의 메뉴 없음) 0 출력
	 */
	public int deleteMenu(int menuNo);
	/**
	 * 카페와 카테고리를 제한해서 메뉴 리스트 출력
	 * @param map 카페 번호와 메뉴의 카테고리 정보가 담긴 Map
	 * @return 해당 카페 및 카테고리에 맞는 메뉴 리스트 출력
	 */
	public List<Menu> selectMenuListByCafeNoAndMenuType (Map map);
	/**
	 * 해당 카페의 메뉴 리스트 출력
	 * @param cafeNumber 해당 카페 번호
	 * @return 해당 카페 번호에 맞는 메뉴 리스트 출력
	 */
	public List<Menu> selectMenuListByCafeNo (int cafeNumber);
	/**
	 * 해당 메뉴 번호에 맞는 메뉴 객체 출력
	 * @param menuNo 선택하고자 하는 메뉴 번호
	 * @return 해당 메뉴 번호에 맞는 메뉴 객체 출력
	 */
	public Menu selectMenuByMenuNo(int menuNo);
	/**
	 * 메뉴의 다음 Sequence 번호 출력. 메뉴 추가 시 사용
	 * @return 메뉴의 다음 Sequence 번호 출력 
	 */
	public int selectNextMenuSequence();
	/**
	 * 홍보글 작성 시 선택할 수 있는 테마 카페 목록 출력
	 * @return 테마 카페 목록 출력
	 */
	public List<Code> selectThemeList();
	/**
	 * 메뉴 작성 시 선택할 수 있는 카테고리 출력
	 * @return 메뉴 카테고리 목록 출력
	 */
	public List<Code> selectMenuList();
	
	public List<PRBoard> selectMainPRBoardByRating();
	
	public List<PRBoard> selectMainPRBoardByRegistrationDate();
	
	public int updateCafeReviewCountInPRBoard(Map<String, Integer> map);
	
	public int selectCafeReviewCountInPRBoard(int cafeNo);
	
	public int updateCafeRatingInPRBoard(Map<String, Integer> map);
	
	public int selectCafeRatingInPRBoard(int cafeNo);
}
