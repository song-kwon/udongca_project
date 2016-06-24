package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.vo.ReportBoard;

public interface ReportBoardService {
    
    public List boardList(int page, String reportType);
    public Map<String, Object> reportList(int page, String reportType);
    public ModelAndView memberReportList(int page, String memberId);
    public ReportBoard memberReportDetail(int reportboardNo);
}
