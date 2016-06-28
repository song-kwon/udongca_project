package kr.co.udongca.controller;

import java.io.*;
import java.util.*;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import kr.co.udongca.service.impl.PrBoardServiceImpl;
import kr.co.udongca.vo.*;

/**
 * 홍보글에 관련된 Controller
 * @author 박재훈
 *
 */
@Controller
@RequestMapping("/prBoard/")
public class PrBoardController {
	/**
	 * 홍보글 관련 Service 객체.
	 * 객체는 Spring Container가 주입.
	 */
	@Autowired
	private PrBoardServiceImpl service;
	
	/**
	 * 현재 제작 중
	 * @param cafeNo
	 * @param map
	 * @return
	 */
	@RequestMapping("prView.udc")
	public String prView(int cafeNo, ModelMap map){
		map.put("prBoard", service.selectPRBoardByNo(cafeNo));
		/*
		 * TODO: 실패했을 경우 JavaScript Alert으로 경고창을 띄운 뒤 뒤로 가기를 하고, 성공했을 때는 내용을 보여 주도록 계획 중
		 */
		return "/ParkTest/prRead.jsp";
	}
	
	/**
	 * 구현 완료
	 * @param map
	 * @param cafeImage
	 * @param menuNameArray
	 * @param menuTypeArray
	 * @param menuImageArray
	 * @param req
	 * @param model
	 * @param session
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("prWrite.udc")
	@Transactional
	public String prWrite(@RequestParam Map map, MultipartFile[] cafeImage,
			String[] menuNameArray, String[] menuTypeArray,
			MultipartFile[] menuImageArray, HttpServletRequest req,
			ModelMap model, HttpSession session)
					throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("licenseemember")){
			return "redirect:/loginPage.udc";
		}
		
		PRBoard prBoard = new PRBoard();
		int cafeNo = service.selectNextPRBoardSequence();
		String cafeRealImagesName="";
		String cafeFakeImagesName="";
		
		/*
		 * TODO: 각 Parameter들이 유효한지 검증하는 단계 필요.
		 */
		prBoard.setCafeNo(cafeNo);
		prBoard.setCafeName((String)map.get("cafeName"));
		prBoard.setCafeIntro((String)map.get("cafeIntro"));
		prBoard.setCafeTel((String)map.get("cafeTel"));
		prBoard.setCafeFeature((String)map.get("cafeFeature"));
		prBoard.setCafeAddress((String)map.get("cafeAddress"));
		prBoard.setCoporateNumb((String)map.get("coporateNumb"));
		prBoard.setOperationHour((String)map.get("operationHour"));
		prBoard.setManagerName((String)map.get("managerName"));
		prBoard.setManagerTel((String)map.get("managerTel"));
		prBoard.setMemberId(mem.getMemberId());
		
		if (cafeImage.length != 0 && cafeImage != null) {
			for(int idx = 0 ; idx < cafeImage.length ; idx++){
				String imageName = cafeImage[idx].getOriginalFilename();// 업로드된 파일명
				
				// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
				// 최종 저장소 디렉토리 조회
				String dir = req.getServletContext().getRealPath("/images");
				long fake = System.currentTimeMillis();
				File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
	
				cafeImage[idx].transferTo(dest);
				cafeRealImagesName += imageName+";";
				cafeFakeImagesName += fake+imageName+";";
			}
		}
		
		prBoard.setCafeRealImage(cafeRealImagesName);
		prBoard.setCafeFakeImage(cafeFakeImagesName);
		
		service.insertPRBoard(prBoard);
		
		for(int i = 0; i < menuNameArray.length; i++){
			menuAdd(cafeNo, menuNameArray[i], menuTypeArray[i], menuImageArray[i], req, session);
		}
		
		return "/prBoard/prView.udc?cafeNo=" + cafeNo;
	}
	
	@RequestMapping("prModifyForm.udc")
	public String prModifyForm(int cafeNo, ModelMap map, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(service.selectPRBoardByNo(cafeNo).getMemberId())){
			return "redirect:/loginPage.udc";
		}
		map.put("prBoard", service.selectPRBoardByNo(cafeNo));
		return "/ParkTest/prModifyForm.jsp";
	}
	
	/**
	 * 현재 제작 중
	 * @param prBoard
	 * @param modifiedCafeFakeImage
	 * @param modifiedCafeRealImage
	 * @param addCafeImage
	 * @param req
	 * @param session
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("prModify.udc")
	public String prModify(@RequestParam Map map, String[] cafeFeature1,
			String[] modifiedCafeFakeImage, String[] modifiedCafeRealImage,
			MultipartFile[] addCafeImage, HttpServletRequest req,
			HttpSession session) throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		String addRealImagesName="";
		String addFakeImagesName="";
		String cafeFeature = "";
		if (mem == null || !mem.getMemberId().equals(map.get("memberId"))){
			return "redirect:/loginPage.udc";
		}
		
		if (cafeFeature1 != null){
			for (int i = 0; i < cafeFeature1.length; i++){
				cafeFeature += cafeFeature1[i] + " ";
			}
		}
		
		if (!((String)map.get("cafeFeature2")).equals("테마 선택")){
			cafeFeature += map.get("cafeFeature2");
		}
		
		if (addCafeImage.length != 0 && addCafeImage != null) {
			for(int idx = 0 ; idx < addCafeImage.length ; idx++){
				String imageName = addCafeImage[idx].getOriginalFilename();// 업로드된 파일명
				
				// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
				// 최종 저장소 디렉토리 조회
				String dir = req.getServletContext().getRealPath("/images");
				long fake = System.currentTimeMillis();
				File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
	
				addCafeImage[idx].transferTo(dest);
				addRealImagesName += imageName+";";
				addFakeImagesName += fake+imageName+";";
			}
		}
		
		String[] originalCafeFakeImage = ((String)(map.get("cafeFakeImage"))).split(";");
		
		for (int i = 0; i < originalCafeFakeImage.length; i++){
			int temp = -1;
			for (int j = 0; j < modifiedCafeFakeImage.length; j++){
				if (originalCafeFakeImage[i].equals(modifiedCafeFakeImage[j])){
					temp = j;
					break;
				}
			}
			if (temp == -1){
				String dir = req.getServletContext().getRealPath("/images");
				File dest = new File(dir, originalCafeFakeImage[i]);
				dest.delete();
			}
		}
		
		String resultFakeImage = String.join(";", modifiedCafeFakeImage) + ";" + addFakeImagesName;
		String resultRealImage = String.join(";", modifiedCafeRealImage) + ";" + addRealImagesName;
		
		service.updatePRBoard(
				new PRBoard(
					Integer.parseInt(((String)map.get("cafeNo"))),
					(String)map.get("cafeName"),
					(String)map.get("cafeIntro"),
					(String)map.get("cafeTel"),
					cafeFeature,
					(String)map.get("cafeAddress"),
					"",
					(String)map.get("operationHour"),
					(String)map.get("managerName"),
					(String)map.get("managerTel"),
					resultRealImage,
					resultFakeImage,
					(String)map.get("memberId")));
		return "/prBoard/prView.udc?cafeNo=" + map.get("cafeNo");
	}
	
	/**
	 * 현재 제작 중
	 * @param cafeNo
	 * @param session
	 * @return
	 */
	@RequestMapping("prDelete.udc")
	public String prDelete(int cafeNo, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(service.selectPRBoardByNo(cafeNo).getMemberId())){
			return "redirect:/loginPage.udc";
		}
		service.deletePRBoard(cafeNo);
		return "/";
	}
	
	/**
	 * 구현 완료
	 * @param coporateNumb
	 * @return
	 */
	@RequestMapping("isCoporateNumbDuplicated.udc")
	@ResponseBody
	public String isCoporateNumbDuplicated(String coporateNumb){
		return "" + (service.selectPRBoardByCoporateNumb(coporateNumb) != null);
	}
	
	/**
	 * 구현 완료
	 * @param map
	 * @param cafeFeature1
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping("moveToNewPr2Jsp.udc")
	public String moveToNewPr2Jsp(@RequestParam Map map, String[] cafeFeature1,
			HttpSession session, ModelMap model){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("licenseemember")){
			return "redirect:/loginPage.udc";
		}
		
		String cafeFeature = "";
		
		if (cafeFeature1 != null){
			for (int i = 0; i < cafeFeature1.length; i++){
				cafeFeature += cafeFeature1[i] + " ";
			}
		}
		
		if (!((String)map.get("cafeFeature2")).equals("테마 선택")){
			cafeFeature += map.get("cafeFeature2");
		}
		
		model.put("cafeName", map.get("cafeName"));
		model.put("cafeIntro", map.get("cafeIntro"));
		model.put("cafeFeature", cafeFeature);
		model.put("operationHour", map.get("operationHour"));
		model.put("cafeTel", map.get("cafeTel"));
		model.put("cafeAddress", map.get("cafeAddress"));
		model.put("coporateNumb", map.get("coporateNumb"));
		model.put("managerName", map.get("managerName"));
		model.put("managerTel", map.get("managerTel"));
		
		return "/ParkTest/prWrite2.jsp";
	}
	
	/**
	 * 현재 제작 중
	 */
	@RequestMapping("mapLocation.udc")
	public void mapLocation(){
		/*
		 * TODO: 매개 변수를 무엇으로? 주소만 따로 JSP에서 받을 예정.
		 */
		return;
	}
	
	/**
	 * 현재 제작 중
	 * @param cafeNumber
	 * @param menuId
	 */
	@RequestMapping("menuList.udc")
	@ResponseBody
	public List menuList(@RequestParam("cafeNumber") int cafeNumber, @RequestParam("menuType") String menuType){
	    HashMap map = new HashMap<>();
	    map.put("cafeNumber", cafeNumber);
	    map.put("menuType", menuType);
	    List list = service.selectMenuListByCafeNoAndMenuType(map);
	    System.out.println(list);
		return list;
	}
	
	/**
	 * 구현 완료
	 * @param cafeNumber
	 * @param menuType
	 * @param menuName
	 * @param menuImage
	 * @param req
	 * @param session
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("menuAdd.udc")
	@Transactional
	public void menuAdd(int cafeNumber, String menuType, String menuName,
			MultipartFile menuImage, HttpServletRequest req,
			HttpSession session)
					throws IllegalStateException, IOException{
		Menu menu = new Menu();
		String menuRealImage = null;
		String menuFakeImage = null;
		int menuNo = service.selectNextMenuSequence();
		
		/*
		 * TODO: 각 Parameter들이 유효한지 검증하는 단계 필요.
		 */
		menu.setMenuNo(menuNo);
		menu.setCafeNo(cafeNumber);
		menu.setMenuType(menuType);
		menu.setMenuName(menuName);
		
		if (menuImage != null) {
			String imageName = menuImage.getOriginalFilename();// 업로드된 파일명
			
			// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
			// 최종 저장소 디렉토리 조회
			String dir = req.getServletContext().getRealPath("/images");
			long fake = System.currentTimeMillis();
			File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.

			menuImage.transferTo(dest);
			
			menuRealImage = imageName;
			menuFakeImage = fake+imageName;
		}
		
		/*
		 * TODO: 만약 Image의 값이 ""이라면, 기본 이미지를 넣게 하는 것도 좋을 듯.
		 */
		menu.setMenuRealImage(menuRealImage);
		menu.setMenuFakeImage(menuFakeImage);
		
		service.insertMenu(menu);
		
		return;
	}
	
	/**
	 * 현재 제작 중
	 * @param menu
	 * @param session
	 */
	@RequestMapping("menuModify.udc")
	public void menuModify(Menu menu, HttpSession session){
		//return service.updateMenu(menu);
		return;
	}
	
	/**
	 * 현재 제작 중
	 * @param menuNO
	 * @param session
	 */
	@RequestMapping("menuDelete.udc")
	public void menuDelete(int menuNO, HttpSession session){
		//return service.deleteMenu(menuNO);
		return;
	}
	/**
	 * 구현 완료
	 * @return
	 */
	@RequestMapping("cafeThemeList.udc")
	@ResponseBody
	public List<Code> cafeThemeList (){
		return service.selectThemeList();
	}
	/**
	 * 구현 완료
	 * @return
	 */
	@RequestMapping("cafeMenuList.udc")
	@ResponseBody
	public List<Code> cafeMenuList (){
		return service.selectMenuList();
	}
}