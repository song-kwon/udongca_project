package kr.co.udongca.controller;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import kr.co.udongca.service.impl.PrBoardServiceImpl;
import kr.co.udongca.vo.Menu;
import kr.co.udongca.vo.PRBoard;

@Controller
@RequestMapping("/prBoard/")
public class PrBoardController {
	@Autowired
	private PrBoardServiceImpl service;
	
	@RequestMapping("prView.udc")
	public void prView(){
		return;
	}
	
	@RequestMapping("prWrite.udc")
	@Transactional
	public String prWrite(@RequestParam Map map, MultipartFile[] cafeImage,
			String[] menuNameArray, String[] menuTypeArray,
			MultipartFile[] menuImageArray, HttpServletRequest req,
			ModelMap model)
					throws IllegalStateException, IOException{
		PRBoard prBoard = new PRBoard();
		int cafeNo = service.selectNextPRBoardSequence();
		String cafeRealImagesName="";
		String cafeFakeImagesName="";
		
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
		prBoard.setMemberId("qwerty"); // !
		
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
			menuAdd(cafeNo, menuNameArray[i], menuTypeArray[i], menuImageArray[i], req);
		}
		
		model.put("cafeNo", cafeNo);
		
		return "/ParkTest/prRead.jsp";
	}

	@RequestMapping("prModify.udc")
	public void prModify(PRBoard prBoard){
		return;
	}

	@RequestMapping("prDelete.udc")
	public void prDelete(){
		return;
	}
	
	@RequestMapping("isCoporateNumbDuplicated.udc")
	@ResponseBody
	public String isCoporateNumbDuplicated(String coporateNumb){
		return "" + (service.selectPRBoardByCoporateNumb(coporateNumb) != null);
	}
	
	@RequestMapping("moveToNewPr2Jsp.udc")
	public String moveToNewPr2Jsp(@RequestParam Map map, String[] cafeFeature1, ModelMap model){
		String cafeFeature = "";
		
		if (cafeFeature1 != null){
			for (int i = 0; i < cafeFeature1.length; i++){
				cafeFeature += cafeFeature1[i] + " ";
			}
		}
		
		if (map.get("cafeFeature2") != "테마 선택"){
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

	@RequestMapping("isFavoriteRegistered.udc")
	public void isFavoriteRegistered(){
		return;
	}

	@RequestMapping("favoriteRegister.udc")
	public void favoriteRegister(){
		return;
	}

	@RequestMapping("mapLocation.udc")
	public void mapLocation(){
		return;
	}

	@RequestMapping("menuList.udc")
	public void menuList(){
		return;
	}

	@RequestMapping("menuAdd.udc")
	@Transactional
	public void menuAdd(){
		return;
	}
	
	@Transactional
	private void menuAdd(int cafeNumber, String menuType, String menuName,
			MultipartFile menuImage, HttpServletRequest req)
					throws IllegalStateException, IOException{
		Menu menu = new Menu();
		String menuRealImage = null;
		String menuFakeImage = null;
		int menuNo = service.selectNextMenuSequence();
		System.out.println(menuNo);
		
		menu.setMenuNO(menuNo);
		menu.setCafeNumber(cafeNumber);
		menu.setMenuType(menuType);
		menu.setMenuName(menuName);
		
		if (menuImage != null) {
			String imageName = menuImage.getOriginalFilename();// 업로드된 파일명
			
			System.out.println(imageName);
			
			// 임시저장소 저장된 업로드된 파일을 최종 저장소로 이동
			// 최종 저장소 디렉토리 조회
			String dir = req.getServletContext().getRealPath("/images");
			System.out.println(dir);
			long fake = System.currentTimeMillis();
			File dest = new File(dir, fake+imageName);// '/' application 루트경로 - > 파일경로로 알려준다.

			menuImage.transferTo(dest);
			
			menuRealImage = imageName;
			menuFakeImage = fake+imageName;
		}
		
		menu.setMenuRealImage(menuRealImage);
		menu.setMenuFakeImage(menuFakeImage);
		
		service.insertMenu(menu);
		
		return;
	}

	@RequestMapping("menuModify.udc")
	public void menuModify(){
		return;
	}

	@RequestMapping("menuDelete.udc")
	public void menuDelete(){
		return;
	}
}