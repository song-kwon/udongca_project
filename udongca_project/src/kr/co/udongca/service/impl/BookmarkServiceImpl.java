package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.BookmarkDao;
import kr.co.udongca.service.BookmarkService;
import kr.co.udongca.vo.Bookmark;

@Service
public class BookmarkServiceImpl  implements BookmarkService{
	
	@Autowired
	private BookmarkDao dao;
	
	public BookmarkServiceImpl() {
	}
	
	@Override
	public Map memberBookmarkListPaging(int page,String memberId) {
		ModelAndView mav = null;
		Map map = new HashMap<>();
		if (dao.countMemberBookmark(memberId) == 0) {
			map.put("error", "즐겨찾기한 카페가 없습니다.");
			return map;
		} else {
			map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			List<Bookmark> list = dao.memberBookmarkListPaging(map);
			PagingBean pagingBean = new PagingBean(dao.countMemberBookmark(memberId), page);
			map.put("list", list);
			map.put("pageBean", pagingBean);
			return map;
		}
	}
	
	@Override
	public int deleteBookmark(int cafeNo, String memberId) {
		return dao.deleteBookmark(new Bookmark(0, memberId, null, cafeNo,null));
	}

	@Override
	public int insertBookmark(int cafeNo, String memberId) {
		return dao.insertBookmark(new Bookmark(0, memberId, null,cafeNo, null));
	}

	@Override
	public int countMemberBookmark(String memberId) {
		return dao.countMemberBookmark(memberId);
	}

	@Override
	public List<Bookmark> selectBookmarkByMemberId(String memberId) {
		return dao.selectBookmarkByMemberId(memberId);
	}
	
	@Override
	public List<Bookmark> selectBookmarkAndPRBoardByMemberId(String memberId) {
		return dao.selectBookmarkAndPRBoardByMemberId(memberId);
	}
}
