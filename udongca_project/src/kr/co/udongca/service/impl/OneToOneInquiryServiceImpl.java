package kr.co.udongca.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import kr.co.udongca.dao.OneToOneInquiryDao;
import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.vo.OneToOneInquiry;

public class OneToOneInquiryServiceImpl implements OneToOneInquiryService{
	@Autowired
	private OneToOneInquiryDao dao;
	
	@Override
	public int registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry){
		int inquiryNo = dao.selectNoOneToOneInquiry();
		oneToOneInquiry.setInquiryNo(inquiryNo);
		return dao.insertOneToOneInquiry(oneToOneInquiry);
	}
	
	@Override
	public int deleteOneToOneInquiry(int inquiryNo){
		return dao.deleteOneToOneInquiry(inquiryNo);
	}
	
	@Override
	public int updateOneToOneInquiry(int inquiryNo){
		return dao.updateOneToOneInquiry(inquiryNo);
	}
	
	@Override
	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo){
		return dao.selectOneToOneInquiry(inquiryNo);
	}
	
	@Override
	public List<OneToOneInquiry> selectListOneToOneInquiry(){
		return dao.selectListOneToOneInquiry();
	}
}
