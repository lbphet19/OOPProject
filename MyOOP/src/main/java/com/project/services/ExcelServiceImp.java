package com.project.services;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.project.entities.Class;
import com.project.helper.ExcelHelper;
import com.project.repositories.ClassRepository;
@Service
public class ExcelServiceImp implements ExcelService{
	@Autowired
	private ClassRepository classRepo;
	@Override
	public Set<Class> getClassesFromExcel(MultipartFile file) {
		// TODO Auto-generated method stub
		ExcelHelper helper = new ExcelHelper();
		Set<Class> classes = null;
		try {
			classes = helper.excelToClass(file.getInputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return classes;
	}
	public void save(Set<Class> set) {
		this.classRepo.saveAll(set);
	}
}
