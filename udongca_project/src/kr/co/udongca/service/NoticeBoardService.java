package kr.co.udongca.service;

import java.util.Map;

import kr.co.udongca.vo.NoticeBoard;

public interface NoticeBoardService {

	public int registerNoticeBoard(NoticeBoard noticeBoard);
	public int deleteNoticeBoard(int noticeNo);
	public NoticeBoard selectNoticeBoard(int noticeNo);
	public int updateNoticeBoard(NoticeBoard noticeBoard);
	public Map<String, Object> selectListNoticeBoard(int page);
}
