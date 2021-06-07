package com.project.services;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.project.entities.Employee;

@Service
public class MailSenderService {
	@Autowired
	private JavaMailSender javaMailSender;
	public void sendEmail(Employee emp,long tongThanhToan) throws MessagingException {
		MimeMessage message = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message,true);
		helper.setTo(emp.getEmail());
		helper.setSubject("hello wordl!)");
		helper.setText("<h1>Thanh toán tiền của giảng viên "+emp.getEmployeeName() + "</h1>"+
		"<h2>Tổng số tiền: "+tongThanhToan+"VND</h2>",true);
		javaMailSender.send(message);
	}
}
