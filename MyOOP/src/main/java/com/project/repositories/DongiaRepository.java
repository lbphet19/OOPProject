package com.project.repositories;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

//import com.project.entities.Class;
import com.project.entities.Dongia;
@Repository
public interface DongiaRepository extends JpaRepository<Dongia, String>{
	@Query(value = "SELECT d FROM Dongia d")
	List <Dongia> Getdongia();
	
}
