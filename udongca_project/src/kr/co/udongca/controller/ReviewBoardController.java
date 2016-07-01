package kr.co.udongca.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.udongca.service.ReviewBoardService;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.ReviewBoard;

@Controller
@RequestMapping({"/member/","/review/"})
public class ReviewBoardController {

	@Autowired
	private ReviewBoardService service;
	
	public ReviewBoardController() {
	}

	@RequestMapping("memberReviewListPaging.udc")
	public ModelAndView memberReviewListPageing(@RequestParam(required = false) String pnum,HttpSession session) {
		Member login = (Member)session.getAttribute("login");
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			 
			return service.myReviewListPaging(page, login.getMemberId());
		} catch (Exception e) {
			e.printStackTrace();
			return new ModelAndView("/WEB-INF/view/error.jsp", "error_message", e.getMessage());
		}
	}
	
	@RequestMapping("reviewDetail.udc")
	public ModelAndView reviewDetail(int cafeNo,int reviewNo){
		
		Map map = service.reviewDetail(cafeNo, reviewNo);
		return new ModelAndView("/testView/testReply.jsp",map);
	}
	
	@RequestMapping("cafeReviewListPaging.udc")
	@ResponseBody
	public Map cafeReviewListPageing(@RequestParam(required = false) String pnum, 
			int cafeNo, HttpSession session) {
		int page = 1;
		try {
			page = Integer.parseInt(pnum);
		} catch (Exception e) {
		}
		try {
			return service.cafeReviewListPaging(page, cafeNo);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	@RequestMapping("reviewRead.udc")
	@ResponseBody
	public ReviewBoard reviewRead(int reviewNo){
		return service.selectReview(reviewNo);
	}
	
	@RequestMapping("reviewDelete.udc")
	public String reviewDelete(int reviewNo, String writerId,
			int cafeNo, HttpSession session){
		System.out.println(writerId);
		Member mem = (Member)session.getAttribute("login");
		System.out.println(mem.getMemberId());
		if (mem == null || !mem.getMemberId().equals(writerId)){
			return "redirect:/loginPage.udc";
		}
		service.deleteReview(reviewNo);
		return "/prBoard/prView.udc?cafeNo=" + cafeNo;
	}
	
	@RequestMapping("reviewModifyForm.udc")
	public String reviewModifyForm(int reviewNo, String writerId,
			ModelMap map, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(writerId)){
			return "redirect:/loginPage.udc";
		}
		map.put("review", service.selectReview(reviewNo));
		return "/ParkTest/reviewModifyForm.jsp";
	}
	
	@RequestMapping("reviewModify.udc")
	public String reviewModify(){
		return null;
	}
	
	@RequestMapping("reviewWriteForm.udc")
	public String reviewModifyForm(int cafeNo, ModelMap map, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("generalMember")){
			return "redirect:/loginPage.udc";
		}
		map.put("cafeNo", cafeNo);
		return "/ParkTest/reviewWrite.jsp";
	}
	
	@RequestMapping("reviewWrite.udc")
	@Transactional
	public String reviewWrite(@RequestParam Map map,MultipartFile[] reviewImage,
			HttpServletRequest req, HttpSession session)
					throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("generalMember")){
			return "redirect:/loginPage.udc";
		}
		
		ReviewBoard review = new ReviewBoard();
		String reviewRealImagesName="";
		String reviewFakeImagesName="";
		
		System.out.println(map.get("cafeNo"));
		
		review.setReviewNo(service.selectNextReviewBoardSequence());
		review.setReviewTitle((String)(map.get("reviewTitle")));
		review.setReviewDate(new Date(System.currentTimeMillis()));
		review.setReviewContent((String)(map.get("reviewContent")));
		review.setReviewGrade((String)(map.get("reviewGrade")));
		review.setMemberId(mem.getMemberId());
		review.setCafeNo(Integer.parseInt((String)(map.get("cafeNo"))));
		
		if (reviewImage.length != 0 && reviewImage != null) {
			for(int idx = 0 ; idx < reviewImage.length ; idx++){
				String imageName = reviewImage[idx].getOriginalFilename();// 업로드된 파일명
				
				// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
				// 최종 저장소 디렉토리 조회
				String dir = req.getServletContext().getRealPath("/images");
				long fake = System.currentTimeMillis();
				File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
	
				reviewImage[idx].transferTo(dest);
				reviewRealImagesName += imageName+";";
				reviewFakeImagesName += fake+imageName+";";
			}
		}
		
		review.setReviewRealImage(reviewRealImagesName);
		review.setReviewFakeImage(reviewFakeImagesName);
		
		service.insertReview(review);
		
		return "/prBoard/prView.udc?cafeNo=" + (String)(map.get("cafeNo"));
	}
}
