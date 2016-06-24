package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.dao.ReportBoardDao;
import kr.co.udongca.vo.ReportBoard;

@Repository
public class ReportBoardDaoImpl implements ReportBoardDao{
    @Autowired
    private SqlSessionTemplate session;
    
    public ReportBoardDaoImpl(SqlSessionTemplate session) {
	this.session = session;
    }
	
    public List selectList(int page,String reportType){
	    HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
	    param.put("reportType", reportType);
	    return session.selectList("reportMapper.report_list",param);
	}
    public int countReport(String reportType){
	return session.selectOne("reportMapper.count_report_list",reportType);
    }
    public List selectList(int page){
	 HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
	    return session.selectList("reportMapper.report_list_all",param);
    }
    public int countReport(){
	return session.selectOne("reportMapper.count_report_list_all");
    }
    public ReportBoard reportInfo(int reportboardNo){
	return session.selectOne("reportMapper.report_info",reportboardNo);
    }
    public int updateInfo(ReportBoard reportboard){
	HashMap param = new HashMap();
	param.put("reportResult", reportboard.getReportResult());
	param.put("reportCancelReason", reportboard.getReportCancelReason());
	param.put("reportboardNo", reportboard.getReportboardNo());
	return session.update("reportMapper.update_info", param);
    }
    public int deleteArt(String reportType, int reportNo){
	 HashMap map = new HashMap();
	 System.out.println(reportType+"  "+reportNo);
	if(reportType.equals("review")){
	    map.put("reportType", "review_board");
	    map.put("CorR", "review");
	    map.put("reportNo", reportNo);
	    return session.delete("reportMapper.delete_article", map);
	}else{
	    map.put("reportType", reportType);
	    map.put("CorR", "cafe");
	    map.put("reportNo", reportNo);
	    return session.delete("reportMapper.delete_article",map);
	} 
    }
    
}
