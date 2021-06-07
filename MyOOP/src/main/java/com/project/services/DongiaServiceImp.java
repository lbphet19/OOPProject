package com.project.services;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.project.entities.Dongia;
import com.project.repositories.DongiaRepository;
@Service
public class DongiaServiceImp implements DongiaService {
	@Autowired
	private DongiaRepository DongiaRes;
	@Override
	public List<Dongia> layDongia() {
		return DongiaRes.Getdongia();
	}

}
