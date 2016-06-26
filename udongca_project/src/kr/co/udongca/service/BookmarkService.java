package kr.co.udongca.service;

import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

public interface BookmarkService {

	public ModelAndView memberBookmarkListPaging(int no,String memberId);
	public int deleteBookmark(int cafeNo,String memberId);
}
