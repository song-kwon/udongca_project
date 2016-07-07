package kr.co.udongca.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.common.util.TextUtil;
import kr.co.udongca.service.NoticeBoardService;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.NoticeBoard;

@Controller
@RequestMapping("/noticeBoard")
public class NoticeBoardController {
	
	@Autowired
	private NoticeBoardService service; 
	
	@RequestMapping("/noticeBoardListPaging.udc")
	public ModelAndView selectListNoticeBoard(@RequestParam(required=false) String pnum){
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {} 
		
		try {
			Map<String, Object> map = service.selectListNoticeBoard(page);
			return new ModelAndView("noticeBoard/noticeBoardList.tiles","map",map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/WEB-INF/view/error.jsp","error_message", e.getMessage());
		}
	}
	
	@RequestMapping("registerNoticeBoardform.udc")
	public ModelAndView registerNoticeBoardform(String codeType, HttpSession session){
		Member master = (Member)session.getAttribute("login");
		List<Code> codeList = service.selectByCodeType(codeType);
		
		if(master != null && master.getMemberType().equals("master"))
			return new ModelAndView("noticeBoard/noticeBoardRegisterform.tiles","codeList",codeList);
		else
		    return new ModelAndView("/loginPage.udc","error"," 마스터 로그인이 필요합니다.");
	}
	
	@RequestMapping("registerNoticeBoard.udc")
	public ModelAndView registerNoticeBoard(NoticeBoard noticeBoard, HttpSession session){
		Member master = (Member)session.getAttribute("login");
	
		if(master != null && master.getMemberType().equals("master")){
			noticeBoard.setNoticeTitle(TextUtil.textToHtml(noticeBoard.getNoticeTitle()));
			noticeBoard.setNoticeContent(TextUtil.textToHtml(noticeBoard.getNoticeContent()));
			service.registerNoticeBoard(noticeBoard);
		
			return new ModelAndView("redirect:/noticeBoard/noticeBoardRegisterSuccess.udc");
		}
		else
		    return new ModelAndView("/loginPage.udc","error"," 마스터 로그인이 필요합니다.");
	}
	
	@RequestMapping("selectByCodeType.udc")
	@ResponseBody
	public List<Code> selectByCodeType(String codeType){
		List<Code> codeList = service.selectByCodeType(codeType);
		return codeList;
	}
	
	@RequestMapping("deleteNoticeBoard.udc")
	public ModelAndView deleteNoticeBoard(int noticeNo, HttpSession session){
		Member master = (Member)session.getAttribute("login");
		service.deleteNoticeBoard(noticeNo);
		
		if(master != null && master.getMemberType().equals("master"))
			return new ModelAndView("redirect:/noticeBoard/noticeBoardListPaging.udc");
		else
		    return new ModelAndView("/loginPage.udc","error"," 마스터 로그인이 필요합니다.");
	}
	
	@RequestMapping("modifyNoticeBoardform.udc")
	public ModelAndView modifyNoticeBoardForm(int noticeNo, String codeType, HttpSession session){
		Member master = (Member)session.getAttribute("login");
	
		if(master != null && master.getMemberType().equals("master")){
			
			NoticeBoard noticeBoard = service.selectNoticeBoard(noticeNo);
			
			noticeBoard.setNoticeTitle(TextUtil.htmlToText(noticeBoard.getNoticeTitle()));
			noticeBoard.setNoticeContent(TextUtil.htmlToText(noticeBoard.getNoticeContent()));
			
			List<Code> codeList = service.selectByCodeType(codeType);
			
			HashMap map = new HashMap();
			map.put("noticeBoard", noticeBoard);
			map.put("codeList", codeList); 
		
			return new ModelAndView("noticeBoard/noticeBoardModify.tiles","map",map);
		}
		else
		    return new ModelAndView("/loginPage.udc","error"," 마스터 로그인이 필요합니다.");
	}
	
	@RequestMapping("modifyNoticeBoard.udc")
	public ModelAndView modifyNoticeBoard(NoticeBoard noticeBoard, int noticeNo, HttpSession session){
		Member master = (Member)session.getAttribute("login");
		
		if(master != null && master.getMemberType().equals("master")){

			noticeBoard.setNoticeTitle(TextUtil.textToHtml(noticeBoard.getNoticeTitle()));
			noticeBoard.setNoticeContent(TextUtil.textToHtml(noticeBoard.getNoticeContent()));
			
			service.selectNoticeBoard(noticeNo).setNoticeNo(noticeNo);
			service.updateNoticeBoard(noticeBoard);
		
			return new ModelAndView("redirect:/noticeBoard/noticeBoardModifySuccess.udc");
		}
		else
		    return new ModelAndView("/loginPage.udc","error"," 마스터 로그인이 필요합니다.");
	}
	
	@RequestMapping("noticeBoard.udc")
	public ModelAndView noticeBoard(int noticeNo){
		NoticeBoard noticeBoard = service.selectNoticeBoard(noticeNo);
		return new ModelAndView("noticeBoard/noticeBoard.tiles", "noticeBoard", noticeBoard);
	}
}
