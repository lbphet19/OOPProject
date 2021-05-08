package com.project.services;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.entities.Employee;

public interface EmployeeService {
	Page<Employee> findAll();
	Employee findById(int id);
	Employee save(Employee employee);
	Employee put(Employee employee);
	boolean delete(int id);
	Page<Employee> findAll(Pageable page);
	Page<Employee> findByEmployeeName(String empName,Pageable page);
}
