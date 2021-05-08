package com.project.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping(value = "/main")
public class MainController {
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	@RequestMapping("/class")
	public String toClass() {
		return "/classroom/class";
	}
}
