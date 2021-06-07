package com.project.controllers;

import java.io.IOException;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.project.entities.Class;
import com.project.helper.ExcelHelper;
import com.project.services.ClassService;
import com.project.services.ExcelService;

@Controller
@RequestMapping(value = "/excel")
public class ExcelController {
	@Autowired
	private ExcelService exService;
	@Autowired
	private ClassService classService;
	@PostMapping(value = "/upload",headers=("content-type=multipart/*"))
	public String uploadExcelFile(@RequestParam("excelFile")MultipartFile file) {
		System.out.println("success");
		ExcelHelper helper = new ExcelHelper();
		if(helper.hasExcelFormat(file)) {
			try {
				System.out.println("success");
				Set<Class> classes = exService.getClassesFromExcel(file);
				List<Class> oldList = classService.get();
				classes.removeAll(oldList);
				for(Class c : classes) {
					System.out.println(c);
					classService.save(c);
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				return "error:error";
			}
		}
		return "redirect:/classes/get/1";
	}
	@GetMapping(value = "/download")
	public void downloadExcel(HttpServletResponse res) throws IOException{
		res.setContentType("application/octet-stream");
		String headerKey = "Content-Disposition";
		String headerValue = "attachment; filename=lich-thi.xlsx";
		res.setHeader(headerKey, headerValue);
		List<Class> classes = classService.get();
		ExcelHelper helper = new ExcelHelper();
		helper.export(res, classes);
//		return "redirect:index";
	}
	
}
