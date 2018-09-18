package com.me.fundtracker.valueobjects.master;

import java.util.ArrayList;

public class CategoryAndAccountGroupsVO {
	private ArrayList<CategoryGroupVO> accountGroups;
	private ArrayList<CategoryVO> categoryList;
	
	public ArrayList<CategoryGroupVO> getAccountGroups(){
		return accountGroups;
	}
	
	public ArrayList<CategoryVO> getCategoryList(){
		return categoryList;
	}
	
	public void setAccountGroups(ArrayList<CategoryGroupVO> value){
		accountGroups = value;
	}
	
	public void setCategoryList(ArrayList<CategoryVO> value){
		categoryList = value;
	}
}
