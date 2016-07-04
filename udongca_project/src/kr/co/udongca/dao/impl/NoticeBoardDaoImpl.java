package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.dao.NoticeBoardDao;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.NoticeBoard;

@Repository
public class NoticeBoardDaoImpl implements NoticeBoardDao{
	@Autowired
	private SqlSessionTemplate session;
	
	public NoticeBoardDaoImpl(SqlSessionTemplate session) {
	    this.session = session;
	
	}
	
	@Override
	public List<Code> selectByCodeType(String codeType){
		return session.selectList("codeMapper.select_code",codeType);
	}
	
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
	public int updateNoticeBoard(NoticeBoard noticeBoard){
		return session.update("noticeMapper.update_noticeBoard", noticeBoard);
	}
	
	@Override
	public NoticeBoard selectNoticeBoard(int noticeNo){
		return session.selectOne("noticeMapper.select_noticeBoard", noticeNo);
	}
	
	@Override
	public List<NoticeBoard> selectListNoticeBoard(int page){
		HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
		return session.selectList("noticeMapper.selectList_noticeBoard_page", param);
	}
	
	@Override
	public int countNoticeBoard(){
	    return session.selectOne("noticeMapper.count_noticeBoard");
	}
	
	@Override
	public List<NoticeBoard> selectNoticeBoardTopTen() {
		return session.selectList("noticeMapper.select_noticeBoard_top_ten");
	}
}
