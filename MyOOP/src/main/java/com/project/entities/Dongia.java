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

import javassist.bytecode.Descriptor.Iterator;
@Entity
@Table(name="DonGia")
public class Dongia {
	@Id
	@Column(name="DonGia1sv")
	private int giatien=0;
	public int getGiatien() {
		return giatien;
	}
	public void setGiatien(int gia)
	{
		this.giatien=gia;		
	}
	public Dongia(int gia)
	{
		super();
		this.giatien=gia;
	}
	public Dongia()
	{
		super();
		
	}
	
}
