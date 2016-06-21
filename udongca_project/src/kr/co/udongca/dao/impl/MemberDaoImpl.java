package kr.co.udongca.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;

	public MemberDaoImpl(SqlSessionTemplate session) {
		this.session = session;
	}

	@Override
	public Member login(String id, String password) {
		System.out.println(id + password);
		return session.selectOne("memberMapper.login", new Member(id, password));
	}

	@Override
	public int memberModify(Member member) {
		return session.update("memberMapper.member_modify", member);
	}

	@Override
	public int insertGeneralMember(Member member) {
		return session.insert("memberMapper.general_member_insert", member);
	}

	@Override
	public int insertLicenseeMember(Member member) {
		return session.insert("memberMapper.licensee_member_insert", member);
	}

	@Override
	public int countSameId(String memberId) {
		return session.selectOne("memberMapper.count_same_id", memberId);
	}

	@Override
	public List<Address> selectAddress() {
		return session.selectList("addressMapper.selectAddress");
	}

	public Member findById(String memberId) {
		return session.selectOne("memberMapper.find_by_id", memberId);
	}

}
