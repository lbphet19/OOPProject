package com.project.controllers;

import java.util.Iterator;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MimeTypeUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.project.entities.Class;
import com.project.entities.Employee;
import com.project.services.ClassService;
import com.project.services.DongiaService;
import com.project.services.EmployeeService;
import com.project.services.MailSenderService;

@Controller
@RequestMapping(value = "/employee")
public class EmployeeController {
	@Autowired
	private DongiaService donService;
	@Autowired
	private EmployeeService empService;
	@Autowired
	private ClassService classService;
	@Autowired
	private MailSenderService mailSender;
	@RequestMapping(value = "/listEmp.htm/{pageNumber}",method = RequestMethod.GET)
	public String get(Model model, @RequestParam(required = false, name = "name") String name,
			@PathVariable(name = "pageNumber") int pageNumber) {
		Pageable pagerequest = PageRequest.of(pageNumber-1, 5,Direction.ASC,"employeeName");
		Page<Employee> page;
		if(name == null) {
			page = empService.findAll(pagerequest);
		}
		else {
			page=empService.findByEmployeeName(name, pagerequest);
		}
		List<Employee> listEmp = page.getContent(); 
		model.addAttribute("listEmp", listEmp);
//		trang hien tai
		model.addAttribute("currentPage", pageNumber);
//		tong so ket qua
		model.addAttribute("totalItems", page.getTotalElements());
//		tong so trang
		model.addAttribute("totalPages", page.getTotalPages());
		return "employee/employee";
	}
	@RequestMapping(value = "/findById/{id}", method = RequestMethod.GET, produces = MimeTypeUtils.APPLICATION_JSON_VALUE)
	public ResponseEntity<Employee> findById(@PathVariable("id") int id) {
		try {
			return new ResponseEntity<Employee>(empService.findById(id),HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			return new ResponseEntity<Employee>(HttpStatus.BAD_REQUEST);
		}
	}
	@RequestMapping(value = "/details/{id}")
	public String getEmployeeDetail(@PathVariable("id") String id, Model model) {
		Employee emp = empService.findById(Integer.parseInt(id));
		int giatien;
		giatien=donService.layDongia().get(0).getGiatien();
		int giaphaitra=0;
		Iterator<Class> i=emp.getTeachingClasses().iterator();
		while(i.hasNext())
		{
			giaphaitra+=giatien*(i.next().getClassAmount());
						
		}
		if(emp.isDatra())giaphaitra=0;
		model.addAttribute("tongtien",giaphaitra);
		
		model.addAttribute("giatien",giatien);
		model.addAttribute("employee", emp);
		return "employee/employeeDetails";
	}
// name subject phoneNumber email office
//	@PreAuthorize("hasAuthority('ADMIN')")
	@RequestMapping(value = "/save", method = RequestMethod.POST)
//	public String save(@RequestBody Employee emp) {
	public String save(HttpServletRequest req) {
		try {
			Employee emp = new Employee();
			emp.setEmployeeName(req.getParameter("name"));
			emp.setSubject(req.getParameter("subject"));
			emp.setPhoneNumber(req.getParameter("phoneNumber"));
			emp.setEmail(req.getParameter("email"));
			emp.setOffice(req.getParameter("office"));
			emp.setDatra(false);
			empService.save(emp);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/listEmp.htm/1";
	}
	@RequestMapping(value = "/put", method = RequestMethod.POST)
	public String put(HttpServletRequest req) {
		try {
			Employee emp = empService.findById(Integer.parseInt(req.getParameter("update_id")));
			emp.setEmployeeName(req.getParameter("update_name"));
			emp.setSubject(req.getParameter("update_subject"));
			emp.setPhoneNumber(req.getParameter("update_phoneNumber"));
			emp.setEmail(req.getParameter("update_email"));
			emp.setOffice(req.getParameter("update_office"));
			empService.put(emp);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/listEmp.htm/1";
	}
	@DeleteMapping(value = "/delete")
	public String delete(@RequestParam(name = "id") String id) {
		Employee employee;
		try {
//			employee = empService.findById(Integer.parseInt(id));
			empService.delete(Integer.parseInt(id));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/listEmp.htm/1";
	}
	@RequestMapping(value = "/updateLopDay")
	public String updateLopDay(@RequestParam(name = "classId") String classId,
			@RequestParam(name = "employeeId") String employeeId){
	
		System.out.println(employeeId);
		try {
			Class _class = classService.getById(classId);
//			System.out.println(_class.getCanBoCoiThi());
//			for(Employee c:_class.getCanBoCoiThi()) {
//				System.out.println(c.getEmployeeName());
//			}
			Employee emp = empService.findById(Integer.parseInt(employeeId));
			
				
			emp.getTeachingClasses().add(_class);
			_class.setEmployee(emp);
			empService.save(emp);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/details/"+employeeId;
	}
	@RequestMapping(value = "/tratien")
	public String tratien(@RequestParam(name="employeeId") String employeeId,
			@RequestParam(name = "tongThanhToan") long tongThanhToan)
	{
		try {
		Employee emp=empService.findById(Integer.parseInt(employeeId));
		mailSender.sendEmail(emp,tongThanhToan);
		emp.setDatra(true);
		empService.save(emp);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/details/"+employeeId;
	}
	@RequestMapping(value = "/updateLopTrongThi")
	public String updateLopTrongThi(@RequestParam(name = "classId") String classId,
			@RequestParam(name = "employeeId") String employeeId){
	
		System.out.println(employeeId);
		try {
			Class _class = classService.getById(classId);
//			System.out.println(_class.getCanBoCoiThi());
//			for(Employee c:_class.getCanBoCoiThi()) {
//				System.out.println(c.getEmployeeName());
//			}
			Employee emp = empService.findById(Integer.parseInt(employeeId));
			for(Class p:emp.getClasses())
			{
				if(p.getTestDay().equals(_class.getTestDay())) {
					String kipC1=p.getKip();
					String kipC2=_class.getKip();
					String kip1Num=kipC1.replaceAll("[^0-9]","");
					String kip2Num=kipC2.replaceAll("[^0-9]", "");
					if(Integer.parseInt(kip1Num)==Integer.parseInt(kip2Num))return "redirect:/error/error";
					
				}
			}
				
			emp.getClasses().add(_class);
			_class.getCanBoCoiThi().add(emp);
			empService.save(emp);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/details/"+employeeId;
	}

//	test
	@RequestMapping(value = "/{empId}/updateLopTrongThi/{classId}", method = RequestMethod.POST)
	public ResponseEntity<Employee> updateLopTrongThi_Test(@PathVariable("empId") String employeeId,
			@PathVariable("classId") String classId){
		Employee emp=null;
		System.out.println(employeeId);
		try {
			Class _class = classService.getById(classId);
			System.out.println(_class.getCanBoCoiThi());
			for(Employee c:_class.getCanBoCoiThi()) {
				System.out.println(c.getEmployeeName());
			}
			emp = empService.findById(Integer.parseInt(employeeId));
			emp.getClasses().add(_class);
			_class.getCanBoCoiThi().add(emp);
			empService.save(emp);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return ResponseEntity.ok().body(emp);
	}
	@RequestMapping(value = "/{employeeId}/removeLopTrongThi/{classId}", method = RequestMethod.POST)
	public String removeLopTrongThi(@PathVariable(name = "classId") String classId,
			@PathVariable(name = "employeeId") String employeeId){
	
//		System.out.println(employeeId);
		try {
			Class _class = classService.getById(classId);
			Employee emp = empService.findById(Integer.parseInt(employeeId));
			emp.getClasses().remove(_class);
			_class.getCanBoCoiThi().remove(emp);
			empService.save(emp);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "redirect:/employee/details/"+employeeId;
	}
//	@PreAuthorize("hasRole('ADMIN')")
//	@RequestMapping(value = "/thanhtoan.htm", method = RequestMethod.POST)
//	public String sendEmail(@RequestParam(name = "empId") int employeeId) throws MessagingException {
//		Employee emp = empService.findById(employeeId);
//		mailSender.sendEmail(emp);
//		return "redirect:/employee/details"+employeeId;
//	}
}
