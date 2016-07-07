package kr.co.udongca.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.service.ReportBoardService;
import kr.co.udongca.vo.Member;

@Controller
@RequestMapping("/master")
public class ThreeBoardController {
    @Autowired
    private OneToOneInquiryService oneService;
    @Autowired
    private ReportBoardService reportService;

    @RequestMapping("/masterPage.udc")
    @ResponseBody
    public List threeBoard(HttpSession session) {
	ArrayList list = new ArrayList();
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master")) {
	    list.add(oneService.oneToOneList(1));
	    list.add(reportService.reportList(1, "review_board"));
	    list.add(reportService.reportList(1, "prBoard"));
	    list.add(reportService.reportList(1, "review_reply"));
	    return list;

	} else {
	    list.add("권한이 없습니다");
	    return list;

	}
    }
}
