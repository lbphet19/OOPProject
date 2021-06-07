package com.project.services;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.project.entities.Class;
import com.project.entities.Dongia;

public interface DongiaService {
	List<Dongia> layDongia();

}
