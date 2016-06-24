package kr.co.udongca.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.NoticeBoardService;
import kr.co.udongca.vo.NoticeBoard;

@Controller
@RequestMapping("/noticeBoard")
public class NoticeBoardController {
	@Autowired
	private NoticeBoardService service;
	
	@RequestMapping("noticeBoardListPaging.udc")
	public ModelAndView selectListNoticeBoard(@RequestParam(required=false) String pnum){
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {}
		
		try {
			Map<String, Object> map = service.selectListNoticeBoard(page);
			return new ModelAndView("noticeBoardList.tiles","map",map);
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/WEB-INF/view/error.jsp","error_message", e.getMessage());
		}
	}
	
	@RequestMapping("registerNoticeBoard.udc")
	public String registerNoticeBoard(NoticeBoard noticeBoard){
		service.registerNoticeBoard(noticeBoard);
		return "redirect:/noticeBoard/noticeBoardRegisterSuccess.udc";
	}
	
	@RequestMapping("deleteNoticeBoard.udc")
	public String deleteNoticeBoard(int noticeNo){
		service.deleteNoticeBoard(noticeNo);
		return "redirect:/noticeBoard/noticeBoardListPaging.udc";
	}
	
	@RequestMapping("modifyNoticeBoardform.udc")
	public ModelAndView modifyNoticeBoardForm(int noticeNo){
		NoticeBoard noticeBoard = service.selectNoticeBoard(noticeNo);
		return new ModelAndView("noticeBoardModifyform.tiles","noticeBoard",noticeBoard);
	}
	
	@RequestMapping("modifyNoticeBoard.udc")
	public String modifyNoticeBoard(NoticeBoard noticeBoard, int noticeNo){
		service.selectNoticeBoard(noticeNo).setNoticeNo(noticeNo);
		service.updateNoticeBoard(noticeBoard);
		return "redirect:/noticeBoard/noticeBoardModifySuccess.udc";
	}
	
	@RequestMapping("noticeBoard.udc")
	public ModelAndView noticeBoard(int noticeNo){
		NoticeBoard noticeBoard = service.selectNoticeBoard(noticeNo);
		return new ModelAndView("noticeBoard.tiles", "noticeBoard", noticeBoard);
	}
}
