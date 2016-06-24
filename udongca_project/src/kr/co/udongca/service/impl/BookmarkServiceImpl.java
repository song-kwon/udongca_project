package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.common.util.SendEmailConfig;
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
	public ModelAndView memberBookmarkListPaging(int page,String memberId) {
		ModelAndView mav = null;
		Map map = new HashMap<>();
		if (dao.countMemberBookmark(memberId) == 0) {
			mav = new ModelAndView("/WEB-INF/view/udongca-tiles/error", "error", "즐겨찾기한 카페가 없습니다.");
			return mav;
		} else {
			map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			List<Bookmark> list = dao.memberBookmarkListPaging(map);
			PagingBean pagingBean = new PagingBean(dao.countMemberBookmark(memberId), page);
			map.put("list", list);
			map.put("pageBean", pagingBean);
			mav = new ModelAndView("member/member_bookmark.tiles","bookmarkList",map);
			return mav;
		}
	}
}
