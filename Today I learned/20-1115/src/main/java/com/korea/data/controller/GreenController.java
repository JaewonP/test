package com.korea.data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.korea.data.domain.GreenVO;
import com.korea.data.service.GreenService;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Controller
@AllArgsConstructor
public class GreenController {
	@Setter(onMethod_=@Autowired)
	GreenService service;
	
	@RequestMapping("green/list")
	public String list(Model model) {
		model.addAttribute("a", service.getServiceAll());
		return "/green/list";
	}
	
	@RequestMapping("green/updateForm") //매핑해주지않고 return문에 사용하면 error남! 일단 매핑하고 딴데에 return에쓰던 죽을끓이던 하기
	public String updateList(Model model) {
		
		return "/green/updateForm";
	}
	
	@GetMapping("green/get")
	public String listOne(Long gid) {
		System.out.println("get으로 잘 들어옴"+gid);
//		GreenVO a = service.getServiceOne(gid);  //입력된 gid값이 없으므로 갖고올 값도 없으므로 error가 난다
//		System.out.println(a);
		return "get";
	}
	
	@PostMapping("green/get")
	public String responseListOne(Model model, Long gid) {
		System.out.println("get post으로 잘 들어옴"+gid);
		GreenVO a = service.getServiceOne(gid);
		model.addAttribute("a", a);
		return "get";
	}
	
	@GetMapping("/green/update")
	public String requestUpdate(Model model) {
//		GreenVO b = service.getServiceOne(gid);
//		model.addAttribute("b", b);
		return "/green/update";
	}
	
	@PostMapping("green/update")
	public String responseUpdate(Model model, GreenVO green) { //updateForm에서 받은 정보가 green에 담김
		service.update(green);
		model.addAttribute("b", service.getServiceAll());
		return "/green/updateForm";
	}
	
	@GetMapping("/green/insert")
	public String requestInsert() {
		return "/green/insert";
	}
	
	@PostMapping("/green/insert")
	public String responseInsert(GreenVO green){
		System.out.println("insert post로 들어옴");
		service.insertService(green);
		System.out.println("insert정보가 db에저장됨 ");
		return "redirect:/green/list";
	}
	
	@GetMapping("/green/delete")
	public String requestDelete(GreenVO green ,Long gid) {
		System.out.println("get에 delete요청들어옴");
		service.deleteService(gid);
		service.getServiceAll();
		System.out.println("get에 delete요청나감");
		return "redirect:/green/list";
	}
	
	@PostMapping("/green/delete")
	public String responseDelete(Model model, Long gid) {
		System.out.println("post에 delete요청들어옴");
		model.addAttribute("d", service.getServiceAll());
		return "redirect:/green/list";
	}
	
	
}
