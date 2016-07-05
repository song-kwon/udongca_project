package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.common.util.TextUtil;
import kr.co.udongca.dao.NoticeBoardDao;
import kr.co.udongca.service.NoticeBoardService;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.NoticeBoard;

@Service
public class NoticeBoardServiceImpl implements NoticeBoardService {
	
	@Autowired
	private NoticeBoardDao dao;
	
	@Override
	public int registerNoticeBoard(NoticeBoard noticeBoard){
		int noticeNo = dao.selectNoNoticeBoard();
		noticeBoard.setNoticeNo(noticeNo);
		
		return dao.insertNoticeBoard(noticeBoard);
	}
	
	@Override
	public List<Code> selectByCodeType(String codeType){
		return dao.selectByCodeType(codeType);
	}
	
	@Override
	public int deleteNoticeBoard(int noticeNo){
		return dao.deleteNoticeBoard(noticeNo);
	}
	
	@Override
	public int updateNoticeBoard(NoticeBoard noticeBoard){
		return dao.updateNoticeBoard(noticeBoard);
	}
	
	@Override
	public NoticeBoard selectNoticeBoard(int noticeNo){
		return dao.selectNoticeBoard(noticeNo);
	}
	
	@Override
	public Map<String, Object> selectListNoticeBoard(int page){
	    HashMap<String, Object> map = new HashMap<String,Object>();
	    List list = dao.selectListNoticeBoard(page);
	    map.put("noticeBoardList", list);
	    PagingBean pagingBean = new PagingBean(dao.countNoticeBoard(), page);
	    map.put("pageBean", pagingBean);
	    return map;
	}
	
	@Override
	public List<NoticeBoard> selectNoticeBoardTopTen() {
		return dao.selectNoticeBoardTopTen();
	}
}
