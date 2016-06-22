package kr.co.udongca.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import kr.co.udongca.service.impl.PrBoardServiceImpl;
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
	public void prWrite(PRBoard prBoard){
		prBoard.setCafeNo(service.selectNextPRBoardSequence());
		prBoard.setMemberId("qwerty");
		System.out.println(prBoard);
		service.insertPRBoard(prBoard);
		return;
	}

	@RequestMapping("prModify.udc")
	public void prModify(@RequestParam PRBoard prBoard){
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
	public void menuAdd(){
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