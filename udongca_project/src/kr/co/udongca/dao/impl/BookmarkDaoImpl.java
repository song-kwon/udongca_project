package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.BookmarkDao;
import kr.co.udongca.vo.Bookmark;

@Repository
public class BookmarkDaoImpl implements BookmarkDao {

	@Autowired
	private SqlSessionTemplate session;
	
	public BookmarkDaoImpl() {
	}
	
	@Override
	public int countMemberBookmark(String memberId) {
		return session.selectOne("bookmarkMapper.countMemberBookmark",memberId);
	}
	
	@Override
	public List<Bookmark> memberBookmarkListPaging(Map map) {
		return session.selectList("bookmarkMapper.memberBookmarkListPaging",map);
	}

	@Override
	public int insertBookmark(Bookmark bookmark) {
		return session.insert("bookmarkMapper.insertBookmark",bookmark);
	}

	@Override
	public int deleteBookmark(Map map) {
		return session.delete("bookmarkMapper.deleteBookmark",map);
	}

	@Override
	public List<Bookmark> selectBookmarkByMemberId(String memberId) {
		return session.selectList("bookmarkMapper.selectBookmarkByMemberId", memberId);
	}
}