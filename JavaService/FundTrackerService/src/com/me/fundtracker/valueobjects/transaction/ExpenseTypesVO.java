package com.me.fundtracker.valueobjects.transaction;

public class ExpenseTypesVO {
	private int expCategoryID;
	private String expCategoryType;
	private String defaultAccountType;
	
	public int getExpCategoryID(){
		return expCategoryID;
	}
	
	public String getExpCategoryType(){
		return expCategoryType;
	}
	
	public String getDefaultAccountType(){
		return defaultAccountType;
	}
	
	public void setExpCategoryID(int value){
		expCategoryID = value;
	}
	
	public void setExpCategoryType(String value){
		expCategoryType = value;
	}
	
	public void setDefaultAccountType(String value){
		defaultAccountType = value;
	}
}
