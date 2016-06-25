package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//github.com/song-kwon/udongca_project.git
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.OneToOneInquiryService;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.OneToOneInquiry;

@Controller
@RequestMapping("/oneToOneInquiry")
public class OneToOnInquiryController {
    @Autowired
    private OneToOneInquiryService service;

    @RequestMapping("oneToOneInquiryListPaging.udc")
    public ModelAndView selectListNoticeBoard(@RequestParam(required = false) String pnum) {
	int page = 1;
	try {
	    page = Integer.parseInt(pnum);
	} catch (Exception e) {
	}

	try {
	    Map<String, Object> map = service.selectListOneToOneInquiry(page);
	    return new ModelAndView("oneToOneInquiryList.tiles", "map", map);
	} catch (Exception e) {
	    e.printStackTrace();
	    return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
	}
    }

    @RequestMapping("registerOneToOneInquiry.udc")
    public String registerOneToOneInquiry(OneToOneInquiry oneToOneInquiry, String memberId) {
	service.registerOneToOneInquiry(oneToOneInquiry, memberId);
	return "redirect:/oneToOneInquiry/oneToOneInquiryRegisterSuccess.udc";
    }

    @RequestMapping("deleteOneToOneInquiry.udc")
    public String deleteOneToOneInquiry(int inquiryNo) {
	service.deleteOneToOneInquiry(inquiryNo);
	return "redirect:/oneToOneInquiry/oneToOneInquiryListPaging.udc";
    }

    @RequestMapping("modifyOneToOneInquiryform.udc")
    public ModelAndView oneToOneInquiryModifyForm(int inquiryNo) {
	OneToOneInquiry oneToOneInquiry = service.selectOneToOneInquiry(inquiryNo);
	return new ModelAndView("oneToOneInquiryModifyform.tiles", "oneToOneInquiry", oneToOneInquiry);
    }

    @RequestMapping("modifyOneToOneInquiry.udc")
    public String modifyOneToOneInquiry(OneToOneInquiry afterInquiry, int inquiryNo) {
	service.selectOneToOneInquiry(inquiryNo).setInquiryNo(inquiryNo);
	service.updateOneToOneInquiry(afterInquiry);

	return "redirect:/oneToOneInquiry/oneToOneInquiryModifySuccess.udc";
    }

    @RequestMapping("modifyOneToOneInquiryReplyform.udc")
    public ModelAndView oneToOneInquiryReplyModifyForm(int inquiryNo) {
	OneToOneInquiry oneToOneInquiry = service.selectOneToOneInquiry(inquiryNo);

	return new ModelAndView("oneToOneInquiryReplyModify.tiles", "oneToOneInquiry", oneToOneInquiry);
    }

    @RequestMapping("modifyOneToOneInquiryReply.udc")
    public String oneToOneInquiryReply(OneToOneInquiry afterInquiry) {
	service.updateReplyOneToOneInquiry(afterInquiry);

	return "redirect:/oneToOneInquiry/oneToOneInquiryModifySuccess.udc";
    }

    @RequestMapping("oneToOneInquiry.udc")
    public ModelAndView oneToOneInquiry(int inquiryNo, String memberId) {
	OneToOneInquiry inquiry = service.selectOneToOneInquiry(inquiryNo);

	HashMap map = new HashMap();
	map.put("oneToOneInquiry", inquiry);
	map.put("memberId", memberId);

	return new ModelAndView("oneToOneInquiry.tiles", "map", map);
    }

    @RequestMapping("master/oneToOneList.udc")
    public ModelAndView reportBoard(@RequestParam(required = false) String pnum,HttpSession session) {
	int page = 1;
	Member master = (Member) session.getAttribute("login");
	if (master != null && master.getMemberType().equals("master")) {

	    try {
		page = Integer.parseInt(pnum);
	    } catch (Exception e) {
	    }
	    try {
		Map<String, Object> list = service.oneToOneList(page);
		return new ModelAndView("master/master_oneToOneList.tilse", list);
	    } catch (Exception e) {
		e.printStackTrace();
		return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
	    }
	} else {
	    return new ModelAndView("redirect:/main.udc");
	}
    }

    @RequestMapping("master/oneInfo.udc")
    public String oneInfo(@RequestParam("inquiryNo") int inquiryNo, @RequestParam("page") int page, Model model) {
	System.out.println(service.selectOneInquiry(inquiryNo));
	model.addAttribute("inquiryNo", service.selectOneInquiry(inquiryNo));
	model.addAttribute("page", page);
	return "master/master_oneToOneInfo.tiles";
    }

    @RequestMapping("master/requiryReply.udc")
    @ResponseBody
    public int requiryReply(@ModelAttribute("requiry") OneToOneInquiry oneToOneInquiry) {
	return service.updateInquiryReply(oneToOneInquiry);
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
