package kr.co.udongca.dao.impl;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PreferLocation;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate session;

	public MemberDaoImpl(SqlSessionTemplate session) {
		this.session = session;
	}

	@Override
	public Member login(String id, String password) {
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
	public List<Address> selectMajor() {
		return session.selectList("addressMapper.selectAllMajorAddress");
	}

	@Override
	public List<Address> selectMiddle(int majorNo) {
		// TODO Auto-generated method stub
		return session.selectList("addressMapper.selectMiddleAddressByMajorAddressNo", majorNo);
	}

	public Member findById(String memberId) {
		return session.selectOne("memberMapper.find_by_id", memberId);
	}

	@Override
	public int countPreferLocationByMemberId(String memberId) {
		return session.selectOne("preferLocationMapper.countPreferLocationByMemberId", memberId);
	}

	@Override
	public int addPreferLocationByMemberId(PreferLocation location) {
		return session.insert("preferLocationMapper.addPreferLocation", location);
	}

	@Override
	public int updatePreferLocationByMemberId(PreferLocation location) {
		return session.update("preferLocationMapper.updatePreferLocationByMemberId", location);
	}

	@Override
	public Map selectPreferLocationByMemberId(String memberId) {
		return session.selectOne("preferLocationMapper.selectPreferLocationByMemberId", memberId);
	}

	@Override
	public Address selectPreferLocationByMiddleCategoryNo(int categoryNo) {
		return session.selectOne("addressMapper.selectPreferLocationByMiddleAddressNo", categoryNo);
	}

	public List<Member> selectList() {
		return session.selectList("memberMapper.member_list");
	}

}
