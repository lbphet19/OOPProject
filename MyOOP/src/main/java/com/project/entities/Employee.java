package com.project.entities;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Employee")
public class Employee {
	//ho ten, bo mon cong tac, sdt, email, phong lam viec
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "EmployeeId")
	private int employeeId;
	@Column(name = "EmployeeName")
	private String employeeName;
//	bo mon
	@Column(name = "EmpSubject")
	private String subject;
	@Column(name = "PhoneNumber") 
	private String phoneNumber;
	@Column(name = "Email")
	private String email;
	//datratien
		@Column(name="DaTra")
		private boolean datra;
//	phong lam viec
	@Column(name = "Office")
	private String office;
//	can bo coi thi
	@JsonIgnore
	@ManyToMany(cascade = CascadeType.MERGE, fetch = FetchType.EAGER)
	@JoinTable(
		name = "Employee_Class",
		joinColumns = {@JoinColumn(name = "EmployeeId")},
		inverseJoinColumns = {@JoinColumn(name = "ClassId")}
		)
	private Set<Class> classes = new HashSet<Class>();
//	giang vien
	@OneToMany(mappedBy = "employee")
	private List<Class> teachingClasses = new ArrayList<Class>();
	
	public Employee(int employeeId, String employeeName, String subject, String phoneNumber, String email,
			String office, Set<Class> classes) {
		super();
		this.employeeId = employeeId;
		this.employeeName = employeeName;
		this.subject = subject;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.office = office;
		this.classes = classes;
	}
	public Employee(int employeeId, String employeeName, String subject, String phoneNumber, String email,
			String office, Set<Class> classes, List<Class> teachingClasses) {
		super();
		this.employeeId = employeeId;
		this.employeeName = employeeName;
		this.subject = subject;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.office = office;
		this.classes = classes;
		this.teachingClasses = teachingClasses;
	}
	public Employee() {
		super();
	}
	public List<Class> getTeachingClasses() {
		return teachingClasses;
	}
	public void setTeachingClasses(List<Class> teachingClasses) {
		this.teachingClasses = teachingClasses;
	}
	public int getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}
	public String getEmployeeName() {
		return employeeName;
	}
	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	
	public boolean isDatra() {
		return datra;
	}
	public void setDatra(boolean datra) {
		this.datra = datra;
	}
	public void setPhoneNumber(String number) {
		this.phoneNumber = number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getOffice() {
		return office;
	}
	public void setOffice(String office) {
		this.office = office;
	}
	
	public Set<Class> getClasses() {
		return classes;
	}
	public void setClasses(Set<Class> classes) {
		this.classes = classes;
	}
//	lop coi thi
	public void addClass(Class _class) {
		this.getClasses().add(_class);
	}
	public void removeClass(Class _class) {
		this.getClasses().remove(_class);
	}
	
}
