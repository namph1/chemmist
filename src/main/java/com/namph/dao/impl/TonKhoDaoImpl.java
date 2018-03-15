/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao.impl;

import com.namph.dao.TonKhoDao;
import com.namph.model.CongNo;
import com.namph.model.PagingModel;
import com.namph.model.TonKho;
import com.namph.utils.Utils;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.transform.Transformers;
import org.hibernate.type.StandardBasicTypes;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author namph
 */
@Transactional
public class TonKhoDaoImpl extends PagingModel implements TonKhoDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public List<TonKho> getListTonKho(String from, String to) {
        StringBuilder sb = new StringBuilder(" SELECT ");
        sb.append(" SUM(TEMP_XUAT_NHAP.\"COUNT\") AS \"SL_TON\", ");
        sb.append(" TEMP_XUAT_NHAP.\"PRODUCT_ID\", PRO.\"NAME\" AS \"TEN_SP\", UNI.\"NAME\" AS \"DONVI\", PRO.\"CODE\" AS \"MA_SP\",PRO.\"WEIGHT\" AS \"KHOILUONG\", ");
        sb.append(" COALESCE((SELECT SUM(\"COUNT\") FROM tbl_import_detail WHERE \"PRODUCT_ID\" = TEMP_XUAT_NHAP.\"PRODUCT_ID\"),0) AS \"SL_NHAP\", ");
        sb.append(" COALESCE((SELECT SUM(\"COUNT\") FROM tbl_export_detail WHERE \"PRODUCT_ID\" = TEMP_XUAT_NHAP.\"PRODUCT_ID\"),0) AS \"SL_XUAT\" ");
        sb.append(" FROM ");
        sb.append(" ( ");
        sb.append(" SELECT impd.\"COUNT\", impd.\"PRODUCT_ID\" ");
        sb.append(" FROM tbl_import_detail impd ");
        sb.append(" UNION ALL ");
        sb.append(" SELECT -(expd.\"COUNT\") \"COUNT\", expd.\"PRODUCT_ID\" ");
        sb.append(" FROM tbl_export_detail expd ");
        sb.append(" ) AS TEMP_XUAT_NHAP ");
        sb.append(" LEFT JOIN tbl_product PRO ");
        sb.append(" ON PRO.\"ID\" = TEMP_XUAT_NHAP.\"PRODUCT_ID\" ");
        sb.append(" JOIN tbl_unit UNI ON UNI.\"ID\" = PRO.\"UNIT_ID\" ");
        sb.append(" GROUP BY TEMP_XUAT_NHAP.\"PRODUCT_ID\",PRO.\"NAME\",UNI.\"NAME\",PRO.\"CODE\",PRO.\"WEIGHT\" ");
        
        
        List<TonKho> lstResult = new ArrayList<TonKho>();
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery(sb.toString())
                .addScalar("PRODUCT_ID", StandardBasicTypes.INTEGER)
                .addScalar("SL_TON", StandardBasicTypes.INTEGER)
                .addScalar("TEN_SP", StandardBasicTypes.STRING)
                .addScalar("MA_SP", StandardBasicTypes.STRING)
                .addScalar("DONVI", StandardBasicTypes.STRING)
                .addScalar("KHOILUONG", StandardBasicTypes.FLOAT)
                .addScalar("SL_NHAP", StandardBasicTypes.FLOAT)
                .addScalar("SL_XUAT", StandardBasicTypes.FLOAT);
//                .addScalar("tondauky", StandardBasicTypes.FLOAT)
//                .setParameter("from", Utils.stringDDMMYYY2Date(from))
//                .setParameter("to", Utils.stringDDMMYYY2Date(to));
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                TonKho obj = new TonKho();
                Map map = (Map) result.get(i);
                obj.setCount((Integer) map.get("SL_TON"));
                obj.setProductId((Integer) map.get("PRODUCT_ID"));
                obj.setProductCode(map.get("MA_SP").toString());
                obj.setProductName(map.get("TEN_SP").toString());
                obj.setUnitName(map.get("DONVI").toString());
                obj.setWeight(((Float) map.get("KHOILUONG")));
                obj.setSanluong((Float) map.get("SL_NHAP"));
                obj.setSanluongXuat((Float) map.get("SL_XUAT"));
                obj.setTondauky((Float) map.get("SL_XUAT"));
                lstResult.add(obj);
            }
        }
        return lstResult;
//        List<TonKho> lstResult = new ArrayList<TonKho>();
//        Session session = this.sessionFactory.getCurrentSession();
//        Query query = session.createSQLQuery("CALL get_tonkho_bymonth(:from, :to)")
//                .addScalar("productId", StandardBasicTypes.INTEGER)
//                .addScalar("count", StandardBasicTypes.INTEGER)
//                .addScalar("productName", StandardBasicTypes.STRING)
//                .addScalar("productCode", StandardBasicTypes.STRING)
//                .addScalar("unitName", StandardBasicTypes.STRING)
//                .addScalar("weight", StandardBasicTypes.FLOAT)
//                .addScalar("sanluong", StandardBasicTypes.FLOAT)
//                .addScalar("sanluongxuat", StandardBasicTypes.FLOAT)
//                .addScalar("tondauky", StandardBasicTypes.FLOAT)
//                .setParameter("from", Utils.stringDDMMYYY2Date(from))
//                .setParameter("to", Utils.stringDDMMYYY2Date(to));
//        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
//        if (!result.isEmpty()) {
//            for (int i = 0; i < result.size(); i++) {
//                TonKho obj = new TonKho();
//                Map map = (Map) result.get(i);
//                obj.setCount((Integer) map.get("count"));
//                obj.setProductId((Integer) map.get("productId"));
//                obj.setProductCode(map.get("productCode").toString());
//                obj.setProductName(map.get("productName").toString());
//                obj.setUnitName(map.get("unitName").toString());
//                obj.setWeight(((Float) map.get("weight")));
//                obj.setSanluong((Float) map.get("sanluong"));
//                obj.setSanluongXuat((Float) map.get("sanluongxuat"));
//                obj.setTondauky((Float) map.get("tondauky"));
//                lstResult.add(obj);
//            }
//        }
//        return lstResult;
    }

    @Override
    public List<CongNo> getListCongNo(Integer month, Integer year, String cusCode, Integer type) {
        List<CongNo> lstResult = new ArrayList<CongNo>();
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery("CALL get_cong_no_by_mmyyyy(:month, :year,:cus_code,:type)")
                .addScalar("id", StandardBasicTypes.INTEGER)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("address", StandardBasicTypes.STRING)
                .addScalar("total", StandardBasicTypes.INTEGER)
                .addScalar("level", StandardBasicTypes.INTEGER)
                .addScalar("type", StandardBasicTypes.INTEGER)
                .addScalar("dauky", StandardBasicTypes.INTEGER)
                .addScalar("phatsinhco", StandardBasicTypes.INTEGER)
                .setParameter("month", month)
                .setParameter("year", year)
                .setParameter("cus_code", cusCode)
                .setParameter("type", type);
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                CongNo obj = new CongNo();
                Map map = (Map) result.get(i);
                obj.setCustomerId((Integer) map.get("id"));
                obj.setCustomerCode((String) map.get("code") + (Integer) map.get("level"));
                obj.setCustomerName((String) map.get("name"));
                obj.setAddress((String) map.get("address"));
                obj.setTotal((Integer) map.get("total"));
                obj.setType((Integer) map.get("type"));
                obj.setSodudauky((Integer) map.get("dauky"));
                obj.setPhatsinhco((Integer) map.get("phatsinhco"));
                lstResult.add(obj);
            }
        }
        return lstResult;
    }

    @Override
    public List<CongNo> getDetailCongNo(Integer month, Integer year, Integer cusId, Integer type) {
        List<CongNo> lstResult = new ArrayList<CongNo>();
        Session session = this.sessionFactory.getCurrentSession();
        String sql = "";
        switch (type) {
            case 1:
                sql = "CALL get_detail_by_emp(:month, :year,:cus_id)";
                break;
            case 0:
                sql = "CALL get_detail_by_cus(:month, :year,:cus_id)";
                break;
            default:
                break;
        }

        Query query = session.createSQLQuery(sql)
                .addScalar("CUSTOMER_ID", StandardBasicTypes.INTEGER)
                .addScalar("types", StandardBasicTypes.STRING)
                .addScalar("totals", StandardBasicTypes.INTEGER)
                .addScalar("CREATED_DATE", StandardBasicTypes.DATE)
                .setParameter("month", month)
                .setParameter("year", year)
                .setParameter("cus_id", cusId);
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                CongNo obj = new CongNo();
                Map map = (Map) result.get(i);
                obj.setCustomerId((Integer) map.get("CUSTOMER_ID"));
                obj.setTypes((String) map.get("types"));
                obj.setCreateDate((Date) map.get("CREATED_DATE"));
                obj.setTotal((Integer) map.get("totals"));
                lstResult.add(obj);
            }
        }
        return lstResult;
    }

    @Override
    public List<CongNo> getSanLuongOfSanPham(String from, String to, String code) {
        List<CongNo> lstResult = new ArrayList<CongNo>();
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery("CALL get_sanluong_sanpham(:from, :to,:code)")
                .addScalar("id", StandardBasicTypes.INTEGER)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("unit", StandardBasicTypes.STRING)
                .addScalar("total", StandardBasicTypes.FLOAT)
                .addScalar("count", StandardBasicTypes.INTEGER)
                .setParameter("from", Utils.stringDDMMYYY2Date(from))
                .setParameter("to", Utils.stringDDMMYYY2Date(to))
                .setParameter("code", code);
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                CongNo obj = new CongNo();
                Map map = (Map) result.get(i);
                obj.setCustomerId((Integer) map.get("id"));
                obj.setCustomerCode((String) map.get("code"));
                obj.setCustomerName((String) map.get("name"));
                obj.setAddress((String) map.get("unit"));
                obj.setTotal((Integer) map.get("count"));
                obj.setSanluong((Float) map.get("total"));
                lstResult.add(obj);
            }
        }
        return lstResult;
    }

    @Override
    public List<CongNo> getSanLuongOfDaiLy(String from, String to, String code) {
        List<CongNo> lstResult = new ArrayList<CongNo>();
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery("CALL report_sanluong_by_daily(:from, :to,:code)")
                .addScalar("id", StandardBasicTypes.INTEGER)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("address", StandardBasicTypes.STRING)
                .addScalar("total", StandardBasicTypes.FLOAT)
                .setParameter("from", Utils.stringDDMMYYY2Date(from))
                .setParameter("to", Utils.stringDDMMYYY2Date(to))
                .setParameter("code", code);
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                CongNo obj = new CongNo();
                Map map = (Map) result.get(i);
                obj.setCustomerId((Integer) map.get("id"));
                obj.setCustomerCode((String) map.get("code"));
                obj.setCustomerName((String) map.get("name"));
                obj.setAddress((String) map.get("address"));
                obj.setSanluong((Float) map.get("total"));
                lstResult.add(obj);
            }
        }
        return lstResult;
    }

    @Override
    public List<CongNo> getSanLuongOfNhanvien(String from, String to, String code) {
        List<CongNo> lstResult = new ArrayList<CongNo>();
        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery("CALL get_sanluong_nhanvien(:from, :to,:code)")
                .addScalar("id", StandardBasicTypes.INTEGER)
                .addScalar("code", StandardBasicTypes.STRING)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("address", StandardBasicTypes.STRING)
                .addScalar("orders", StandardBasicTypes.INTEGER)
                .addScalar("total", StandardBasicTypes.FLOAT)
                .setParameter("from", Utils.stringDDMMYYY2Date(from))
                .setParameter("to", Utils.stringDDMMYYY2Date(to))
                .setParameter("code", code);
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                CongNo obj = new CongNo();
                Map map = (Map) result.get(i);
                obj.setCustomerId((Integer) map.get("id"));
                obj.setCustomerCode((String) map.get("code"));
                obj.setCustomerName((String) map.get("name"));
                obj.setAddress((String) map.get("address"));
                obj.setTotal((Integer) map.get("orders"));
                obj.setSanluong((Float) map.get("total"));
                lstResult.add(obj);
            }
        }
        return lstResult;
    }

    @Override
    public List<CongNo> getSanLuongOfProvince(String from, String to, Integer provinceId, Integer areaId) {
        List<CongNo> lstResult = new ArrayList<CongNo>();
        StringBuilder sb = new StringBuilder();
        if (null == areaId) {
            sb.append(" CALL get_sanluong_province(:from, :to,:provinceId) ");
        } else {
            sb.append(" CALL get_sanluong_area(:from, :to,:provinceId) ");
        }

        Session session = this.sessionFactory.getCurrentSession();
        Query query = session.createSQLQuery(sb.toString())
                .addScalar("id", StandardBasicTypes.INTEGER)
                .addScalar("name", StandardBasicTypes.STRING)
                .addScalar("total", StandardBasicTypes.FLOAT)
                .setParameter("from", Utils.stringDDMMYYY2Date(from))
                .setParameter("to", Utils.stringDDMMYYY2Date(to))
                .setParameter("provinceId", provinceId == -1 ? null : provinceId);
        List result = query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).list();
        if (!result.isEmpty()) {
            for (int i = 0; i < result.size(); i++) {
                CongNo obj = new CongNo();
                Map map = (Map) result.get(i);
                obj.setCustomerId((Integer) map.get("id"));
                obj.setCustomerName((String) map.get("name"));
                obj.setSanluong((Float) map.get("total"));
                lstResult.add(obj);
            }
        }
        return lstResult;

    }

}
