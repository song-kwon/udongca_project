package kr.co.udongca.dao.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
    public int countReport(String reportType){
	return session.selectOne("reportMapper.count_report_list",reportType);
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
	if(reportType.equals("review_board")){
	    map.put("reportType", "review_board");
	    map.put("CorR", "review");
	    map.put("reportNo", reportNo);
	    return session.delete("reportMapper.delete_article", map);
	}else if(reportType.equals("review_reply")){
	    map.put("reportType", "review_reply");
	    map.put("CorR", "reply");
	    map.put("reportNo", reportNo);
	    return session.delete("reportMapper.delete_article", map);
	}else{
	    map.put("reportType", reportType);
	    map.put("CorR", "cafe");
	    map.put("reportNo", reportNo);
	    return session.delete("reportMapper.delete_article",map);
	}
    }
    public List<ReportBoard> selectList(int page){
	 HashMap param = new HashMap();
	    param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
	    param.put("page", page);
	    return session.selectList("reportMapper.report_list_all",param);
   }

	public List<ReportBoard> selectList(int page, String reportType) {
		HashMap param = new HashMap();
		param.put("itemPerPage", Constants.ITEMS_PER_PAGE);
		param.put("page", page);
		param.put("reportType", reportType);
		return session.selectList("reportMapper.report_list", param);
	}

	@Override
	public int countMemberReport(String memberId) {
		return session.selectOne("reportMapper.count_member_report_list",memberId);
	}
	
	@Override
	public List<ReportBoard> memberReportList(Map map) {
		return session.selectList("reportMapper.member_report_list",map);
	}
	
	@Override
	public ReportBoard memberReportDetail(int reportboardNo) {
		return session.selectOne("reportMapper.member_report_detail",reportboardNo);
	}

	@Override
	public int insertReport(ReportBoard reportboard) {
		return session.insert("reportMapper.insertReport", reportboard);
	}

	@Override
	public int selectNextReportBoardSequence() {
		return session.selectOne("reportMapper.selectNextReportBoardSequence");
	}
}
