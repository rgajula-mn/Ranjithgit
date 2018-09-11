package com.convergys.custom.geneva.j2ee.util;

public class AttributeDefination {
	
	public AttributeDefination(int fieldIndex, int fieldLength) {
		this.fieldIndex = fieldIndex;
		this.fieldLength = fieldLength;
	}
	
	private int fieldIndex;
	public int getFieldIndex() {
		return fieldIndex;
	}
	public void setFieldIndex(int fieldIndex) {
		this.fieldIndex = fieldIndex;
	}
	public int getFieldLength() {
		return fieldLength;
	}
	public void setFieldLength(int fieldLength) {
		this.fieldLength = fieldLength;
	}
	private int fieldLength;

}
