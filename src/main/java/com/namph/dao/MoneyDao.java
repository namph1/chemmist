/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.dao;

import com.namph.entity.Money;
import java.util.Date;
import java.util.List;

/**
 *
 * @author namph
 */
public interface MoneyDao {

    int getCount(Money money);

    List<Money> getListMoney(Money money);

    int insertMoney(Money money);

    int edittMoney(Money money);

    int deleteMoney(Money money);

    Double getTotal(Money money);
    
    Money getMoneyById(Money money);
    
    int getMaxNoOfCurMonthByTypeByStatus(Money money);
    
    int deleteDauKy(Date from, Date to);
    
    int getMoneyTonDau(Date from) throws Exception ;
}
