package com.project.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.stereotype.Service;

import com.project.entities.Employee;
import com.project.repositories.EmployeeRepository;
@Service
public class EmployeeServiceImp implements EmployeeService {
	@Autowired
	private EmployeeRepository employeeRepo;

	@Override
	public Page<Employee> findAll(Pageable page) {
		// TODO Auto-generated method stub
//		Pageable page = PageRequest.of(0, 2,Direction.ASC, "phoneNumber");
		return employeeRepo.findAll(page);
	}

	@Override
	public Employee findById(int id) {
		// TODO Auto-generated method stub
		return employeeRepo.findById(id).get();
	}
	public Page<Employee> findByEmployeeName(String empName,Pageable page){
		return employeeRepo.findByEmployeeName(empName, page);
	}

	@Override
	public Employee save(Employee employee) {
		// TODO Auto-generated method stub
		return employeeRepo.save(employee);
	}

	@Override
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		Employee emp = findById(id);
		try {
		employeeRepo.delete(emp);
		return true;
		}catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		}
		return false;
	}

	@Override
	public Employee put(Employee employee) {
		// TODO Auto-generated method stub
		return employeeRepo.save(employee);
	}

	@Override
	public Page<Employee> findAll() {
		// TODO Auto-generated method stub
		return null;
	}
	
}
