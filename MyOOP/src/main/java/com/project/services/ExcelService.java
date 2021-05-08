package com.project.services;

import java.io.ByteArrayInputStream;
import java.util.Set;

import org.springframework.web.multipart.MultipartFile;

import com.project.entities.Class;

public interface ExcelService {
	Set<Class> getClassesFromExcel(MultipartFile file);
	void save(Set<Class> set);
//	Set<Class> get
}
