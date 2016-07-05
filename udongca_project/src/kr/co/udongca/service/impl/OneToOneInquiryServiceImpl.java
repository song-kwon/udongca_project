package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.common.util.TextUtil;
import kr.co.udongca.dao.OneToOneInquiryDao;
import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.OneToOneInquiry;

@Service
public class OneToOneInquiryServiceImpl implements OneToOneInquiryService{
	@Autowired
	private OneToOneInquiryDao dao;
	
	@Override
	public List<Code> selectByCodeType(String codeType){
		return dao.selectByCodeType(codeType);
	}
	
	@Override
	public int registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry, String memberId){
		int inquiryNo = dao.selectNoOneToOneInquiry();
		oneToOneInquiry.setInquiryNo(inquiryNo);
		oneToOneInquiry.setMemberId(memberId);
		return dao.insertOneToOneInquiry(oneToOneInquiry);
	}
	
	@Override
	public int deleteOneToOneInquiry(int inquiryNo){
		return dao.deleteOneToOneInquiry(inquiryNo);
	}
	
	@Override
	public int updateOneToOneInquiry(OneToOneInquiry afterInquiry){
		return dao.updateOneToOneInquiry(afterInquiry);
	}
	
	@Override
	public int updateReplyOneToOneInquiry(OneToOneInquiry afterInquiry){
		return dao.updateReplyOneToOneInquiry(afterInquiry);
	}
	
	@Override
	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo){
		if(dao.countInquiry(inquiryNo) == 0 ){
			return null;
		}
		return dao.selectOneToOneInquiry(inquiryNo);
	}
	
	@Override
	public Map<String, Object> selectListOneToOneInquiry(int page){
	    HashMap<String, Object> map = new HashMap<String,Object>();
	    List list = dao.selectListOneToOneInquiry(page);
	    map.put("oneToOneInquiryList", list);
	    PagingBean pagingBean = new PagingBean(dao.countOneToOneInquiry(), page);
	    map.put("pageBean", pagingBean);
	    return map;
	}
	public OneToOneInquiry selectOneInquiry(int inquiryNo){
	    	OneToOneInquiry one = dao.selectOneInquiry(inquiryNo);
	    	
	    	if(one.getInquiryReply()==null){
	    	    one.setInquiryReply("");
	    	}
	    	one.setInquiryReply(TextUtil.htmlToText(one.getInquiryReply()));
	    	one.setInquiryContent(TextUtil.htmlToText(one.getInquiryContent()));
	    	one.setInquiryTitle(TextUtil.htmlToText(one.getInquiryTitle()));
		return one;
	}
	
	public List oneToOneList(int page){
	    return dao.selectList(page);
	}
	public PagingBean page(int page){ 
	    return new PagingBean(dao.countList2(), page);
	}
	public int updateInquiryReply(OneToOneInquiry oneToOneInquiry){
	    oneToOneInquiry.setInquiryReply(TextUtil.textToHtml(oneToOneInquiry.getInquiryReply()));
	    return dao.updateInquiryReply(oneToOneInquiry);
	}
}
