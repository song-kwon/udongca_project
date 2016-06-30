package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.OneToOneInquiry;

public interface OneToOneInquiryService {

	public int deleteOneToOneInquiry(int inquiryNo);

	public int updateOneToOneInquiry(OneToOneInquiry afterInquiry);

	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo);

	//public Map<String, Object> oneToOneList(int page);
	
	public OneToOneInquiry selectOneInquiry(int inquiryNo);
	
	 public int updateInquiryReply(OneToOneInquiry oneToOneInquiry);
	 
	public Map<String, Object> selectListOneToOneInquiry(int page);

	public int registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry, String memberId);

	public int updateReplyOneToOneInquiry(OneToOneInquiry afterInquiry);
	
	public List oneToOneList(int page);
	
	public PagingBean page(int page);

	public List<Code> selectByCodeType(String codeType);

}
