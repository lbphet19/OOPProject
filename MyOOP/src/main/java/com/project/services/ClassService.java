package com.project.services;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.entities.Class;

public interface ClassService {
//	crud
	List<Class> get();
	Page<Class> get(Pageable pageable);
	Class getById(String classId);
	Class save(Class _class);
	void updateClass(Class _class);
	void deleteClass(String classId);
	String formatDateToExcel(Date date);
//	search by id and name
	Page<Class> findByModuleIdAndModuleNameAndClassId(String keyword,Pageable pageable);
	Page<Class> findByModuleName(String moduleName,Pageable pageable);
	Page<Class> findByModuleId(String moduleId, Pageable pageable);
	Page<Class> findByModuleIdAndModuleName(String keyword,Pageable pageable);
	Page<Class> findByClassId(String classId,Pageable pageable);
}
