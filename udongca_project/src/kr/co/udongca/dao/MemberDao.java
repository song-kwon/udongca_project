package kr.co.udongca.dao;

import kr.co.udongca.vo.Member;

public interface MemberDao {
	public Member login(String id,String password);
	public int memberModify(Member member);
}
