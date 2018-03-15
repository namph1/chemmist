/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.namph.utils;

import org.hibernate.dialect.PostgreSQL82Dialect;

/**
 *
 * @author namph
 */
public class MyPostgreSQL82Dialect extends PostgreSQL82Dialect {

    @Override
    public String getIdentityColumnString(int type) {
        return super.getIdentityColumnString(type); //To change body of generated methods, choose Tools | Templates.
    }

    
    
    @Override
    public String getIdentitySelectString(String table, String column, int type) {
        String quote = "";
        if (table != null) {
            final int tlen = table.length();
            if (tlen > 1 && table.charAt(0) == '\"') {
                quote = "\"";
                // the table name can include the schema name (which can also be quoted), however this should stay as-is
                //  so it is possible to convert "\"schemaName\".\"tableName\"" into "schemaName\".\"tableName" here
                //  and this is correct.
                table = table.substring(1, tlen - 1);	// presume last character has quote-mark as well
            }
        }
        if (column != null) {
            final int clen = column.length();
            if (clen > 1 && column.charAt(0) == '\"') {
                quote = "\"";
                column = column.substring(1, clen - 1);	// presume last character has quote-mark as well
            }
        }
        return new StringBuilder().append("select currval('")
                .append(quote)
                .append(table)
                .append('_')
                .append(column)
                .append("_seq")
                .append(quote)
                .append("')")
                .toString();
    }
}
