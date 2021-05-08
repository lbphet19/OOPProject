package com.project.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.project.entities.Employee;
@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer>{
	List<Employee> findByEmployeeName(String name);

	  @Query(value = "SELECT e FROM Employee e WHERE e.employeeName like %?1%")
	  Page<Employee> findByEmployeeName(String empName, Pageable pageable);
}
