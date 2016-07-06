package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.CodeDao;
import kr.co.udongca.dao.ReportBoardDao;
import kr.co.udongca.service.ReportBoardService;
import kr.co.udongca.vo.ReportBoard;

@Service
public class ReportBoardServiceImpl implements ReportBoardService {
    @Autowired
    private ReportBoardDao reportBoardDaoImpl;
    @Autowired
    private CodeDao codeDao;

   
    public List getCode(String code){
	return codeDao.selectCode(code);
    }
    public List reportList(int page, String reportType){
	if(reportType.equals("all")){
	 
	    return reportBoardDaoImpl.selectList(page);
	}else{
	    return reportBoardDaoImpl.selectList(page, reportType);
	}
    }
    public PagingBean page(int page,String reportType){
	if(reportType.equals("all")){
	    return new PagingBean(reportBoardDaoImpl.countReport(),page);
	}else{
	    return new PagingBean(reportBoardDaoImpl.countReport(reportType), page);
	}
	
    }
    public ReportBoard reportInfo(int reportboardNo){
	return reportBoardDaoImpl.reportInfo(reportboardNo);
    }
    public int updateReport(ReportBoard reportboard){
	return reportBoardDaoImpl.updateInfo(reportboard);
    }
    public int deleteArticle(String reportType,int reportNo){
	return reportBoardDaoImpl.deleteArt(reportType, reportNo);
    }    
    @Override
    public ModelAndView memberReportList(int page, String memberId) {
		ModelAndView mav;
		if(reportBoardDaoImpl.countMemberReport(memberId)==0){
			mav = new ModelAndView("member/member_report_list.tiles","error","신고 내역 없습니다.");
		}else{
			Map map = new HashMap<>();
			map.put("itemPerPage", Constants.ITEMS_PER_PAGE);
			map.put("page", page);
			map.put("memberId", memberId);
			
			List list = reportBoardDaoImpl.memberReportList(map);
			
			PagingBean pagingBean = new PagingBean(reportBoardDaoImpl.countMemberReport(memberId), page);
			
			map.put("list", list);
			map.put("pageBean", pagingBean);
			mav = new ModelAndView("member/member_report_list.tiles","reportList",map);
		}
		
		return mav;
    }
    
    @Override
    public ReportBoard memberReportDetail(int reportboardNo) {
    	return reportBoardDaoImpl.memberReportDetail(reportboardNo);
    }
	@Override
	public int insertReport(ReportBoard reportboard) {
		return reportBoardDaoImpl.insertReport(reportboard);
	}
	@Override
	public int selectNextReportBoardSequence() {
		return reportBoardDaoImpl.selectNextReportBoardSequence();
	}
}
