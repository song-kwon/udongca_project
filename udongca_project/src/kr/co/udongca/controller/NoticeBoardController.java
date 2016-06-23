package kr.co.udongca.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.NoticeBoardService;
import kr.co.udongca.vo.NoticeBoard;

@Controller
@RequestMapping("/noticeBoard/")
public class NoticeBoardController {
	
	@Autowired
	private NoticeBoardService service;
	
	@RequestMapping("noticeBoardList.udc")
	public ModelAndView selectListNoticeBoard(){
		List<NoticeBoard> noticeBoardList = service.selectListNoticeBoard();
		return new ModelAndView("noticeBoardList.tiles","noticeBoardList",noticeBoardList);
	}
	
	@RequestMapping("registerNoticeBoard.udc")
	public String registerNoticeBoard(NoticeBoard noticeBoard){
		service.registerNoticeBoard(noticeBoard);
		return "redirect:/noticeBoard/noticeBoardRegisterSuccess.tiles";
	}
	
	@RequestMapping("deleteNoticeBoard.udc")
	public String deleteNoticeBoard(int noticeNo){
		service.deleteNoticeBoard(noticeNo);
		return "redirect:/noticeBoard/noticeBoardList.udc";
	}
	
	@RequestMapping("modifyNoticeBoardform.udc")
	public ModelAndView modifyNoticeBoardForm(int noticeNo){
		NoticeBoard noticeBoard = service.selectNoticeBoard(noticeNo);
		return new ModelAndView("noticeBoardModifyform.tiles","noticeBoard",noticeBoard);
	}
	
	@RequestMapping("modifyNoticeBoard.udc")
	public String modifyNoticeBoard(int noticeNo){
		service.updateNoticeBoard(noticeNo);
		return "redirect:/noticeBoard/noticeBoardModifySuccess.tiles";
	}
	
	@RequestMapping("noticeBoard.udc")
	public ModelAndView noticeBoard(int noticeNo){
		NoticeBoard noticeBoard = service.selectNoticeBoard(noticeNo);
		return new ModelAndView("noticeBoard.tiles", "noticeBoard", noticeBoard);
	}
}
