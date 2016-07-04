package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.NoticeBoard;

public interface NoticeBoardDao {
	public int selectNoNoticeBoard();
	public int insertNoticeBoard(NoticeBoard noticeBoard);
	public int deleteNoticeBoard(int noticeNo);
	public NoticeBoard selectNoticeBoard(int noticeNo);
	public List<NoticeBoard> selectListNoticeBoard(int page);
	public int updateNoticeBoard(NoticeBoard noticeBoard);
	public int countNoticeBoard();
	public List<Code> selectByCodeType(String codeType);
	public List<NoticeBoard> selectNoticeBoardTopTen();
}
