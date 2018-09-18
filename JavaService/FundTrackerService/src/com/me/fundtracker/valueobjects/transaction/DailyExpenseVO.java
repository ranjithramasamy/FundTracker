package com.me.fundtracker.valueobjects.transaction;

public class DailyExpenseVO {
	private String expId;
	private String date;
	private int expCategoryID;
	private String expCategoryType;
	private String narration;
	private String amount;
	
	public String getExpId() {
		return expId;
	}
	
	public String getDate(){
		return date;
	}
	
	public int getExpCategoryID() {
		return expCategoryID;
	}
	
	public String getExpCategoryType(){
		return expCategoryType;
	}
	
	public String getNarration(){
		return narration;
	}
	
	public String getAmount(){
		return amount;
	}
	
	public void setExpId(String expId) {
		this.expId = expId;
	}
	
	public void setDate(String value){
		this.date = value;
	}
	
	public void setExpCategoryID(int expCategoryID) {
		this.expCategoryID = expCategoryID;
	}
	
	public void setExpCategoryType(String value){
		this.expCategoryType = value;
	}
	
	public void setNarration(String value){
		this.narration = value;
	}
	
	public void setAmount(String value){
		this.amount = value;
	}
}
