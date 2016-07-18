package kr.co.udongca.dao;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.Address;
//github.com/song-kwon/udongca_project.git
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.OneToOneInquiry;
import kr.co.udongca.vo.PRBoard;
import kr.co.udongca.vo.PreferLocation;

public interface MemberDao {
	public Member login(String id, String password);

	public int memberModify(Member member);

	public int insertGeneralMember(Member member);

	public int insertLicenseeMember(Member member);

	public int countSameId(String memberId);

	public List<Address> selectMajor();

	public List<Address> selectMiddle(int majorNo);

	public Member findById(String memberId);

	public int countPreferLocationByMemberId(String memberId);

	public int addPreferLocationByMemberId(PreferLocation location);

	public int updatePreferLocationByMemberId(PreferLocation location);

	public Map selectPreferLocationByMemberId(String memberId);

	public Address selectPreferLocationByMiddleCategoryNo(int categoryNo);

	public List<Member> selectList();

	public List<Member> selectList(int page);

	public int countMember();

	public int memberDrop(String memberId);

	public int countMemberIdFind(Member member);

	public Member memberIdFind(Member member);

	public Member memberInfo(String memberId);

	public int memberUpdate(Member member);

	public int countMemberPasswordFind(Member member);

	public Member memberPasswordFind(Member member);

	public List<OneToOneInquiry> memberInquriyList(Map map);

	public int countMemberInquiryList(String memberId);

	public int loginPossible(Member member);
	
	public List<PRBoard> memberPRBoardList(Map map);
	
	public int countMemberPRBoard(String memberId);
	
	public Map selectMemberPreferLocationAddress(Map map);

	public Member findByEmail(String memberEmail);

	public int countSameEmail(String memberEmail);
}
