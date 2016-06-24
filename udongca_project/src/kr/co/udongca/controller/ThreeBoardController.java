package kr.co.udongca.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.service.ReportBoardService;

@Controller
@RequestMapping("/master")
public class ThreeBoardController {
    @Autowired
    private OneToOneInquiryService oneService;
    @Autowired
    private ReportBoardService reportService;
    
    @RequestMapping("/masterPage.udc")
    @ResponseBody
    public List oneToOneBoard(){
	ArrayList list = new ArrayList();
	list.add(oneService.oneToOneList(1).get("list"));
	list.add(reportService.reportList(1, "review").get("list"));
	list.add(reportService.reportList(1, "prboard").get("list"));
	return list;
	
    }
}
