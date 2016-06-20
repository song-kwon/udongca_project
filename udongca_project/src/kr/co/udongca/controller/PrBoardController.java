package kr.co.udongca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.udongca.service.impl.PrBoardServiceImpl;

@Controller
@RequestMapping("/prBoard")
public class PrBoardController {
	@Autowired
	private PrBoardServiceImpl service;
	
	
}
