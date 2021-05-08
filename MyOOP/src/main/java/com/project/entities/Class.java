package com.project.entities;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "Class")
public class Class {
//	ma lop
	@Id
	@Column(name = "ClassId")
	private String classId;
//	ma hoc phan
	@Column(name = "ModuleId")
	private String moduleId;
//	ten hoc phan
	@Column(name = "ModuleName")
	private String moduleName;
//	mo ta, ghi chu
	@Column(name = "Descriptions")
	private String descriptions;
//	nhóm
	@Column(name = "ClassGroup")
	private String classGroup;
//	đợt mở
	@Column(name = "OpenTime")
	private String openTime;
//	tuần
	@Column(name = "ClassWeek")
	private String week;
//	thứ
	@Column(name = "ClassDayOfWeek")
	private String dayOfWeek;
//	ngày thi
	@Column(name = "TestDay")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date testDay;
//	kíp thi
	@Column(name = "Kip")
	private String kip;
//	số lượng
	@Column(name = "ClassAmount")
	private int classAmount;
//	phòng thi
	@Column(name = "TestRoom")
	private String testRoom;
//	can bo coi thi
	@JsonIgnore
	@ManyToMany(mappedBy = "classes", cascade = CascadeType.MERGE)
	private Set<Employee> canBoCoiThi = new HashSet<Employee>();
//	giang vien
	@ManyToOne 
	@JoinColumn(name = "EmployeeId")
	private Employee employee;
	
	@Override
	public String toString() {
		return "Class [classId=" + classId + ", moduleId=" + moduleId + ", moduleName=" + moduleName + ", descriptions="
				+ descriptions + ", classGroup=" + classGroup + ", openTime=" + openTime + ", week=" + week
				+ ", dayOfWeek=" + dayOfWeek + ", testDay=" + testDay + ", kip=" + kip + ", classAmount=" + classAmount
				+ ", testRoom=" + testRoom + "]";
	}
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
	public String getModuleId() {
		return moduleId;
	}
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public String getDescriptions() {
		return descriptions;
	}
	public void setDescriptions(String descriptions) {
		this.descriptions = descriptions;
	}
	public String getClassGroup() {
		return classGroup;
	}
	public void setClassGroup(String classGroup) {
		this.classGroup = classGroup;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getDayOfWeek() {
		return dayOfWeek;
	}
	public void setDayOfWeek(String dayOfWeek) {
		this.dayOfWeek = dayOfWeek;
	}
	public Date getTestDay() {
		return testDay;
	}
	public void setTestDay(Date testDay) {
		this.testDay = testDay;
	}
	public void setTestDay(String testDay) throws ParseException {
		SimpleDateFormat formatter1=new SimpleDateFormat("yyyy-MM-dd");
		this.testDay = formatter1.parse(testDay);
	}
	public String getKip() {
		return kip;
	}
	public void setKip(String kip) {
		this.kip = kip;
	}
	public int getClassAmount() {
		return classAmount;
	}
	public void setClassAmount(int classAmount) {
		this.classAmount = classAmount;
	}
	public String getTestRoom() {
		return testRoom;
	}
	public void setTestRoom(String testRoom) {
		this.testRoom = testRoom;
	}
	
	public Set<Employee> getCanBoCoiThi() {
		return canBoCoiThi;
	}
	public void setCanBoCoiThi(Set<Employee> canBoCoiThi) {
		this.canBoCoiThi = canBoCoiThi;
	}
	public Employee getEmployee() { 
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	public void addCanBoCoiThi(Employee employee) {
		this.getCanBoCoiThi().add(employee);
	}
	public String getOpenTime() {
		return openTime;
	}
	public void setOpenTime(String openTime) {
		this.openTime = openTime;
	}

	public Class(String classId, String moduleId, String moduleName, String descriptions, String classGroup,
			String openTime, String week, String dayOfWeek, Date testDay, String kip, int classAmount, String testRoom,
			Set<Employee> canBoCoiThi, Employee employee) {
		super();
		this.classId = classId;
		this.moduleId = moduleId;
		this.moduleName = moduleName;
		this.descriptions = descriptions;
		this.classGroup = classGroup;
		this.openTime = openTime;
		this.week = week;
		this.dayOfWeek = dayOfWeek;
		this.testDay = testDay;
		this.kip = kip;
		this.classAmount = classAmount;
		this.testRoom = testRoom;
		this.canBoCoiThi = canBoCoiThi;
		this.employee = employee;
	}
	public Class() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((classId == null) ? 0 : classId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Class other = (Class) obj;
		if (classId == null) {
			if (other.classId != null)
				return false;
		} else if (!classId.equals(other.classId))
			return false;
		return true;
	}
	
	
}
