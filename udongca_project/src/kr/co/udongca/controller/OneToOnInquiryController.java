package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//github.com/song-kwon/udongca_project.git
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.TextUtil;
import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.OneToOneInquiry;

@Controller
@RequestMapping("/oneToOneInquiry")
public class OneToOnInquiryController {
    @Autowired
    private OneToOneInquiryService service;

    @RequestMapping("oneToOneInquiryListPaging.udc")
    public ModelAndView selectListOneToOneInquiry(@RequestParam(required = false) String pnum, HttpSession session) {
    	Member master = (Member)session.getAttribute("login");
    	
    	if(master!=null && master.getMemberType().equals("master")){
    		int page = 1;
        	try {
        		page = Integer.parseInt(pnum);
        		} catch (Exception e) {
        	}

        	try {
        		Map<String, Object> map = service.selectListOneToOneInquiry(page);
        		return new ModelAndView("oneToOneInquiry/oneToOneInquiryList.tiles", "map", map);
        	} catch (Exception e) {
        		e.printStackTrace();
        		return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
        	}
    	}else{
    		return new ModelAndView("/loginPage.udc","error"," 마스터 로그인이 필요합니다.");
    	}
    	
    	
    }
    
    @RequestMapping("registerOneToOneInquiryform.udc")
    public ModelAndView registerOneToOneInquiryform(String codeType, HttpSession session){
    	Member login = (Member)session.getAttribute("login");
  
    	if(login!=null){
    		List<Code> codeList = service.selectByCodeType(codeType);
        	return new ModelAndView("oneToOneInquiry/oneToOneInquiryRegisterform.tiles","codeList",codeList);
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
    }

    @RequestMapping("registerOneToOneInquiry.udc")
    public ModelAndView registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry, String memberId, HttpSession session) {
    	Member login = (Member)session.getAttribute("login");
    	if(login!=null){
        	oneToOneInquiry.setInquiryTitle(TextUtil.textToHtml(oneToOneInquiry.getInquiryTitle()));
    		oneToOneInquiry.setInquiryContent(TextUtil.textToHtml(oneToOneInquiry.getInquiryContent()));
        	
    		service.registerOneToOneInquiry(oneToOneInquiry, memberId);
    		return new ModelAndView("redirect:/oneToOneInquiry/oneToOneInquiryRegisterSuccess.udc");
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
    }
    
    @RequestMapping("deleteOneToOneInquiryMember.udc")
    public ModelAndView deleteOneToOneInquiryMember(int inquiryNo, HttpSession session){
    	Member login = (Member)session.getAttribute("login");
    	
    	if(login!=null){
    		service.deleteOneToOneInquiry(inquiryNo);
        	return new ModelAndView("redirect:/member/memberInquiryListPaging.udc");
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
    }

    @RequestMapping("deleteOneToOneInquiryMaster.udc")
    public ModelAndView deleteOneToOneInquiryMaster(int inquiryNo, HttpSession session) {
    	Member login = (Member)session.getAttribute("login");
    	
    	if(login!=null){
    		service.deleteOneToOneInquiry(inquiryNo);
    		return new ModelAndView("redirect:/oneToOneInquiry/oneToOneInquiryListPaging.udc");
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
    }

    @RequestMapping("modifyOneToOneInquiryform.udc")
    public ModelAndView oneToOneInquiryModifyForm(int inquiryNo, String codeType, HttpSession session) {
    	Member login = (Member)session.getAttribute("login");
    	if( login!=null && (login.getMemberType().equals("generalMember") || login.getMemberType().equals("licenseeMember")) ){
    		OneToOneInquiry oneToOneInquiry = service.selectOneToOneInquiry(inquiryNo);
    		
    		oneToOneInquiry.setInquiryTitle(TextUtil.htmlToText(oneToOneInquiry.getInquiryTitle()));
        	oneToOneInquiry.setInquiryContent(TextUtil.htmlToText(oneToOneInquiry.getInquiryContent()));
    		
    		List<Code> codeList = service.selectByCodeType(codeType);
    		
    		HashMap map = new HashMap();
    		map.put("oneToOneInquiry", oneToOneInquiry);
    		map.put("codeList", codeList);
    		
    		return new ModelAndView("oneToOneInquiry/oneToOneInquiryModify.tiles", "map", map);
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
	
    }

    @RequestMapping("modifyOneToOneInquiry.udc")
    public ModelAndView modifyOneToOneInquiry(OneToOneInquiry afterInquiry, int inquiryNo, HttpSession session) {
    	Member login = (Member)session.getAttribute("login");
    	if( login!=null && (login.getMemberType().equals("generalMember") || login.getMemberType().equals("licenseeMember")) ){
    		afterInquiry.setInquiryTitle(TextUtil.textToHtml(afterInquiry.getInquiryTitle()));
    		afterInquiry.setInquiryContent(TextUtil.textToHtml(afterInquiry.getInquiryContent()));
    		
    		service.selectOneToOneInquiry(inquiryNo).setInquiryNo(inquiryNo);
			service.updateOneToOneInquiry(afterInquiry);
		
			return new ModelAndView("redirect:/oneToOneInquiry/oneToOneInquiryModifySuccess.udc");
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
    }

    @RequestMapping("modifyOneToOneInquiryReplyform.udc")
    public ModelAndView oneToOneInquiryReplyModifyForm(int inquiryNo, HttpSession session) {
    	Member master = (Member)session.getAttribute("login");
    	if(master!=null && master.getMemberType().equals("master")){
    		OneToOneInquiry oneToOneInquiry = service.selectOneToOneInquiry(inquiryNo);
    		
    		if((oneToOneInquiry.getInquiryReply()!=null) && (!oneToOneInquiry.getInquiryReply().equals(""))){
    			oneToOneInquiry.setInquiryReply(TextUtil.htmlToText(oneToOneInquiry.getInquiryReply()));
    		}
    			
    		return new ModelAndView("oneToOneInquiry/oneToOneInquiryReplyModify.tiles", "oneToOneInquiry", oneToOneInquiry);
    	}else{
    		return new ModelAndView("/loginPage.udc","error","마스터 로그인이 필요합니다.");
    	}
	
    }

    @RequestMapping("modifyOneToOneInquiryReply.udc")
    public ModelAndView oneToOneInquiryReply(OneToOneInquiry afterInquiry, HttpSession session) {
    	Member master = (Member)session.getAttribute("login");
    	if(master!=null && master.getMemberType().equals("master")){
    		afterInquiry.setInquiryReply(TextUtil.textToHtml(afterInquiry.getInquiryReply()));
    		service.updateReplyOneToOneInquiry(afterInquiry);
    		return new ModelAndView("redirect:/oneToOneInquiry/oneToOneInquiryModifySuccess.udc");
    	}else{
    		return new ModelAndView("/loginPage.udc","error","마스터 로그인이 필요합니다.");
    	}
    }

    @RequestMapping("oneToOneInquiry.udc")
    public ModelAndView oneToOneInquiry(int inquiryNo, String memberId, HttpSession session) {
    	Member login = (Member)session.getAttribute("login");
    	OneToOneInquiry inquiry = service.selectOneToOneInquiry(inquiryNo);
    	
    	if(login!=null && ( login.getMemberId().equals(inquiry.getMemberId()) || login.getMemberType().equals("master")) ){
    		HashMap map = new HashMap();
    		map.put("oneToOneInquiry", inquiry);
    		map.put("memberId", memberId);

    		return new ModelAndView("oneToOneInquiry/oneToOneInquiry.tiles", "map", map);
    	}else if( login!=null && (! login.getMemberId().equals(inquiry.getMemberId())) && (!login.getMemberType().equals("master")) ){
    		return new ModelAndView("error.tiles","error","자신이 작성한 문의글만 조회 가능합니다.");
    	}else{
    		return new ModelAndView("/loginPage.udc","error","로그인이 필요합니다.");
    	}
    }

    @RequestMapping("/oneList.udc")
    @ResponseBody
    public Map reportBoard(@RequestParam(required = false) String pnum,HttpSession session) {
	int page = 1;
	Member master = (Member) session.getAttribute("login");
	HashMap map = new HashMap<>();
	if (master != null && master.getMemberType().equals("master")) {
	    try {
		page = Integer.parseInt(pnum);
	    } catch (Exception e) {  }
	    	map.put("list", service.oneToOneList(page));
	    	map.put("page", service.page(page));
		return map;
	} else {
	    map.put("권한", "권한이 없습니다.");
	    return map;
	}
    }
    @RequestMapping("master/oneInfo.udc")
    @ResponseBody
    public Map oneInfo(@RequestParam("inquiryNo") int inquiryNo, @RequestParam("page") int page, Model model, HttpSession session) {
	Member master = (Member) session.getAttribute("login");
	HashMap map = new HashMap();
	if (master != null && master.getMemberType().equals("master")) {
	    map.put("inquiry", service.selectOneInquiry(inquiryNo));
	    map.put("page", page);
	return map;
	}else {
	    map.put("권한", "권한이 없습니다.");
	    return map;
	}
    }

    @RequestMapping("master/requiryReply.udc")
    @ResponseBody
    @Transactional
    public Map requiryReply(@ModelAttribute("requiry") OneToOneInquiry oneToOneInquiry) {
	HashMap map = new HashMap();
	
	if(oneToOneInquiry.getInquiryReply()==null&&oneToOneInquiry.getInquiryReply().length()==0){
	    map.put("error", "답변을 등록하세요");
	}else{
	    map.put("value", service.updateInquiryReply(oneToOneInquiry));
	}
	return map;
    }

    @RequestMapping("viewInquiry.udc")
    public ModelAndView viewInquiry(int inquiryNo) {
	ModelAndView mav;
	OneToOneInquiry oto = service.selectOneToOneInquiry(inquiryNo);

	if (oto == null) {
	    mav = new ModelAndView("memberInquiryListPaging.udc", "error", "선택한 번호의 문의글은 없습니다.");
	} else {
	    mav = new ModelAndView("member/oneToOneInquiry.tiles", "map", oto);
	}
	return mav;
    }
}
