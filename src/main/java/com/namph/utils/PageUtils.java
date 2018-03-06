/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.utils;

import com.namph.model.Page;
import java.text.Normalizer;
import java.util.regex.Pattern;
import org.springframework.util.StringUtils;

/**
 *
 * @author namph
 */
public class PageUtils {

    public static String generateCode(String name) {
        String code = "";
        String temp = Normalizer.normalize(name, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
        name = pattern.matcher(temp).replaceAll("");
        if (!StringUtils.isEmpty(name)) {
            String[] arrName = name.split("\\s+");
            code = arrName[arrName.length - 1];
            for (int i = 0; i < arrName.length - 1; i++) {
                code += arrName[i].substring(0, 1);
            }
        }
        return removeAccent(code);
    }

    public static String generateCodeCus(String name) {
        String code = "";
        if (!StringUtils.isEmpty(name)) {
            code = name.substring(name.lastIndexOf(" ") + 1);
        }
        return removeAccent(code);
    }

    private static String removeAccent(String s) {
        String temp = Normalizer.normalize(s, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
         return pattern.matcher(temp).replaceAll("").toUpperCase().replaceAll(" ", "-").replaceAll("Đ", "D");
    }
    
    public static void main(String[] args) {
        System.out.println(removeAccent(generateCodeCus("công ty cổ phần thức nă chăn nuôi Đức")));
    }

    public static Page paging(int totalRows, int currPage, int pageSize) {
        Page pageInfo = new Page();

        int totalPages = 0;
        if (totalRows % pageSize == 0) {
            totalPages = (int) totalRows / pageSize;
        } else {
            totalPages = (int) totalRows / pageSize + 1;
        }
        if (totalRows == 0) {
            totalPages = 0;
        }
        pageInfo.setDirection(pageSize);
        pageInfo.setTotalPages(totalPages);
        pageInfo.setTotalRows(totalRows);
        pageInfo.setDestPage(currPage);
        return pageInfo;
    }

}
