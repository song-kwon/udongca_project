package kr.co.udongca.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.udongca.service.ReviewReplyService;
import kr.co.udongca.service.impl.ReviewReplyServiceImpl;
import kr.co.udongca.vo.ReviewReply;

@Controller
@RequestMapping("/review/")
public class ReviewReplyController {
	@Autowired
	private ReviewReplyService service;
	
	@RequestMapping("addReply.udc")
	@ResponseBody
	public ReviewReply  addReply(ReviewReply reply,HttpSession session){
		if(session.getAttribute("login") != null)
			return service.addReply(reply);
		else return null;
	}
	
	@RequestMapping("addReReply.udc")
	@ResponseBody
	public ReviewReply addReReply(ReviewReply reply,HttpSession session){
		if(session.getAttribute("login") != null){
			ReviewReply reReply = service.addReReply(reply);
			 if( reReply != null);{
				 return reReply;
			 }
		}
		else return null;
	}
	
}
