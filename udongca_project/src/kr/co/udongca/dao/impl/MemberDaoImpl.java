package kr.co.udongca.dao.impl;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate session;

	public MemberDaoImpl(SqlSessionTemplate session) {
		this.session=session;
	}
	
	@Override
	public Member login(String id, String password) {
		System.out.println(id+password);
		return session.selectOne("memberMapper.login",new Member(id, password));
	}
	
}
