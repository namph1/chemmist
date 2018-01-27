/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.utils;

import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.springframework.web.servlet.view.document.AbstractExcelView;

/**
 *
 * @author namph
 */
public class ExcelBuilder extends AbstractExcelView {

    private String nameModel, sheetName, title;
    private String[] titlesHeader;
    private List<Map<Integer, Object>> lstData;

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSheetName() {
        return sheetName;
    }

    public void setSheetName(String sheetName) {
        this.sheetName = sheetName;
    }

    public String[] getTitlesHeader() {
        return titlesHeader;
    }

    public void setTitlesHeader(String[] titlesHeader) {
        this.titlesHeader = titlesHeader;
    }

    public List<Map<Integer, Object>> getLstData() {
        return lstData;
    }

    public void setLstData(List<Map<Integer, Object>> lstData) {
        this.lstData = lstData;
    }

    public String getNameModel() {
        return nameModel;
    }

    public void setNameModel(String nameModel) {
        this.nameModel = nameModel;
    }

    public ExcelBuilder(String nameModel) {
        this.nameModel = nameModel;
    }

    public ExcelBuilder(String nameModel,
            String sheetName, String title,String[] titlesHeader) {
        this.nameModel = nameModel;
        this.sheetName = sheetName;
        this.titlesHeader = titlesHeader;
         this.title = title;
    }

    public ExcelBuilder(String nameModel, String sheetName,
            String[] titlesHeader, String title,
            List<Map<Integer, Object>> lstData) {
        this.nameModel = nameModel;
        this.sheetName = sheetName;
        this.titlesHeader = titlesHeader;
        this.lstData = lstData;
        this.title = title;
    }

    public ExcelBuilder() {
    }

    private void createHeader(String[] titlesHeader,
            HSSFWorkbook workbook, HSSFSheet sheet) {
        // create style for header cells
        CellStyle style = workbook.createCellStyle();
        HSSFFont font = workbook.createFont();
        font.setFontName("Arial");
        style.setFillForegroundColor(HSSFColor.BLUE.index);
        style.setFillPattern(CellStyle.SOLID_FOREGROUND);
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
        font.setColor(HSSFColor.WHITE.index);
        style.setFont(font);

        HSSFRow header = sheet.createRow(2);

        for (int i = 0; i < titlesHeader.length; i++) {
            header.createCell(i).setCellValue(titlesHeader[i]);
            header.getCell(i).setCellStyle(style);
        }
    }

    @Override
    protected void buildExcelDocument(Map<String, Object> model,
            HSSFWorkbook workbook, HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {
        // get data model which is passed by the Spring container

        // create a new Excel sheet
        HSSFSheet sheet = workbook.createSheet(sheetName);
        sheet.setDefaultColumnWidth(30);

        HSSFRow rowTitle = sheet.createRow(0);
        rowTitle.createCell(2).setCellValue(title);
//        CellStyle style = workbook.createCellStyle();
//        HSSFFont font = workbook.createFont();
//        font.setFontName("Arial");
////        font.setFontHeight((short) (7.5 * 20));
//        style.setFont(font);
//        rowTitle.getCell(3).setCellStyle(style);

        // create header row
        createHeader(titlesHeader, workbook, sheet);

        // create data rows
        List<Map<Integer, Object>> listObjct = (List<Map<Integer, Object>>) model.get(nameModel);
        int rowCount = 3;

        for (Map<Integer, Object> aBook : listObjct) {
            HSSFRow aRow = sheet.createRow(rowCount++);
            int size = aBook.size();
            for (int i = 0; i < size; i++) {
                if (aBook.get(i + 1) instanceof String) {
                    aRow.createCell(i).setCellValue((String) aBook.get(i + 1));
                } else if (aBook.get(i + 1) instanceof Float) {
                    aRow.createCell(i).setCellValue((Float) aBook.get(i + 1));
                } else if (aBook.get(i + 1) instanceof Date) {
                    aRow.createCell(i).setCellValue((Date) aBook.get(i + 1));
                } else if (aBook.get(i + 1) instanceof Double) {
                    aRow.createCell(i).setCellValue((Double) aBook.get(i + 1));
                } else if (aBook.get(i + 1) instanceof Boolean) {
                    aRow.createCell(i).setCellValue((Boolean) aBook.get(i + 1));
                } else if (aBook.get(i + 1) instanceof Integer) {
                    aRow.createCell(i).setCellValue((Integer) aBook.get(i + 1));
                }
            }
        }
    }
}
