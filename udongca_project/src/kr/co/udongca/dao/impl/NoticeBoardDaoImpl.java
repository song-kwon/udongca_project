package kr.co.udongca.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.NoticeBoardDao;
import kr.co.udongca.vo.NoticeBoard;

@Repository
public class NoticeBoardDaoImpl implements NoticeBoardDao{
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int selectNoNoticeBoard(){
		return session.selectOne("noticeMapper.select-no-noticeBoard");
	}
	
	@Override
	public int insertNoticeBoard(NoticeBoard noticeBoard){
		return session.insert("noticeMapper.insert_noticeBoard", noticeBoard);
	}
	
	@Override
	public int deleteNoticeBoard(int noticeNo){
		return session.delete("noticeMapper.delete_noticeBoard", noticeNo);
	}
	
	@Override
	public int updateNoticeBoard(int noticeNo){
		return session.update("noticeMapper.update_noticeBoard", noticeNo);
	}
	
	@Override
	public NoticeBoard selectNoticeBoard(int noticeNo){
		return session.selectOne("noticeMapper.select_noticeBoard", noticeNo);
	}
	
	@Override
	public List<NoticeBoard> selectListNoticeBoard(){
		return session.selectList("noticeMapper.selectList_noticeBoard");
	}
}
