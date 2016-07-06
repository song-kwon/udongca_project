package kr.co.udongca.dao;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.Bookmark;

public interface BookmarkDao {

	public int countMemberBookmark(String memberId);
	public List<Bookmark> memberBookmarkListPaging(Map map);
	public int insertBookmark(Bookmark bookmark);
	public int deleteBookmark(Bookmark bookmark);
	public List<Bookmark> selectBookmarkByMemberId(String memberId);
	public List<Bookmark> selectBookmarkAndPRBoardByMemberId(String memberId);
	public int deleteBookmarkByCafeNo(int cafeNo);
}
