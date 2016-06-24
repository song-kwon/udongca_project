package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.vo.OneToOneInquiry;

@Controller
@RequestMapping("/controller/")
public class OneToOnInquiryController {
	@Autowired
	private OneToOneInquiryService service;
	
	@RequestMapping("oneToOneInquiryList.udc")
	public ModelAndView selectListOneToOneInquiry(){
		List<OneToOneInquiry> inquiryList = service.selectListOneToOneInquiry();
		return new ModelAndView("oneToOneInquiryList.tiles","oneToOneInquiryList",inquiryList);
	}
	
	@RequestMapping("registerOneToOneInquiry.udc")
	public ModelAndView registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry, String memberId){
		service.registerOneToOneInquiry(oneToOneInquiry);
		return new ModelAndView("redirect:/oneToOneInquiry/oneToOneInquiryRegisterSuccess.tiles", "memberId", memberId);
	}
	
	@RequestMapping("deleteOneToOneInquiry.udc")
	public String deleteOneToOneInquiry(int inquiryNo){
		service.deleteOneToOneInquiry(inquiryNo);
		return "redirect:/oneToOneInquiry/oneToOneInquiryList.udc";
	}
	
	@RequestMapping("modifyNoticeBoardform.udc")
	public ModelAndView oneToOneInquiryModifyForm(int inquiryNo, String memberId){
		OneToOneInquiry oneToOneInquiry = service.selectOneToOneInquiry(inquiryNo);
		return new ModelAndView("oneToOneInquiryModifyform.tiles","oneToOneInquiry", oneToOneInquiry);
	}
	
	@RequestMapping("modifyOneToOneInquiry.udc")
	public ModelAndView modifyOneToOneInquiry(int inquiryNo, String memberId){
		service.updateOneToOneInquiry(inquiryNo);
		return new ModelAndView("redirect:/oneToOneInquiry/oneToOneInquiryModifySuccess.tiles","memberId",memberId);
	}
	
	@RequestMapping("oneToOneInquiry.udc")
	public ModelAndView oneToOneInquiry(int inquiryNo, String memberId){
		OneToOneInquiry inquiry  = service.selectOneToOneInquiry(inquiryNo);
		
		HashMap map = new HashMap();
		map.put("oneToOneInquiry", inquiry);
		map.put("memberId", memberId);
		
		return new ModelAndView("oneToOneInquiry.tiles","map", map);
	}
	 @RequestMapping("master/oneToOneList.udc")
	    public ModelAndView reportBoard(@RequestParam(required=false) String pnum){
		int page=1;
		try{
		    page = Integer.parseInt(pnum);
		}catch(Exception e){}
		try{
		    Map<String, Object> list = service.oneToOneList(page); 
		    return new ModelAndView("oneToOneList.tilse",list);
		}catch(Exception e){
		    e.printStackTrace();
		    return new ModelAndView("/WEB-INF/view/error.jsp","error_message", e.getMessage());
		}
	    }
	@RequestMapping("master/oneInfo.udc")
	  public String oneInfo(@RequestParam("inquiryNo") int inquiryNo, @RequestParam("page") int page,Model model){
	    System.out.println(service.selectOneInquiry(inquiryNo));
	     model.addAttribute("inquiryNo",service.selectOneInquiry(inquiryNo));
	      model.addAttribute("page",page);
	    return "master/master_oneToOneInfo.tiles";
	}
	@RequestMapping("master/requiryReply.udc")
	@ResponseBody
	 public int requiryReply(@ModelAttribute("requiry") OneToOneInquiry oneToOneInquiry){
	    return service.updateInquiryReply(oneToOneInquiry);
	}
}
