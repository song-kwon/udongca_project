package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
}
