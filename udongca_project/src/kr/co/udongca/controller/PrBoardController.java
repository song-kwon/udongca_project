package kr.co.udongca.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

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

import kr.co.udongca.service.PrBoardService;
import kr.co.udongca.vo.Code;
import kr.co.udongca.vo.Member;
import kr.co.udongca.vo.Menu;
import kr.co.udongca.vo.PRBoard;

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
	private PrBoardService service;
	
	/**
	 * 구현 완료
	 * @param cafeNo
	 * @param map
	 * @return
	 */
	@RequestMapping("prView.udc")
	public String prView(@RequestParam Map map, ModelMap model){
		PRBoard pr = service.selectPRBoardByNo(Integer.parseInt(((String)map.get("cafeNo"))));
		if (pr == null){
			model.put("error", "존재하지 않는 카페입니다");
			return "error.tiles";
		}
		else{
			model.put("prBoard", pr);
			model.put("initialPage", map.get("initialPage"));
			model.put("initialPage2", map.get("initialPage2"));
			return "prBoard/prBoard_view.tiles";
		}
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
		
		ArrayList<String> errorList = new ArrayList<String>();
		
		for(int i = 0; i < menuNameArray.length; i++){
			if (isStringEmpty(menuTypeArray[i]) || isStringEmpty(menuNameArray[i])){
				errorList.add("메뉴 종류 및 이름을 입력하세요");
				break;
			}
			else if(menuTypeArray[i].getBytes("UTF-8").length > 50){
				errorList.add("메뉴 이름이 너무 깁니다");
				break;
			}
		}
		
		if (errorList.size() == 0){
			PRBoard prBoard = new PRBoard();
			String cafeRealImagesName="";
			String cafeFakeImagesName="";
			int cafeNo = service.selectNextPRBoardSequence();
			
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
			
			if (!isMultipartFileArrayEmpty(cafeImage)) {
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
			
			return "redirect:/prBoard/prView.udc?cafeNo=" + cafeNo;
		}
		
		else{
			model.put("errorList", errorList);
			return "prBoard/prBoard_write_form2.tiles";
		}
	}
	
	@RequestMapping("prModifyForm.udc")
	public String prModifyForm(int cafeNo, ModelMap map, HttpSession session){
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(service.selectPRBoardByNo(cafeNo).getMemberId())){
			return "redirect:/loginPage.udc";
		}
		map.put("prBoard", service.selectPRBoardByNo(cafeNo));
		return "prBoard/prBoard_modifyForm.tiles";
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
	 * @throws UnsupportedEncodingException 
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	
	@RequestMapping("moveToModifyPr2Jsp.udc")
	public String moveToModifyPr2Jsp(@RequestParam Map map, String[] cafeFeature1,
			HttpSession session, ModelMap model) throws UnsupportedEncodingException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberId().equals(map.get("memberId"))){
			return "redirect:/loginPage.udc";
		}
		
		String cafeFeature = "";
		ArrayList<String> errorList = new ArrayList<String>();
		
		if (cafeFeature1 != null){
			for (int i = 0; i < cafeFeature1.length; i++){
				cafeFeature += cafeFeature1[i] + " ";
			}
		}
		
		if (!((String)map.get("cafeFeature2")).equals("테마 선택")){
			cafeFeature += map.get("cafeFeature2");
		}
		
		if(map.get("cafeName") == null || ((String)map.get("cafeName")).trim().equals("")){
			errorList.add("카페 이름을 입력하세요");
		}
		else if(((String)map.get("cafeName")).getBytes("UTF-8").length > 50){
			errorList.add("카페 이름이 너무 깁니다");
		}
		
		if(map.get("cafeIntro") == null || ((String)map.get("cafeIntro")).trim().equals("")){
			errorList.add("카페 소개를 입력하세요");
		}
		
		if(map.get("operationHour") == null || ((String)map.get("operationHour")).trim().equals("")){
			errorList.add("영업 시간을 입력하세요");
		}
		else if(((String)map.get("operationHour")).getBytes("UTF-8").length > 50){
			errorList.add("영업 시간이 너무 깁니다");
		}
		
		if(map.get("cafeTel") == null || ((String)map.get("cafeTel")).trim().equals("")){
			errorList.add("카페 연락처를 입력하세요");
		}
		else if(((String)map.get("cafeTel")).getBytes("UTF-8").length > 50){
			errorList.add("카페 연락처가 너무 깁니다");
		}
		
		if(map.get("cafeAddress") == null || ((String)map.get("cafeAddress")).trim().equals("")){
			errorList.add("카페 주소를 입력하세요");
		}
		else if(((String)map.get("cafeAddress")).getBytes("UTF-8").length > 50){
			errorList.add("카페 주소가 너무 깁니다");
		}
		
		if(map.get("managerName") == null || ((String)map.get("managerName")).trim().equals("")){
			errorList.add("영업자 성함을 입력하세요");
		}
		else if(((String)map.get("managerName")).getBytes("UTF-8").length > 50){
			errorList.add("영업자 성함이 너무 깁니다");
		}
		
		if(map.get("managerTel") == null || ((String)map.get("managerTel")).trim().equals("")){
			errorList.add("영업자 연락처를 입력하세요");
		}
		else if(((String)map.get("managerTel")).getBytes("UTF-8").length > 50){
			errorList.add("영업자 연락처가 너무 깁니다");
		}
		
		model.put("cafeNo", map.get("cafeNo"));
		model.put("cafeName", map.get("cafeName"));
		model.put("cafeIntro", map.get("cafeIntro"));
		model.put("cafeFeature", cafeFeature);
		model.put("operationHour", map.get("operationHour"));
		model.put("cafeTel", map.get("cafeTel"));
		model.put("cafeAddress", map.get("cafeAddress"));
		model.put("managerName", map.get("managerName"));
		model.put("managerTel", map.get("managerTel"));
		model.put("cafeRealImage", map.get("cafeRealImage"));
		model.put("cafeFakeImage", map.get("cafeFakeImage"));
		model.put("memberId", map.get("memberId"));
		
		if (errorList.size() > 0){
			model.put("errorList", errorList);
		}
		
		return "prBoard/prBoard_modifyForm" + ((errorList.size() == 0) ? "2" : "") + ".tiles";
	}
	
	@RequestMapping("prModify.udc")
	public String prModify(@RequestParam Map map, MultipartFile[] addCafeImage,
			String[] modifiedCafeFakeImage, String[] modifiedCafeRealImage,
			HttpServletRequest req, HttpSession session, ModelMap model)
					throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		String addRealImagesName="";
		String addFakeImagesName="";
		ArrayList<String> errorList = new ArrayList<String>();
		
		if (mem == null || !mem.getMemberId().equals(map.get("memberId"))){
			return "redirect:/loginPage.udc";
		}
		
		if (errorList.size() == 0){
			if (!isMultipartFileArrayEmpty(addCafeImage)) {
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
				if (!isStringArrayEmpty(modifiedCafeFakeImage)){
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
			
			String resultFakeImage = (!isStringArrayEmpty(modifiedCafeFakeImage) ? String.join(";", modifiedCafeFakeImage) + ";" : "") + ((!isStringEmpty(addFakeImagesName)) ? addFakeImagesName : (!isStringArrayEmpty(modifiedCafeFakeImage) ? "" : ";"));
			String resultRealImage = (!isStringArrayEmpty(modifiedCafeRealImage) ? String.join(";", modifiedCafeRealImage) + ";" : "") + ((!isStringEmpty(addRealImagesName)) ? addRealImagesName : (!isStringArrayEmpty(modifiedCafeRealImage) ? "" : ";"));
			
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
					(String)map.get("cafeFeature"),
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
			return "redirect:/prBoard/prView.udc?cafeNo=" + map.get("cafeNo");
		}
		else{
			model.put("errorList", errorList);
			model.put("prBoard", service.selectPRBoardByNo(Integer.parseInt(((String)map.get("cafeNo")))));
			return "prBoard/prBoard_modifyForm2.tiles";
		}
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
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("moveToNewPr2Jsp.udc")
	public String moveToNewPr2Jsp(@RequestParam Map map, String[] cafeFeature1,
			HttpSession session, ModelMap model) throws UnsupportedEncodingException{
		Member mem = (Member)session.getAttribute("login");
		if (mem == null || !mem.getMemberType().equals("licenseeMember")){
			return "redirect:/loginPage.udc";
		}
		
		String cafeFeature = "";
		ArrayList<String> errorList = new ArrayList<String>();
		
		if (cafeFeature1 != null){
			for (int i = 0; i < cafeFeature1.length; i++){
				cafeFeature += cafeFeature1[i] + " ";
			}
		}
		
		if (!((String)map.get("cafeFeature2")).equals("테마 선택")){
			cafeFeature += map.get("cafeFeature2");
		}
		
		if(map.get("cafeName") == null || ((String)map.get("cafeName")).trim().equals("")){
			errorList.add("카페 이름을 입력하세요");
		}
		else if(((String)map.get("cafeName")).getBytes("UTF-8").length > 50){
			errorList.add("카페 이름이 너무 깁니다");
		}
		
		if(map.get("cafeIntro") == null || ((String)map.get("cafeIntro")).trim().equals("")){
			errorList.add("카페 소개를 입력하세요");
		}
		
		if(map.get("operationHour") == null || ((String)map.get("operationHour")).trim().equals("")){
			errorList.add("영업 시간을 입력하세요");
		}
		else if(((String)map.get("operationHour")).getBytes("UTF-8").length > 50){
			errorList.add("영업 시간이 너무 깁니다");
		}
		
		if(map.get("cafeTel") == null || ((String)map.get("cafeTel")).trim().equals("")){
			errorList.add("카페 연락처를 입력하세요");
		}
		else if(((String)map.get("cafeTel")).getBytes("UTF-8").length > 50){
			errorList.add("카페 연락처가 너무 깁니다");
		}
		
		if(map.get("cafeAddress") == null || ((String)map.get("cafeAddress")).trim().equals("")){
			errorList.add("카페 주소를 입력하세요");
		}
		else if(((String)map.get("cafeAddress")).getBytes("UTF-8").length > 50){
			errorList.add("카페 주소가 너무 깁니다");
		}
		
		if(map.get("managerName") == null || ((String)map.get("managerName")).trim().equals("")){
			errorList.add("영업자 성함을 입력하세요");
		}
		else if(((String)map.get("managerName")).getBytes("UTF-8").length > 50){
			errorList.add("영업자 성함이 너무 깁니다");
		}
		
		if(map.get("managerTel") == null || ((String)map.get("managerTel")).trim().equals("")){
			errorList.add("영업자 연락처를 입력하세요");
		}
		else if(((String)map.get("managerTel")).getBytes("UTF-8").length > 50){
			errorList.add("영업자 연락처가 너무 깁니다");
		}
		
		if(map.get("coporateNumber") == null || ((String)map.get("coporateNumber")).trim().equals("") || !Pattern.matches("\\d{10}", ((String)map.get("coporateNumber")).trim())){
			errorList.add("형식에 맞는 사업자 등록 번호를 입력하세요");
		}
		else if(service.selectPRBoardByCoporateNumber((String)map.get("coporateNumber")) != null){
			errorList.add("중복된 사업자 등록 번호입니다");
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
		
		if (errorList.size() > 0){
			model.put("errorList", errorList);
		}
		
		return "prBoard/prBoard_write_form" + ((errorList.size() == 0) ? "2" : "") + ".tiles";
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
		
		menu.setMenuNo(service.selectNextMenuSequence());
		menu.setCafeNo(cafeNumber);
		menu.setMenuType(menuType);
		menu.setMenuName(menuName);
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
		return "prBoard/menu_modifyForm.tiles";
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
	public String menuModify(@RequestParam Map map, int[] menuNOArray,
			String[] menuTypeArray, String[] menuNameArray,
			MultipartFile[] menuImageArray, HttpServletRequest req,
			HttpSession session, ModelMap model)
					throws IllegalStateException, IOException{
		Member mem = (Member)session.getAttribute("login");
		ArrayList<String> errorList = new ArrayList<String>();
		if (mem == null || !mem.getMemberType().equals("licenseeMember")){
			return "redirect:/loginPage.udc";
		}
		
		for (int i = 0; i < menuNOArray.length; i++){
			if (isStringEmpty(menuTypeArray[i]) || isStringEmpty(menuNameArray[i])){
				errorList.add("메뉴 종류 및 이름을 입력하세요");
				break;
			}
			else if(menuTypeArray[i].getBytes("UTF-8").length > 50){
				errorList.add("메뉴 이름이 너무 깁니다");
				break;
			}
		}
		
		int cafeNo = Integer.parseInt(((String)map.get("cafeNo")));
		
		if (errorList.size() == 0){
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
						
						if (menuImageArray[i] != null && !menuImageArray[i].isEmpty()){
							String imageName = menuImageArray[i].getOriginalFilename();// 업로드된 파일명
							
							// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
							// 최종 저장소 디렉토리 조회
							String dir = req.getServletContext().getRealPath("/images");
							long fake = System.currentTimeMillis();
							File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.
							
							menuImageArray[i].transferTo(dest);
							
							newMenu.setMenuRealImage(imageName);
							newMenu.setMenuFakeImage(fake+imageName);
						}
						else{
							newMenu.setMenuFakeImage("defaultMenu.png");
							newMenu.setMenuRealImage("defaultMenu.png");
						}
						
						newMenu.setMenuNo(service.selectNextMenuSequence());
						newMenu.setCafeNo(cafeNo);
						newMenu.setMenuType(menuTypeArray[i]);
						newMenu.setMenuName(menuNameArray[i]);
						
						service.insertMenu(newMenu);
					}
				}
			}
			
			return "redirect:/prBoard/prView.udc?cafeNo=" + cafeNo;
		}
		else{
			model.put("errorList", errorList);
			model.put("cafeNo", cafeNo);
			return "prBoard/menu_modifyForm.tiles";
		}
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
	
	/**
	 * 
	 * @param str
	 * @return
	 */
	private boolean isStringEmpty(String str){
		return str == null || str.trim().equals("");
	}
	
	/**
	 * 
	 * @param strArray
	 * @return
	 */
	private boolean isStringArrayEmpty(String[] strArray){
		return strArray == null || strArray.length == 0 || strArray[0].equals("");
	}
	
	/**
	 * 
	 * @param multiPartFileArray
	 * @return
	 */
	private boolean isMultipartFileArrayEmpty(MultipartFile[] multiPartFileArray){
		return multiPartFileArray == null || multiPartFileArray.length == 0 || multiPartFileArray[0].isEmpty();
	}
}