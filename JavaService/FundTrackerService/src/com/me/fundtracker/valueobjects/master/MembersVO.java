package com.me.fundtracker.valueobjects.master;

public class MembersVO {
	private int memberID;
	private String firstName;
	private String lastName;
	private String nickName;
	private String gender;
	private String address;
	private String city;
	private String pincode;
	private String telephoneNo;
	private String mobileNo;
	private int active;

	public int getMemberID(){
		return memberID;
	}
	
	public String getFirstName(){
		return firstName;
	}

	public String getLastName(){
		return lastName;
	}
	
	public String getNickName(){
		return nickName;
	}

	public String getAddress(){
		return address;
	}
	
	public String getGender(){
		return gender;
	}

	public String getCity(){
		return city;
	}
	
	public String getPincode(){
		return pincode;
	}

	public String getTelephoneNo(){
		return telephoneNo;
	}
	
	public String getMobileNo(){
		return mobileNo;
	}
	
	public int getActive(){
		return active;
	}
	
	public void setMemberID(int value){
		memberID = value;
	}
	
	public void setFirstName(String value){
		firstName = value;
	}
	
	public void setLastName(String value){
		lastName = value;
	}
	
	public void setNickName(String value){
		nickName = value;
	}
	
	public void setAddress(String value){
		address = value;
	}
	
	public void setGender(String value){
		gender = value;
	}
	
	public void setCity(String value){
		city = value;
	}
	
	public void setPincode(String value){
		pincode = value;
	}

	public void setTelephoneNo(String value){
		telephoneNo = value;
	}
	
	public void setMobileNo(String value){
		mobileNo = value;
	}
	
	public void setActive(int value){
		active = value;
	}
}
