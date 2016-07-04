package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.NoticeBoard;

public interface NoticeBoardService {

	public int registerNoticeBoard(NoticeBoard noticeBoard);
	public int deleteNoticeBoard(int noticeNo);
	public NoticeBoard selectNoticeBoard(int noticeNo);
	public int updateNoticeBoard(NoticeBoard noticeBoard);
	public Map<String, Object> selectListNoticeBoard(int page);
	public List<Code> selectByCodeType(String codeType);
	public List<NoticeBoard> selectNoticeBoardTopTen();
}
