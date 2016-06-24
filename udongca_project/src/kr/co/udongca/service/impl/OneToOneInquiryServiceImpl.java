package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.OneToOneInquiryDao;
import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.vo.OneToOneInquiry;

@Service
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
	public OneToOneInquiry selectOneInquiry(int inquiryNo){
		return dao.selectOneInquiry(inquiryNo);
	}
	public Map<String, Object> oneToOneList(int page){
	    HashMap<String, Object> map = new HashMap<String,Object>();
	    List list = dao.selectList(page);
	    map.put("list", list);
	    PagingBean pagingBean = new PagingBean(dao.countList(), page);
	    map.put("pageBean", pagingBean);
	    return map;
	}
	public int updateInquiryReply(OneToOneInquiry oneToOneInquiry){
	    return dao.updateInquiryReply(oneToOneInquiry);
	}
}
