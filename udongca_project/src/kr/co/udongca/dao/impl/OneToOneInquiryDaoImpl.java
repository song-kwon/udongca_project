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
    public int selectNoOneToOneInquiry() {
	return session.selectOne("inquiryMapper.select-no-oneToOneInquiry");
    }

    @Override
    public int insertOneToOneInquiry(OneToOneInquiry oneToOneInquiry) {
	return session.insert("inquiryMapper.insert_oneToOneInquiry", oneToOneInquiry);
    }

    @Override
    public int deleteOneToOneInquiry(int inquiryNo) {
	return session.delete("inquiryMapper.delete_oneToOneInquiry", inquiryNo);
    }

    @Override
    public int updateOneToOneInquiry(int inquiryNo) {
	return session.update("inquiryMapper.update_oneToOneInquiry", inquiryNo);
    }

    @Override
    public OneToOneInquiry selectOneToOneInquiry(int inquiryNo) {
	return session.selectOne("inquiryMapper.select_oneToOneInquiry", inquiryNo);
    }

    @Override
    public List<OneToOneInquiry> selectListOneToOneInquiry() {
	return session.selectList("inquiryMapper.selectList_oneToOneInquiry");
    }

    public List selectList(int page) {
	HashMap param = new HashMap();
	param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	param.put("page", page);
	return session.selectList("inquiryMapper.oneToOne_list_admin", param);
    }

    public int countList() {
	return session.selectOne("inquiryMapper.count_oneToone_list");
    }
    public OneToOneInquiry selectOneInquiry(int inquiryNo){
	return session.selectOne("inquiryMapper.select_oneToOneInquiry2", inquiryNo);
    }
    public int updateInquiryReply(OneToOneInquiry oneToOneInquiry){
	return session.update("inquiryMapper.update_inquiry_reply", oneToOneInquiry);
    }
}
