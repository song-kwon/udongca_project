package kr.co.udongca.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.ReportBoardService;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.ReportBoard;

@Controller
@RequestMapping({ "/master", "/member/" })
public class ReportBoardController { 
    @Autowired
    private ReportBoardService reportService;
    
    @RequestMapping("/reportBoard.udc")
    public String reportBoard(@RequestParam(required = false) String pnum, @RequestParam String reportType,
	    HttpSession session, Model model) {
	int page = 1;
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master")) {
	    try {
		page = Integer.parseInt(pnum);
	    } catch (Exception e) {
	    }
	    try {
		Map<String, Object> list = reportService.reportList(page, reportType);
		model.addAttribute("list", list);
		model.addAttribute("reportType", reportType);
		return "master/master_reportList.tilse";
	    } catch (Exception e) {
		e.printStackTrace();
		return "error.jsp";
	    }
	} else {
	    return "redirect:/main.udc";
	}
    }

  

    @RequestMapping("/reportBoardInfo.udc")
    public String reportBoardInfo(@RequestParam("reportNo") int reportNo, @RequestParam("page") int page,
	    Model model, HttpSession session) {
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master")) {
	    model.addAttribute("reportInfo", reportService.reportInfo(reportNo));
	    model.addAttribute("page", page);
	    return "master/master_reportBoardInfo.tiles";
	} else {
	    return "redirect:/main.udc";
	}
    }

    @RequestMapping("/updateInfo.udc")
    @ResponseBody
    public int updateInfo(@ModelAttribute ReportBoard reportBoard, @RequestParam("page") int page) {
	// model.addAttribute("page",page);
	// model.addAttribute("result",reportService.updateReport(reportBoard));
	// HashMap map= new HashMap();
	// map.put("page", page);
	// map.put("result", reportService.updateReport(reportBoard));
	return reportService.updateReport(reportBoard);
    }

    @RequestMapping("/deleteArticle.udc")
    @ResponseBody
    public int deleteArticle(@RequestParam("reportType") String reportType, @RequestParam("reportNO") int reportNo) {
	return reportService.deleteArticle(reportType, reportNo);
    }

    @RequestMapping("memberReportListPaging.udc")
    public ModelAndView memberReportListPaging(@RequestParam(required = false) String pnum, HttpSession session) {
	Member login = (Member) session.getAttribute("login");
	int page = 1;
	try {
	    page = Integer.parseInt(pnum);
	} catch (Exception e) {
	}
	try {
	    return reportService.memberReportList(page, login.getMemberId());
	} catch (Exception e) {
	    e.printStackTrace();
	    return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
	}
    }

    @RequestMapping("memberReportDetail.udc")
    public ModelAndView memberReportDetail(int reportboardNo) {
	return new ModelAndView("/WEB-INF/view/udongca-tiles/member_report_detail.jsp", "report",
		reportService.memberReportDetail(reportboardNo));
    }
}
