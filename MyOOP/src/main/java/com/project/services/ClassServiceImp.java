package com.project.services;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.project.entities.Class;
import com.project.repositories.ClassRepository;
@Service
public class ClassServiceImp implements ClassService {
	@Autowired
	private ClassRepository classRepo;
	@Override
	public List<Class> get() {
		// TODO Auto-generated method stub
		return classRepo.findAll();
	}
	@Override
	public String formatDateToExcel(Date date) {
		
        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yyyy");
        String strDate = formatter.format(date);
        return strDate;
	}
//	crud, getById
	@Override
	public Page<Class> get(Pageable pageable) {
		// TODO Auto-generated method stub
		return classRepo.findAll(pageable);
	}
	@Override
	public Class getById(String classId) {
		// TODO Auto-generated method stub
		return classRepo.findById(classId).get();
	}
	@Override
	public Page<Class> findByModuleName(String moduleName, Pageable pageable) {
		// TODO Auto-generated method stub
		return classRepo.findByModuleName(moduleName, pageable);
	}
	@Override
	public void updateClass(Class _class) {
		// TODO Auto-generated method stub
		classRepo.save(_class);
	}
	@Override
	public void deleteClass(String classId) {
		// TODO Auto-generated method stub
		Class myClass = getById(classId);
		classRepo.delete(myClass);
	}
	@Override
	public Class save(Class _class) {
		// TODO Auto-generated method stub
		return classRepo.save(_class);
	}
	@Override
	public Page<Class> findByModuleId(String moduleId, Pageable pageable) {
		// TODO Auto-generated method stub
		return classRepo.findByModuleId(moduleId, pageable);
	}
	@Override
	public Page<Class> findByModuleIdAndModuleName(String keyword, Pageable pageable) {
		// TODO Auto-generated method stub
		return classRepo.findByModuleIdAndModuleName(keyword, pageable);
	}
	@Override
	public Page<Class> findByClassId(String classId,Pageable pageable) {
		// TODO Auto-generated method stub
		return classRepo.findByClassId(classId, pageable);
	}
	@Override
	public Page<Class> findByModuleIdAndModuleNameAndClassId(String keyword, Pageable pageable) {
		// TODO Auto-generated method stub
		return classRepo.findByModuleIdAndModuleNameAndClassId(keyword, pageable);
	}
	
}
