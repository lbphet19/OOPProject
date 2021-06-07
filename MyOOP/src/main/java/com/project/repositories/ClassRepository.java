package com.project.repositories;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.project.entities.Class;
@Repository
public interface ClassRepository extends JpaRepository<Class, String> {
	@Query(value = "SELECT c FROM Class c WHERE c.moduleName like %?1%")
	Page<Class> findByModuleName(String moduleName, Pageable pageable);
	@Query(value = "SELECT c FROM Class c WHERE c.moduleId like %?1%")
	Page<Class> findByModuleId(String moduleId, Pageable pageable);
	@Query(value = "SELECT c FROM Class c WHERE c.moduleId like %?1% or c.moduleName like %?1%")
	Page<Class> findByModuleIdAndModuleName(String keyword,Pageable pageable);
	@Query(value = "SELECT c FROM Class c WHERE c.moduleId like %?1% or c.moduleName like %?1%"
			+ "or c.classId like %?1%")
	Page<Class> findByModuleIdAndModuleNameAndClassId(String keyword,Pageable pageable);
	@Query(value = "SELECT c FROM Class c WHERE c.classId like %?1%")
	Page<Class> findByClassId(String classId,Pageable pageable);
}
  