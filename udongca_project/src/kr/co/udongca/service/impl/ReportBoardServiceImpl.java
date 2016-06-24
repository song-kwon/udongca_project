package kr.co.udongca.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.Constants;
import kr.co.udongca.common.util.PagingBean;
import kr.co.udongca.dao.ReportBoardDao;
import kr.co.udongca.service.ReportBoardService;
import kr.co.udongca.vo.ReportBoard;

@Service
public class ReportBoardServiceImpl implements ReportBoardService {
    @Autowired
    private ReportBoardDao reportBoardDaoImpl;

    public Map<String, Object> reportList(int page, String reportType) {
	HashMap<String, Object> map = new HashMap<String, Object>();
	if (reportType.equals("all")) {
	    List list = reportBoardDaoImpl.selectList(page);
	    map.put("list", list);
	    PagingBean pagingBean = new PagingBean(reportBoardDaoImpl.countReport(), page);
	    map.put("pageBean", pagingBean);
	    return map;
	} else {
	    List list = reportBoardDaoImpl.selectList(page, reportType);
	    map.put("list", list);
	    PagingBean pagingBean = new PagingBean(reportBoardDaoImpl.countReport(reportType), page);
	    map.put("pageBean", pagingBean);
	    return map;
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
			mav = new ModelAndView("","error","등록된 리뷰가 없습니다.");
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
}
