package kr.co.udongca.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.ReportBoardService;

@Controller
@RequestMapping("/master")
public class ReportBoardController {
    @Autowired
    private ReportBoardService reportService;
    int page;
    @RequestMapping("/reportBoardList.udc")
    @ResponseBody
    public List reportList(@RequestParam(required=false,defaultValue="1") String pnum, @RequestParam(required=false,defaultValue="review") String reportType){
	//int page=1;
	try{
	    page = Integer.parseInt(pnum);
	    System.out.println(page);
	}catch(Exception e){}
	    System.out.println(reportType);
	    List list = reportService.boardList(page, reportType);
	    
	    return list;
    }
    
    
    @RequestMapping("/reportBoard.udc")
    public ModelAndView reportBoard(@RequestParam(required=false,defaultValue="1") String pnum, @RequestParam(required=false,defaultValue="review") String reportType){
	//int page=1;
	try{
	    page = Integer.parseInt(pnum);
	}catch(Exception e){}
	try{
	    System.out.println(reportType);
	    Map<String, Object> map = reportService.reportList(page, "review");
	    return new ModelAndView("reportList.tilse",map);
	}catch(Exception e){
	    e.printStackTrace();
	    return new ModelAndView("/WEB-INF/view/error.jsp","error_message", e.getMessage());
	}
    }
}
