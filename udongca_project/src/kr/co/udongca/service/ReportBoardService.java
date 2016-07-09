package kr.co.udongca.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.vo.ReportBoard;

public interface ReportBoardService {
    
    //public Map<String, Object> reportList(int page, String reportType);
    public List reportList(int page, String reportType);
    
    public PagingBean page(int page,String reportType);
    
    public ReportBoard reportInfo(int reportboardNo);
    
    public int updateReport(ReportBoard reportboard);
    
    public int deleteArticle(String reportType,int reportNo);
   
    public ModelAndView memberReportList(int page, String memberId);
   
    public ReportBoard memberReportDetail(int reportboardNo);
    
    public List getCode(String code);
    
    public int insertReport(ReportBoard reportboard);
    
    public int selectNextReportBoardSequence();
    
}
