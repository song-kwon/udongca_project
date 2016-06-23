package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.Address;
//github.com/song-kwon/udongca_project.git
import kr.co.udongca.vo.Member;

public interface MemberDao {
	public Member login(String id, String password);

	public int memberModify(Member member);

	public int insertGeneralMember(Member member);

	public int insertLicenseeMember(Member member);

	public int countSameId(String memberId);

	public List<Address> selectMajor();
	
	public List<Address> selectMiddle(int majorNo);

	public Member findById(String memberId);
	
	public List<Member> selectList();
	
	public List<Member> selectList(int page);
	
	public int countMember();
}
