package com.project.helper;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.http.HttpResponse;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import com.project.entities.Class;

public class ExcelHelper {
	  Workbook workbook = new XSSFWorkbook();
	  public static String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
	  static String[] HEADERS = { "Mã lớp", "Mã HP", "Tên HP", "Ghi chú","Nhóm","Đợt mở","Tuần","Thứ","Ngày thi","Kíp","SLĐK","Phòng thi"};
	  static String SHEET = "Classes";
	  public boolean hasExcelFormat(MultipartFile file) {
		  if(!TYPE.equals(file.getContentType())) {
			  return false;
		  }
		  return true;
	  }
	  public String formatDoubleToInt(String val) {
		  String[] number = val.split("[.]");
		  if(number.length > 1 && number[1].equalsIgnoreCase("0")) {
			  return number[0];
		  }
		  return val;
	  }
	  public String DateToString(Date date) {
		  DateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
		  return dateFormat.format(date);
	  }
	  public String toDateFormat(String s) {
		  SimpleDateFormat simpleDateFormat = new SimpleDateFormat("dd.MM.yyyy");
		  Date actualDate = new Date();
		  try {
			actualDate = simpleDateFormat.parse(s);
			simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  return simpleDateFormat.format(actualDate);
	  }
//	  lay excel ve entity
	  public Set<Class> excelToClass(InputStream is) throws IOException{
		  Set<Class> classes = new HashSet<Class>();
//		  Workbook workbook = new XSSFWorkbook();
		  try {
			Workbook workbook = new XSSFWorkbook(is);
//			Sheet sheet = workbook.getSheet(SHEET);
			Sheet sheet = workbook.getSheetAt(0);
			Iterator<Row> rows = sheet.iterator();
			int x = 0;
			int currentNum = 0;
//			moi row la 1 entity
//			trung lap thi loai bo ngay
			while(rows.hasNext()) {
				Class _class = new Class();
				Row currentRow = rows.next();
				if(currentNum == 0) {
					currentNum++;
					continue;
				}
				Iterator<Cell> cells = currentRow.cellIterator();
				int cellIndex = 0;
				while(cells.hasNext()) {
				Cell currentCell = cells.next();
				switch (cellIndex) {
				case 0:
					_class.setClassId(formatDoubleToInt(String.valueOf(currentCell.getNumericCellValue())));
					break;
				case 1:
					_class.setModuleId(currentCell.getStringCellValue());
					break;
				case 2:
					_class.setModuleName(currentCell.getStringCellValue());
					break;
				case 3:
					_class.setDescriptions(currentCell.getStringCellValue());
					break;
				case 4:
					_class.setClassGroup(currentCell.getStringCellValue());
					break;
				case 5:	
					_class.setOpenTime(currentCell.getStringCellValue());
					break;
				case 6:
					_class.setWeek(currentCell.getStringCellValue());
					break;
				case 7:
					_class.setDayOfWeek(currentCell.getStringCellValue());
					break;
				case 8:
					_class.setTestDay(toDateFormat(currentCell.getStringCellValue()));
					break;
				case 9:
					_class.setKip(currentCell.getStringCellValue());
					break;
				case 10:
					_class.setClassAmount((int)currentCell.getNumericCellValue());
					break;
				case 11:
					_class.setTestRoom(currentCell.getStringCellValue());
					break;
				default:
					break;
				}
				cellIndex++;
				}
//				System.out.println(count);
//				System.out.println(_class);
//			System.out.println(x);
			classes.add(_class);
			}
			workbook.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		  return classes;
	  }
//	  tu database dua ve excel
	  public void classsesToExcel(List<Class> classes) {
		  try {
			  Sheet sheet = workbook.createSheet(SHEET);
//			  tieu de
			  Row headerRow = sheet.createRow(0);
			  for(int i = 0; i < HEADERS.length;i++) {
				  Cell cell = headerRow.createCell(i);
				  cell.setCellValue(HEADERS[i]);
			  }
			  int rowIndex = 1;
//			  create cac hang
			  for(Class c:classes) {
				  Row row = sheet.createRow(rowIndex);
				  row.createCell(0).setCellValue(c.getClassId());
				  row.createCell(1).setCellValue(c.getModuleId());
				  row.createCell(2).setCellValue(c.getModuleName());
				  row.createCell(3).setCellValue(c.getDescriptions());
				  row.createCell(4).setCellValue(c.getClassGroup()); 
				  row.createCell(5).setCellValue(c.getOpenTime());
				  row.createCell(6).setCellValue(c.getWeek());
				  row.createCell(7).setCellValue(c.getDayOfWeek());
				  row.createCell(8).setCellValue(c.getTestDay());
				  row.createCell(9).setCellValue(c.getKip());
				  row.createCell(10).setCellValue(c.getClassAmount());
				  row.createCell(11).setCellValue(c.getTestRoom());
				  rowIndex++;
			  }
		} catch (Exception e) {
			// TODO: handle exception
			throw new RuntimeException("failed to import to data excel file " + e.getMessage());
		}
	  }
	  public void export(HttpServletResponse res, List<Class> classes) throws IOException {
		  classsesToExcel(classes);
		  ServletOutputStream out = res.getOutputStream();
		  workbook.write(out);
		  workbook.close();
		  out.close();
	  }
}
