package com.project.controllers;

import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;

import java.util.List;

import org.hibernate.annotations.Parent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.entities.Class;
import com.project.entities.Employee;
import com.project.repositories.EmployeeRepository;
import com.project.services.ClassService;
import com.project.services.EmployeeService;
@Controller
@RequestMapping(value = "/classes")
public class ClassController {
	@Autowired
	private ClassService classService;
	@Autowired
	private EmployeeService empService;
	@Autowired
	private EmployeeRepository empRepo;
	@RequestMapping(value = "/get/{pageNumber}")
	public String get(@PathVariable(name = "pageNumber") int pageNumber,
			@RequestParam(name = "keyword", required = false) String keyword,
			@RequestParam(name = "findBy", required = false) String findBy,
			@RequestParam(name = "sortBy", required = false) String sortBy,
			Model model) {
		Page<Class> page;
		Pageable pageable;
		if(sortBy == null) {
			pageable = PageRequest.of(pageNumber-1, 8, Direction.ASC, "moduleId");
		}
		else {
			pageable = PageRequest.of(pageNumber-1, 8, Direction.ASC, sortBy);
		}
		if(keyword == null || keyword.equals("")) {
			page = classService.get(pageable);
		}
		else {
			if(findBy==null || findBy.equals("")) {
				page=classService.findByModuleIdAndModuleNameAndClassId(keyword, pageable);
			}
			else if(findBy.equals("moduleId")) {
			page = classService.findByModuleId(keyword, pageable);
			}
			else if(findBy.equals("moduleName")){
				page = classService.findByModuleName(keyword, pageable);
			}
			else if(findBy.equals("classId")) {
				page = classService.findByClassId(keyword, pageable);
			}
			else {
				return "error/error";
			}
		}
		List<Class> listClass = page.getContent();
//		keyword cho search
		if(keyword != null) {
			model.addAttribute("keyword", keyword);
		}
		model.addAttribute("currentPage",pageNumber);
		model.addAttribute("listClass", listClass);
//		tong so ket qua
		model.addAttribute("totalItems", page.getTotalElements());
//		tong so trang
		model.addAttribute("totalPages", page.getTotalPages());
		return "/classroom/class";
	}
	@RequestMapping(value = "details/{id}")
	public String getClassDetails(@PathVariable("id") String classId, Model model) {
		try {
			Class _class = classService.getById(classId);
			System.out.println(classService.formatDateToExcel(_class.getTestDay()));
			model.addAttribute("myClass", _class);
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return "/classroom/class-details";
	}
	
	@RequestMapping(value = "/initCreate.htm")
	public String initCreate(Model model) {
		Class myClass = new Class();
		model.addAttribute("myClass", myClass);
		return "classroom/create";
	}
	@RequestMapping(value = "/create.htm")
	public String create(@ModelAttribute("myClass") Class myClass) {
		classService.save(myClass);
		return "redirect:/classes/get/1";
	}
	@RequestMapping(value = "/updateCanBoCoiThi", method = RequestMethod.POST)
	public String updateCanBoCoiThi(@RequestParam(name = "empId") String empId, 
			@RequestParam(name = "classId")String classId) {
		Class myClass = null;
		try {
			myClass = classService.getById(classId);
			Employee emp = empService.findById(Integer.parseInt(empId));
			int maxCanbo;
			if(myClass.getClassAmount()>50)maxCanbo=2;
			else maxCanbo=1;
			if(myClass.getCanBoCoiThi().size()>=maxCanbo)return  "redirect:/classes/details/"+classId;
			myClass.getCanBoCoiThi().add(emp);
			emp.getClasses().add(myClass);
//			System.out.println(emp);
			classService.save(myClass);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/classes/details/"+classId;
	}
	@RequestMapping(value = "/initUpdate.htm")
	public String initUpdate(Model model, @RequestParam(name = "classId") String classId) {
		Class myClass = classService.getById(classId);
		model.addAttribute("myClass", myClass);
		return "classroom/update";
	}
	@RequestMapping(value = "/update.htm", method = RequestMethod.POST)
	public String update(@ModelAttribute("myClass") Class myClass) {
		classService.updateClass(myClass);
		return "redirect:/classes/get/1";
	}
	@RequestMapping(value = "/delete")
	public String delete(@RequestParam(name = "deleteId") String id) {
		Class _class = classService.getById(id);
		List<Employee> listEmp = empRepo.findAll();
		for(Employee e:listEmp) {
			if(e.getClasses().contains(_class)) {
				e.getClasses().remove(_class);
			}
		}
		classService.deleteClass(id);
		return "redirect:/classes/get/1";
	}
	@RequestMapping(value = "/{classId}/removeCanBoCoiThi/{empId}", method = RequestMethod.POST)
	public String removeCanBoCoiThi(@PathVariable("empId") String empId,@PathVariable("classId")
	String classId) {
		Class myClass = null;
		try {
			myClass = classService.getById(classId);
			Employee emp = empService.findById(Integer.parseInt(empId));
			myClass.getCanBoCoiThi().remove(emp);
			emp.getClasses().remove(myClass);
			classService.save(myClass);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/classes/details/"+classId;
	}
}
