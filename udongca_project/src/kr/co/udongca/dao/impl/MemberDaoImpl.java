package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.dao.MemberDao;
import kr.co.udongca.vo.Address;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.OneToOneInquiry;
import kr.co.udongca.vo.PRBoard;
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
	public int loginPossible(Member member){
		return session.update("memberMapper.member_login_possible", member);
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
	public int countSameEmail(String memberEmail){
		return session.selectOne("memberMapper.count_same_email", memberEmail);
	}
	

	@Override
	public List<Address> selectMajor() {
		return session.selectList("addressMapper.selectAllMajorAddress");
	}

	@Override
	public List<Address> selectMiddle(int majorNo) {
		// TODO Auto-generated method stub
		return session.selectList("addressMapper.selectMiddleAddressByMajorCategoryNo", majorNo);
	}

	public Member findById(String memberId) {
		return session.selectOne("memberMapper.find_by_id", memberId);
	}
	
	@Override
	public Member findByEmail(String memberEmail){
		return session.selectOne("memberMapper.find_by_email", memberEmail);
	}

	@Override
	public int countPreferLocationByMemberId(String memberId) {
		return session.selectOne("preferLocationMapper.countPreferLocationByMemberId", memberId);
	}
	public List selectList(int page){
	    HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
	    return session.selectList("memberMapper.select_list_page",param);
	} 
	public int countMember(){
	    return session.selectOne("memberMapper.count_member");
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
	
	@Override
	public int memberDrop(String memberId) {
		return session.update("memberMapper.member_drop",memberId);
	}
	
	@Override
	public int countMemberIdFind(Member member) {
		return session.selectOne("memberMapper.count_memberId_find",member);
	}
	
	@Override
	public Member memberIdFind(Member member) {
		return session.selectOne("memberMapper.memberId_find",member);
	}
	
	public Member memberInfo(String memberId){
	    return session.selectOne("memberMapper.member_info", memberId);
	}
	
	public int memberUpdate(Member member){
	    return session.update("memberMapper.member_update", member);
	}
	@Override
	public int countMemberPasswordFind(Member member) {
		return session.selectOne("memberMapper.count_memberPassword_find",member);
	}
	
	@Override
	public Member memberPasswordFind(Member member) {
		return session.selectOne("memberMapper.memberPassword_find",member);
	}
	
	public int countMemberInquiryList(String memberId) {
		return session.selectOne("inquiryMapper.countMemberInquiry",memberId);
	};
	
	@Override
	public List<OneToOneInquiry> memberInquriyList(Map map) {
		return session.selectList("inquiryMapper.select_member_inquiry_list_page",map);
	}
	
	@Override
	public List<PRBoard> memberPRBoardList(Map map) {
		return session.selectList("memberMapper.member_prBoard_list",map);
	}
	
	@Override
	public int countMemberPRBoard(String memberId) {
		return session.selectOne("memberMapper.countMemberPRBoard",memberId);
	}
	
	@Override
	public Map selectMemberPreferLocationAddress(Map map) {
		return session.selectOne("preferLocationMapper.selectMemberPreferLocationAddress", map);
	}
}
