package kr.co.udongca.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
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

import kr.co.udongca.service.PrBoardService;
import kr.co.udongca.service.ReviewBoardService;
import kr.co.udongca.service.ReviewReplyService;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.PRBoard;
import kr.co.udongca.vo.ReviewBoard;

@Controller
@RequestMapping({"/member/","/review/"})
public class ReviewBoardController {

	@Autowired
	private ReviewBoardService service;
	@Autowired
	private PrBoardService prService;
	
	@Autowired
	private ReviewReplyService reviewReplyService;
	
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
	
	/*
	@RequestMapping("reviewDetail.udc")
	public ModelAndView reviewDetail(int cafeNo,int reviewNo){
		
		Map map = service.reviewDetail(cafeNo, reviewNo);
		return new ModelAndView("/testView/testReply.jsp",map);
	}
	*/
	
	
	@RequestMapping("reviewDetail.udc")
	@ResponseBody
	public Map reviewDetail(int cafeNo,int reviewNo){
		return service.reviewDetail(cafeNo, reviewNo);
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
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(writerId)){
			return "redirect:/loginPage.udc";
		}
		
		HashMap<String, Integer> inputMap = new HashMap<String, Integer>();
		PRBoard pr = prService.selectPRBoardByNo(cafeNo);
		
		inputMap.put("cafeNo", cafeNo);
		inputMap.put("cafeReviewCount", pr.getCafeReviewCount() - 1);
		inputMap.put("cafeRating", pr.getCafeRating() - service.selectReview(reviewNo).getRatingStars());
		
		service.deleteReview(reviewNo);
		prService.updateCafeRatingInPRBoard(inputMap);
		prService.updateCafeReviewCountInPRBoard(inputMap);
		
		return "/prBoard/prView.udc?cafeNo=" + cafeNo;
	}
	
	@RequestMapping("reviewModifyForm.udc")
	public String reviewModifyForm(int reviewNo, int cafeNo, String writerId,
			ModelMap map, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(writerId)){
			return "redirect:/loginPage.udc";
		}
		map.put("review", service.selectReview(reviewNo));
		map.put("cafeNo", cafeNo);
		return "prBoard/review_modifyForm.tiles";
	}
	
	@RequestMapping("reviewModify.udc")
	public String reviewModify(@RequestParam Map map, MultipartFile[] addReviewImage,
			String[] modifiedReviewFakeImage, String[] modifiedReviewRealImage,
			HttpServletRequest req, HttpSession session, ModelMap model)
					throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(map.get("writerId"))){
			return "redirect:/loginPage.udc";
		}
		
		ArrayList<String> errorList = new ArrayList<String>();
		String addRealImagesName="";
		String addFakeImagesName="";
		HashMap<String, Integer> inputMap = new HashMap<String, Integer>();
		int reviewNo = Integer.parseInt(((String)map.get("reviewNo")));
		int cafeNo = Integer.parseInt((String)(map.get("cafeNo")));
		int ratingStars = Integer.parseInt((String)(map.get("ratingStars")));
		ReviewBoard review = service.selectReview(reviewNo);
		PRBoard pr = prService.selectPRBoardByNo(cafeNo);
		
		if(map.get("reviewTitle") == null || ((String)map.get("reviewTitle")).trim().equals("")){
			errorList.add("리뷰 제목을 입력하세요");
		}
		else if(((String)map.get("reviewTitle")).getBytes("UTF-8").length > 50){
			errorList.add("리뷰 제목이 너무 깁니다");
		}
		
		if (errorList.size() == 0){
			if (!isMultipartFileArrayEmpty(addReviewImage)) {
				for(int idx = 0 ; idx < addReviewImage.length ; idx++){
					String imageName = addReviewImage[idx].getOriginalFilename();// 업로드된 파일명
					
					// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
					// 최종 저장소 디렉토리 조회
					String dir = req.getServletContext().getRealPath("/images");
					long fake = System.currentTimeMillis();
					File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
		
					addReviewImage[idx].transferTo(dest);
					addRealImagesName += imageName+";";
					addFakeImagesName += fake+imageName+";";
				}
			}
			
			String[] originalReviewFakeImage = ((String)(map.get("reviewFakeImage"))).split(";");
			
			for (int i = 0; i < originalReviewFakeImage.length; i++){
				int temp = -1;
				if (!isStringArrayEmpty(modifiedReviewFakeImage)){
					for (int j = 0; j < modifiedReviewFakeImage.length; j++){
						if (originalReviewFakeImage[i].equals(modifiedReviewFakeImage[j])){
							temp = j;
							break;
						}
					}
				}
				if (temp == -1){
					String dir = req.getServletContext().getRealPath("/images");
					File dest = new File(dir, originalReviewFakeImage[i]);
					dest.delete();
				}
			}
			
			String resultFakeImage = (!isStringArrayEmpty(modifiedReviewFakeImage) ? String.join(";", modifiedReviewFakeImage) + ";" : "") + ((!isStringEmpty(addFakeImagesName)) ? addFakeImagesName : ((!isStringArrayEmpty(modifiedReviewFakeImage)) ? "" : ";"));
			String resultRealImage = (!isStringArrayEmpty(modifiedReviewRealImage) ? String.join(";", modifiedReviewRealImage) + ";" : "") + ((!isStringEmpty(addRealImagesName)) ? addRealImagesName : ((!isStringArrayEmpty(modifiedReviewRealImage)) ? "" : ";"));
			
			if (resultRealImage.equals(";")){
				resultRealImage = "defaultReview.png;";
				resultFakeImage = "defaultReview.png;";
			}
			
			inputMap.put("cafeNo", cafeNo);
			inputMap.put("cafeRating", pr.getCafeRating() + ratingStars - review.getRatingStars());
			
			prService.updateCafeRatingInPRBoard(inputMap);
			
			service.updateReview(new ReviewBoard(reviewNo,
					(String)map.get("reviewTitle"),
					null,
					(String)map.get("reviewContent"),
					ratingStars,
					null,
					resultRealImage,
					resultFakeImage,
					0,0));
			
			return "/prBoard/prView.udc?cafeNo=" + cafeNo;
		}
		else{
			model.put("error", errorList);
			return "error.tiles";
		}
		
	}
	
	@RequestMapping("reviewWriteForm.udc")
	public String reviewModifyForm(int cafeNo, ModelMap map, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("generalMember")){
			return "redirect:/loginPage.udc";
		}
		map.put("cafeNo", cafeNo);
		return "prBoard/review_write.tiles";
	}
	
	@RequestMapping("reviewWrite.udc")
	@Transactional
	public String reviewWrite(@RequestParam Map map,MultipartFile[] reviewImage,
			HttpServletRequest req, HttpSession session, ModelMap model)
					throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("generalMember")){
			return "redirect:/loginPage.udc";
		}
		ReviewBoard review = new ReviewBoard();
		ArrayList<String> errorList = new ArrayList<String>();
		String reviewRealImagesName="";
		String reviewFakeImagesName="";
		HashMap<String, Integer> inputMap = new HashMap<String, Integer>();
		int cafeNo = Integer.parseInt((String)(map.get("cafeNo")));
		int ratingStars = Integer.parseInt((String)(map.get("ratingStars")));
		PRBoard pr = prService.selectPRBoardByNo(cafeNo);
		
		if(map.get("reviewTitle") == null || ((String)map.get("reviewTitle")).trim().equals("")){
			errorList.add("리뷰 제목을 입력하세요");
		}
		else if(((String)map.get("reviewTitle")).getBytes("UTF-8").length > 50){
			errorList.add("리뷰 제목이 너무 깁니다");
		}
		
		if (errorList.size() == 0){
			if (!isMultipartFileArrayEmpty(reviewImage)) {
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
			
			review.setReviewRealImage((reviewRealImagesName.equals("")) ? "defaultReview.png;" : reviewRealImagesName);
			review.setReviewFakeImage((reviewFakeImagesName.equals("")) ? "defaultReview.png;" : reviewFakeImagesName);
			
			review.setReviewNo(service.selectNextReviewBoardSequence());
			review.setReviewTitle((String)(map.get("reviewTitle")));
			review.setReviewDate(new Date(System.currentTimeMillis()));
			review.setReviewContent((String)(map.get("reviewContent")));
			review.setRatingStars(ratingStars);
			review.setMemberId(mem.getMemberId());
			review.setCafeNo(cafeNo);
			
			inputMap.put("cafeNo", cafeNo);
			inputMap.put("cafeReviewCount", pr.getCafeReviewCount() + 1);
			inputMap.put("cafeRating", pr.getCafeRating() + ratingStars);
			
			service.insertReview(review);
			prService.updateCafeRatingInPRBoard(inputMap);
			prService.updateCafeReviewCountInPRBoard(inputMap);
			
			return "redirect:/prBoard/prView.udc?cafeNo=" + cafeNo;
		}
		else{
			model.put("error", errorList);
			return "error.tiles";
		}
	}
	
	@RequestMapping("myReviewCafe.udc")
	public String myReviewDetail(int cafeNo,ModelMap map){
		
		return "redirect:/prBoard/prView.udc?cafeNo="+cafeNo;
	}
	
	private boolean isStringEmpty(String str){
		return str == null || str.trim().equals("");
	}
	
	private boolean isStringArrayEmpty(String[] strArray){
		return strArray == null || strArray.length == 0 || strArray[0].equals("");
	}
	
	private boolean isMultipartFileArrayEmpty(MultipartFile[] multiPartFileArray){
		return multiPartFileArray == null || multiPartFileArray.length == 0 || multiPartFileArray[0].isEmpty();
	}
}
