package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.dao.OneToOneInquiryDao;
import kr.co.udongca.vo.OneToOneInquiry;

@Repository
public class OneToOneInquiryDaoImpl implements OneToOneInquiryDao {
	@Autowired
	private SqlSessionTemplate session;
	
	public OneToOneInquiryDaoImpl(SqlSessionTemplate session) {
	   this.session = session;
	}
	
	@Override
	public int selectNoOneToOneInquiry(){
		return session.selectOne("inquiryMapper.select-no-oneToOneInquiry");
	}
	
	@Override
	public int insertOneToOneInquiry(OneToOneInquiry oneToOneInquiry){
		return session.insert("inquiryMapper.insert_oneToOneInquiry", oneToOneInquiry);
	}
	
	@Override
	public int deleteOneToOneInquiry(int inquiryNo){
		return session.delete("inquiryMapper.delete_oneToOneInquiry", inquiryNo);
	}
	
	@Override
	public int updateOneToOneInquiry(OneToOneInquiry oneToOneInquiry){
		return session.update("inquiryMapper.update_oneToOneInquiry", oneToOneInquiry);
	}
	
	@Override
	public int updateReplyOneToOneInquiry(OneToOneInquiry oneToOneInquiry){
		return session.update("inquiryMapper.update_reply_oneToOneInquiry", oneToOneInquiry);
	}
	
	@Override
	public OneToOneInquiry selectOneToOneInquiry(int inquiryNo){
		return session.selectOne("inquiryMapper.select_oneToOneInquiry", inquiryNo);
	}
	
	@Override
	public List<OneToOneInquiry> selectListOneToOneInquiry(int page){
		HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
		return session.selectList("inquiryMapper.selectList_oneToOneInquiry_page", param);
	}
	
	@Override
	public int countOneToOneInquiry(){
	    return session.selectOne("inquiryMapper.count_oneToOneInquiry");
	}
	
	@Override
	public int countInquiry(int inquiryNo) {
		return session.selectOne("inquiryMapper.countInquiry",inquiryNo);
	}
}
