package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.ReportBoardDao;
import kr.co.udongca.service.ReportBoardService;

@Service
public class ReportBoardServiceImpl implements ReportBoardService{
    @Autowired
    private ReportBoardDao reportBoardDaoImpl;
    
    public List boardList(int page, String reportType){
	List list = reportBoardDaoImpl.selectList(page, reportType);
	return list;
    }
    public Map<String, Object> reportList(int page, String reportType){
	    HashMap<String, Object> map = new HashMap<String,Object>();
	    List list = reportBoardDaoImpl.selectList(page,reportType);
	    map.put("list", list);
	    PagingBean pagingBean = new PagingBean(reportBoardDaoImpl.countReport(reportType), page);
	    map.put("pageBean", pagingBean);
	    return map;
	}
}
