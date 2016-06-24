package kr.co.udongca.service;

import java.util.Map;

import kr.co.udongca.vo.OneToOneInquiry;

public interface OneToOneInquiryService {

	public int deleteOneToOneInquiry(int inquiryNo);

	public int updateOneToOneInquiry(OneToOneInquiry afterInquiry);

	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo);

	public Map<String, Object> selectListOneToOneInquiry(int page);

	public int registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry, String memberId);

	public int updateReplyOneToOneInquiry(OneToOneInquiry afterInquiry);

}
