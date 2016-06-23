package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

public interface ReportBoardService {
    
    public List boardList(int page, String reportType);
    public Map<String, Object> reportList(int page, String reportType);
}
