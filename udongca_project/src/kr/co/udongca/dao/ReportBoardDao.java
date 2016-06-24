package kr.co.udongca.dao;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.ReportBoard;

public interface ReportBoardDao { 
    
    public List<ReportBoard> selectList(int page, String reportType);
    
    public int countReport(String reportType);
    
    public List<ReportBoard> memberReportList(Map map);
    
    public int countMemberReport(String memberId);
    
    public ReportBoard memberReportDetail(int reportboardNo);
}
