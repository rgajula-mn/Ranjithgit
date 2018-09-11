/*******************************************************************************
 *
 * This file contains proprietary information of Convergys, Inc.
 * Copying or reproduction without prior written approval is prohibited.
 * Copyright (C) 2009  Convergys, Inc.  All rights reserved.
 *
 *******************************************************************************/
package com.convergys.custom.geneva.j2ee.util;

public class IrbClientParam {
    private final int index;
    private final Object value;
    private final int type;
    private boolean isOutputParam;
    private String sqlTypeName;

    public IrbClientParam(final int index, final Object value, final int type) {
        this(index, value, type, false, null);
    }

    public IrbClientParam(final int index, final Object value, final int type,
            final boolean isOutputParam) {
        this.index = index;
        this.value = value;
        this.type = type;
        this.isOutputParam = isOutputParam;
    }

    public IrbClientParam(final int index, final Object value, final int type,
            final boolean isOutputParam, final String sqlTypeName) {
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
