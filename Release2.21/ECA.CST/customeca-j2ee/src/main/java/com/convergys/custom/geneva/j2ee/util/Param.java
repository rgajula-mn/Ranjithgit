package com.convergys.custom.geneva.j2ee.util;

public class Param {
    private int index;
    private Object value;
    private int type;
    private boolean isOutputParam = false;
    private String sqlTypeName;

    public Param(int index, Object value, int type) {
        this (index, value, type, false, null);
    }

    public Param(int index, Object value, int type, boolean isOutputParam) {
        this.index = index;
        this.value = value;
        this.type = type;
        this.isOutputParam = isOutputParam;
    }

    public Param(int index, Object value, int type, boolean isOutputParam, String sqlTypeName) {
        this.index = index;
        this.value = value;
        this.type = type;
        this.isOutputParam = isOutputParam;
        this.sqlTypeName = sqlTypeName;
    }

    public int getIndex() {
        return index;
    }

    public Object getValue() {
        return value;
    }

    public int getType() {
        return type;
    }

    public boolean isOutputParam() {
        return isOutputParam;
    }

    public String getSqlTypeName() {
        return sqlTypeName;
    }
}