package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.OneToOneInquiry;

public interface OneToOneInquiryService {

	public int registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry);

	public int deleteOneToOneInquiry(int inquiryNo);

	public int updateOneToOneInquiry(int inquiryNo);

	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo);

	public List<OneToOneInquiry> selectListOneToOneInquiry();
	
	public Map<String, Object> oneToOneList(int page);
	
	public OneToOneInquiry selectOneInquiry(int inquiryNo);
	
	 public int updateInquiryReply(OneToOneInquiry oneToOneInquiry);
}
