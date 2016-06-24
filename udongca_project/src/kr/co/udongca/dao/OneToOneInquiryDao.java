package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.OneToOneInquiry;

public interface OneToOneInquiryDao {

	public int insertOneToOneInquiry(OneToOneInquiry oneToOneInquiry);

	public int deleteOneToOneInquiry(int inquiryNo);

	public int updateOneToOneInquiry(int inquiryNo);

	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo);

	public List<OneToOneInquiry> selectListOneToOneInquiry();

	public int selectNoOneToOneInquiry();

	public List selectList(int page);
	
	public int countList();
	
	public int updateInquiryReply(OneToOneInquiry oneToOneInquiry);
	
	public OneToOneInquiry selectOneInquiry(int inquiryNo);
}
