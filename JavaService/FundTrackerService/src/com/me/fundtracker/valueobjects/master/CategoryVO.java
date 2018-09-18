package com.me.fundtracker.valueobjects.master;

public class CategoryVO {
	private int categoryID;
	private String accountGroupKey;
	private String accountGroupName;
	private String description;
	private String defaultAccountType;

	public int getCategoryID(){
		return categoryID;
	}
	
	public String getAccountGroupKey(){
		return accountGroupKey;
	}
	
	public String getAccountGroupName(){
		return accountGroupName;
	}
	
	public String getDescription(){
		return description;
	}

	public String getDefaultAccountType(){
		return defaultAccountType;
	}
	
	public void setCategoryID(int value){
		categoryID = value;
	}
	
	public void setAccountGroupKey(String value){
		accountGroupKey = value;
	}
	
	public void setAccountGroupName(String value){
		accountGroupName = value;
	}
	
	public void setDescription(String value){
		description = value;
	}
	
	public void setDefaultAccountType(String value){
		defaultAccountType = value;
	}
}
