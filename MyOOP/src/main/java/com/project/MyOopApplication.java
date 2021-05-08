package com.project;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


import com.project.entities.Class;
import com.project.helper.ExcelHelper;
import com.project.services.ClassService;
import com.project.services.ClassServiceImp;


@SpringBootApplication
public class MyOopApplication {

	public static void main(String[] args) {
//		Set<Class> set = new HashSet<Class>();
//		Class c1 = new Class();
//		c1.setClassId("100001");
//		set.add(c1);
//		Class c2 = new Class();
//		c2.setClassId("100005");
//		set.add(c2);
//		Class c3 = new Class();
//		c3.setClassId("123456");
//		set.add(c3);
//		Class c4 = new Class();
//		c4.setClassId("145677");
//		set.add(c4);
//		ClassService ser = new ClassServiceImp();
//		List<Class> list = new ArrayList<Class>();
//		list.add(new Class("123456", "mi1111", null, null, null, null, null, null, null, null, 0, null, null, null));
//		
//		for(Class c:list) {
//			System.out.println(c);
//		}
//		set.removeAll(list);
//		System.out.println("set");
//		for(Class c:set) {
//			System.out.println(c);
//		}
//		System.out.println(helper.DateToString(date));
		SpringApplication.run(MyOopApplication.class, args);
	}
	
}