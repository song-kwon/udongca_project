package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.dao.ReportBoardDao;

@Repository
public class ReportBoardDaoImpl implements ReportBoardDao{
    @Autowired
    private SqlSessionTemplate session;
    
    public ReportBoardDaoImpl(SqlSessionTemplate session) {
	this.session = session;
    }
	
    public List selectList(int page, String reportType){
	    HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
	    param.put("reportType", reportType);
	    return session.selectList("reportMapper.report_list",param);
	}
    public int countReport(String reportType){
	return session.selectOne("reportMapper.count_report_list",reportType);
    }
}
