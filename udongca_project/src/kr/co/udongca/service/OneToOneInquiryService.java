package kr.co.udongca.service;

import java.util.List;

import kr.co.udongca.vo.OneToOneInquiry;

public interface OneToOneInquiryService {

	public int registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry);

	public int deleteOneToOneInquiry(int inquiryNo);

	public int updateOneToOneInquiry(int inquiryNo);

	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo);

	public List<OneToOneInquiry> selectListOneToOneInquiry();

}
