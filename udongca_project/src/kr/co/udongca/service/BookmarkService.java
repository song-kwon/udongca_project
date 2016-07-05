package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.vo.Bookmark;

public interface BookmarkService {

	public Map memberBookmarkListPaging(int no,String memberId);
	public int deleteBookmark(int cafeNo,String memberId);
	public int insertBookmark(int cafeNo,String memberId);
	public int countMemberBookmark(String memberId);
	public List<Bookmark> selectBookmarkByMemberId(String memberId);
	public List<Bookmark> selectBookmarkAndPRBoardByMemberId(String memberId);
}
