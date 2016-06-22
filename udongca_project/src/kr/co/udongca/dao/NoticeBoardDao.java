package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.NoticeBoard;

public interface NoticeBoardDao {
	public int selectNoNoticeBoard();
	public int insertNoticeBoard(NoticeBoard noticeBoard);
	public int deleteNoticeBoard(int noticeNo);
	public NoticeBoard selectNoticeBoard(int noticeNo);
	public List<NoticeBoard> selectListNoticeBoard();
	public int updateNoticeBoard(int noticeNo);
}
