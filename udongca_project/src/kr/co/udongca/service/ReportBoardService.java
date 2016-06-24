package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import kr.co.udongca.vo.ReportBoard;

public interface ReportBoardService {
    
    public Map<String, Object> reportList(int page, String reportType);
    
    public ReportBoard reportInfo(int reportboardNo);
    
    public int updateReport(ReportBoard reportboard);
    
    public int deleteArticle(String reportType,int reportNo);
}
