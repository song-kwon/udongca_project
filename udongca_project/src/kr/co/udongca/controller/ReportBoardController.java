package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.ReportBoardService;
import kr.co.udongca.vo.ReportBoard;

@Controller
@RequestMapping("/master")
public class ReportBoardController {
    @Autowired
    private ReportBoardService reportService;
    
    @RequestMapping("/reportBoard.udc")
    public ModelAndView reportBoard(@RequestParam(required=false) String pnum,@RequestParam String reportType){
	int page=1;
	try{
	    page = Integer.parseInt(pnum);
	}catch(Exception e){}
	try{
	    Map<String, Object> list = reportService.reportList(page,reportType); 
	    ModelAndView mav = new ModelAndView("reportList.tilse");
	    mav.addObject("list",list);
	    mav.addObject("reportType",reportType);
	    return mav;
	}catch(Exception e){
	    e.printStackTrace();
	    return new ModelAndView("/WEB-INF/view/error.jsp","error_message", e.getMessage());
	}
    }
   @RequestMapping("/reportBoardInfo.udc")
   public String reportBoardInfo(@RequestParam("reportNo") int reportNo,@RequestParam("page") int page, Model model){
       model.addAttribute("reportInfo",reportService.reportInfo(reportNo));
       model.addAttribute("page",page);
       return "master/master_reportBoardInfo.tiles";
   }
   @RequestMapping("/updateInfo.udc")
   @ResponseBody
   public int updateInfo(@ModelAttribute ReportBoard reportBoard,@RequestParam("page") int page, Model model){
//       model.addAttribute("page",page);
//       model.addAttribute("result",reportService.updateReport(reportBoard));
      System.out.println(reportBoard);
       //HashMap map= new HashMap();
       //map.put("page", page);
       //map.put("result", reportService.updateReport(reportBoard));
       return reportService.updateReport(reportBoard);
   }
   @RequestMapping("/deleteArticle.udc")
   @ResponseBody
   public int deleteArticle(@RequestParam("reportType") String reportType, @RequestParam("reportNO") int reportNo){
       return reportService.deleteArticle(reportType, reportNo);
   }
}
