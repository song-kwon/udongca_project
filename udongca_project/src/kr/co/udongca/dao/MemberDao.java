package kr.co.udongca.dao;


import java.util.List;

import kr.co.udongca.vo.MajorCategory;
import kr.co.udongca.vo.Member;

public interface MemberDao {
	public Member login(String id,String password);
	public int memberModify(Member member);
	public int insertMember(Member member);
	public int countSameId(String memberId);
	public List<MajorCategory> selectMajorCategory();
}
