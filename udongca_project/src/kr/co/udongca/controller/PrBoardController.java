package kr.co.udongca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.impl.PrBoardServiceImpl;
import kr.co.udongca.vo.PRBoard;

@Controller
@RequestMapping("/prBoard")
public class PrBoardController {
	@Autowired
	private PrBoardServiceImpl service;
	
	public void prView(){
		return;
	}
	
	public void prWrite(){
		return;
	}
	
	public void prModify(){
		return;
	}
	
	public void prDelete(){
		return;
	}
	
	public void isFavoriteRegistered(){
		return;
	}
	
	public void favoriteRegister(){
		return;
	}
	
	public void mapLocation(){
		return;
	}
	
	public void menuList(){
		return;
	}
	
	public void menuAdd(){
		return;
	}
	
	public void menuModify(){
		return;
	}
	
	public void menuDelete(){
		return;
	}
}