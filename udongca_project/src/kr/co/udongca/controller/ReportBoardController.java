package kr.co.udongca.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
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

	@RequestMapping("/reportBoardList.udc")
	@ResponseBody
	public Map reportBoard(@RequestParam(required = false) String pnum, @RequestParam String reportType,
			HttpSession session) {
		int page = 1;
		Member master = (Member) session.getAttribute("login");
		HashMap map = new HashMap();
		if (master != null && master.getMemberType().equals("master")) {
			try {
			    
				page = Integer.parseInt(pnum);
			} catch (Exception e) {
			}
			map.put("list", reportService.reportList(page, reportType));
			map.put("page", reportService.page(page, reportType));
			return map;
		} else {
			map.put("권한", "권한이 없습니다.");
			return map;
		}
	}

	@RequestMapping("/reportSelect.udc")
	@ResponseBody
	public List reportSelect() {
		return reportService.getCode("reportBoard");

	}

	@RequestMapping("/reportBoardInfo.udc")
	@ResponseBody
	public Map reportBoardInfo(@RequestParam("reportNo") int reportNo, HttpSession session) {
		Member master = (Member) session.getAttribute("login");
		HashMap map = new HashMap();
		if (master != null && master.getMemberType().equals("master")) {
			map.put("reportInfo", reportService.reportInfo(reportNo));
			return map;
		} else {
			map.put("권한", "권한이 없습니다.");
			return map;
		}
	}

	@RequestMapping("/updateInfo.udc")
	@ResponseBody
	@Transactional
	public Map updateInfo(@ModelAttribute ReportBoard reportBoard) {
		HashMap map = new HashMap();
		if (reportBoard.getReportReason().equals("신고취소") && reportBoard.getReportCancelReason().length() == 0
				&& reportBoard.getReportCancelReason() == null) {
			map.put("error", "신고취소이유를 등록하세요");
		} else {
			map.put("value", reportService.updateReport(reportBoard));
		}
		return map;
	}

	@RequestMapping("/deleteArticle.udc")
	@ResponseBody
	@Transactional
	public int deleteArticle(@RequestParam("reportType") String reportType, @RequestParam("reportNO") int reportNo) {
		return reportService.deleteArticle(reportType, reportNo);
	}

	@RequestMapping("memberReportDetail.udc")
	@ResponseBody
	public ReportBoard memberReportDetail(int reportboardNo) {
		return reportService.memberReportDetail(reportboardNo);
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
	
	@RequestMapping("addReport.udc")
	public String insertReport(@RequestParam Map map, HttpSession session,
			ModelMap model){
		Member login = (Member) session.getAttribute("login");
		if (login == null){
			return "redirect:/loginPage.udc";
		}
		
		ArrayList<String> errorList = new ArrayList<String>();
		String reportReason = (String)map.get("reportReason");
		String reportContent = (String)map.get("reportContent");
		
		if (reportReason.trim().equals("직접 입력") && (reportContent == null || reportContent.trim().equals(""))){
			errorList.add("직접 입력 선택 시 신고 사유 입력 필수");
		}
		
		if (errorList.size() == 0){
			reportService.insertReport(new ReportBoard(
				reportService.selectNextReportBoardSequence(),
				(String)map.get("reportMemberId"),
				reportReason,
				reportContent,
				"",
				"",
				(String)map.get("reportType"),
				Integer.parseInt(((String)map.get("reportNO"))),
				login.getMemberId()
			));
			return "/prBoard/prView.udc?cafeNo=" + (String)map.get("cafeNo");
		}
		else{
			model.put("error", errorList);
			return "error.tiles";
		}
	}
}
