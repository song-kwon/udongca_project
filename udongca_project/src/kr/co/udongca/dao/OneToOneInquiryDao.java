package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.OneToOneInquiry;

public interface OneToOneInquiryDao {

	public int insertOneToOneInquiry(OneToOneInquiry oneToOneInquiry);

	public int deleteOneToOneInquiry(int inquiryNo);

	public int updateOneToOneInquiry(OneToOneInquiry oneToOneInquiry);

	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo);

	public List<OneToOneInquiry> selectListOneToOneInquiry(int page);

	public int selectNoOneToOneInquiry();
	
	public int countInquiry(int inquiryNo);

	public int countOneToOneInquiry();

	public int updateReplyOneToOneInquiry(OneToOneInquiry oneToOneInquiry);

	public List selectList(int page);
	
	public int countList();
	
	public int countList2();
	
	public int updateInquiryReply(OneToOneInquiry oneToOneInquiry);
	
	public OneToOneInquiry selectOneInquiry(int inquiryNo);

	public List<Code> selectByCodeType(String codeType);
}
