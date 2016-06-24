package kr.co.udongca.dao;

import java.util.List;

import kr.co.udongca.vo.ReportBoard;

public interface ReportBoardDao { 
    
    public List selectList(int page,String reportType);
    
    public int countReport(String reportType);
    
    public List selectList(int page);
    
    public int countReport();
    
    public ReportBoard reportInfo(int reportboardNo);
    
    public int updateInfo(ReportBoard reportboard);
    
    public int deleteArt(String reportType, int reportNo);
}
