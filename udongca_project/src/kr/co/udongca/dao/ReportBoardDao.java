package kr.co.udongca.dao;

import java.util.List;

public interface ReportBoardDao { 
    
    public List selectList(int page, String reportType);
    
    public int countReport(String reportType);
}
