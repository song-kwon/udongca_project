package kr.co.udongca.service;

import java.util.List;

import kr.co.udongca.vo.NoticeBoard;

public interface NoticeBoardService {

	public int registerNoticeBoard(NoticeBoard noticeBoard);
	public int deleteNoticeBoard(int noticeNo);
	public NoticeBoard selectNoticeBoard(int noticeNo);
	public List<NoticeBoard> selectListNoticeBoard();
	public int updateNoticeBoard(int noticeNo);
}
