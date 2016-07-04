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
		return "prBoard_view.tiles";
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
		if (mem == null || !mem.getMemberType().equals("licenseeMember")){
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
		prBoard.setCoporateNumber((String)map.get("coporateNumber"));
		prBoard.setOperationHour((String)map.get("operationHour"));
		prBoard.setManagerName((String)map.get("managerName"));
		prBoard.setManagerTel((String)map.get("managerTel"));
		prBoard.setMemberId(mem.getMemberId());
		
		if (cafeImage != null && cafeImage.length != 0 && !cafeImage[0].isEmpty()) {
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
		
		prBoard.setCafeRealImage((cafeRealImagesName.equals("") ? "defaultCafe.png;" : cafeRealImagesName));
		prBoard.setCafeFakeImage((cafeFakeImagesName.equals("") ? "defaultCafe.png;" : cafeFakeImagesName));
		
		service.insertPRBoard(prBoard);
		
		for(int i = 0; i < menuNameArray.length; i++){
			menuAdd(cafeNo, menuTypeArray[i], menuNameArray[i], menuImageArray[i], req, session);
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
		
		if (addCafeImage != null && addCafeImage.length != 0 && !addCafeImage[0].isEmpty()) {
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
			if (modifiedCafeFakeImage != null && modifiedCafeFakeImage.length != 0 && modifiedCafeFakeImage[0].equals("")){
				for (int j = 0; j < modifiedCafeFakeImage.length; j++){
					if (originalCafeFakeImage[i].equals(modifiedCafeFakeImage[j])){
						temp = j;
						break;
					}
				}
			}
			if (temp == -1){
				String dir = req.getServletContext().getRealPath("/images");
				File dest = new File(dir, originalCafeFakeImage[i]);
				dest.delete();
			}
		}
		
		String resultFakeImage = ((modifiedCafeFakeImage != null && modifiedCafeFakeImage.length != 0 && modifiedCafeFakeImage[0].equals("")) ? String.join(";", modifiedCafeFakeImage) : "") + ";" + addFakeImagesName;
		String resultRealImage = ((modifiedCafeRealImage != null && modifiedCafeRealImage.length != 0 && modifiedCafeRealImage[0].equals("")) ? String.join(";", modifiedCafeRealImage) : "") + ";" + addRealImagesName;
		
		if (resultRealImage.equals(";")){
			resultRealImage = "defaultCafe.png;";
			resultFakeImage = "defaultCafe.png;";
		}
		
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
					(String)map.get("memberId"),
					0,
					0,
					null));
		return "/prBoard/prView.udc?cafeNo=" + map.get("cafeNo");
	}
	
	/**
	 * 구현 완료
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
	@RequestMapping("isCoporateNumberDuplicated.udc")
	@ResponseBody
	public String isCoporateNumberDuplicated(String coporateNumber){
		return "" + (service.selectPRBoardByCoporateNumber(coporateNumber) != null);
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
		if (mem == null || !mem.getMemberType().equals("licenseeMember")){
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
		model.put("coporateNumber", map.get("coporateNumber"));
		model.put("managerName", map.get("managerName"));
		model.put("managerTel", map.get("managerTel"));
		
		return "prBoard_write_form2.tiles";
	}
	
	/**
	 * 구현 완료
	 * @param cafeNumber
	 * @param menuType
	 */
	@RequestMapping("menuList.udc")
	@ResponseBody
	public List<Menu> menuList(int cafeNumber, String menuType){
		HashMap map = new HashMap();
		map.put("cafeNo", cafeNumber);
		map.put("menuType", menuType);
		return service.selectMenuListByCafeNoAndMenuType(map);
	}
	
	/**
	 * 구현 완료
	 * @param cafeNumber
	 * @return
	 */
	@RequestMapping("menuListAll.udc")
	@ResponseBody
	public List<Menu> menuListAll(int cafeNumber){
		return service.selectMenuListByCafeNo(cafeNumber);
	}
	
	/**
	 * 구현 완료
	 * @param menuNo
	 * @return
	 */
	@RequestMapping("menuRead.udc")
	@ResponseBody
	public Menu menuRead(int menuNo){
		return service.selectMenuByMenuNo(menuNo);
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
		
		if (menuImage != null && !menuImage.isEmpty()) {
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
		else{
			menuRealImage = "defaultMenu.png";
			menuFakeImage = "defaultMenu.png";
		}
		
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
	@RequestMapping("menuModifyForm.udc")
	public String menuModifyForm(int cafeNo, HttpSession session, ModelMap map){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("licenseeMember")){
			return "redirect:/loginPage.udc";
		}
		map.put("cafeNo", cafeNo);
		return "/ParkTest/menuModifyForm.jsp";
	}
	
	/**
	 * 구현 완료
	 * @param cafeNo
	 * @param menuNOArray
	 * @param menuTypeArray
	 * @param menuNameArray
	 * @param menuImageArray
	 * @param req
	 * @param session
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	@RequestMapping("menuModify.udc")
	@Transactional
	public String menuModify(int cafeNo, int[] menuNOArray,
			String[] menuTypeArray, String[] menuNameArray,
			MultipartFile[] menuImageArray, HttpServletRequest req,
			HttpSession session) throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("licenseeMember")){
			//return "redirect:/loginPage.udc";
		}
		
		/*
		 * TODO: 전달된 Parameter menuTypeArray, menuNameArray는 비어 있으면 안 되므로 검증 필요.
		 */
		
		List<Menu> originalMenuList = service.selectMenuListByCafeNo(cafeNo);
		
		for (int i = 0; i < originalMenuList.size(); i++){
			boolean deleteFlag = true;
			if (menuNOArray != null){
				for (int j = 0; j < menuNOArray.length; j++){
					if (originalMenuList.get(i).getMenuNo() == menuNOArray[j]){
						Menu updateMenu = new Menu();
						updateMenu.setMenuNo(originalMenuList.get(i).getMenuNo());
						updateMenu.setMenuType(menuTypeArray[j]);
						updateMenu.setMenuName(menuNameArray[j]);
						if (menuImageArray[j] == null || menuImageArray[j].isEmpty()){
							updateMenu.setMenuRealImage(originalMenuList.get(i).getMenuRealImage());
							updateMenu.setMenuFakeImage(originalMenuList.get(i).getMenuFakeImage());
						}
						else{
							String imageName = menuImageArray[j].getOriginalFilename();// 업로드된 파일명
							
							// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
							// 최종 저장소 디렉토리 조회
							String dir = req.getServletContext().getRealPath("/images");
							long fake = System.currentTimeMillis();
							File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
							
							menuImageArray[j].transferTo(dest);
							
							updateMenu.setMenuRealImage(imageName);
							updateMenu.setMenuFakeImage(fake+imageName);
						}
						service.updateMenu(updateMenu);
						deleteFlag = false;
						break;
					}
				}
			}
			
			if (deleteFlag){
				String dir = req.getServletContext().getRealPath("/images");
				File dest = new File(dir, originalMenuList.get(i).getMenuFakeImage());
				dest.delete();
				service.deleteMenu(originalMenuList.get(i).getMenuNo());
			}
		}
		if (menuNOArray != null){
			for (int i = 0; i < menuNOArray.length; i++){
				if (menuNOArray[i] == 0){
					Menu newMenu = new Menu();
									
					newMenu.setMenuNo(service.selectNextMenuSequence());
					newMenu.setCafeNo(cafeNo);
					newMenu.setMenuType(menuTypeArray[i]);
					newMenu.setMenuName(menuNameArray[i]);
					
					if (menuImageArray[i] != null && !menuImageArray[i].isEmpty()){
						String imageName = menuImageArray[i].getOriginalFilename();// 업로드된 파일명
						
						// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
						// 최종 저장소 디렉토리 조회
						String dir = req.getServletContext().getRealPath("/images");
						long fake = System.currentTimeMillis();
						File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
						
						menuImageArray[i].transferTo(dest);
						
						newMenu.setMenuRealImage(imageName);;
						newMenu.setMenuFakeImage(fake+imageName);
					}
					else{
						newMenu.setMenuFakeImage("defaultMenu.png");
						newMenu.setMenuRealImage("defaultMenu.png");
					}
					
					service.insertMenu(newMenu);
				}
			}
		}
		
		return "/prBoard/prView.udc?cafeNo=" + cafeNo;
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