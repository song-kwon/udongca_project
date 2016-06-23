package kr.co.udongca.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.dao.NoticeBoardDao;
import kr.co.udongca.service.NoticeBoardService;
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
	public int deleteNoticeBoard(int noticeNo){
		return dao.deleteNoticeBoard(noticeNo);
	}
	
	@Override
	public int updateNoticeBoard(int noticeNo){
		return dao.updateNoticeBoard(noticeNo);
	}
	
	@Override
	public NoticeBoard selectNoticeBoard(int noticeNo){
		return dao.selectNoticeBoard(noticeNo);
	}
	
	@Override
	public List<NoticeBoard> selectListNoticeBoard(){
		return dao.selectListNoticeBoard();
	}
}
