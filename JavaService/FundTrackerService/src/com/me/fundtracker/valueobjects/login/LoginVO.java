package com.me.fundtracker.valueobjects.login;

public class LoginVO {
	private String username;
	private String password;

	public String getUsername(){
		return username;
	}

	public String getPassword(){
		return password;
	}

	public void setUsername(String value){
		username = value;
	}
   
	public void setPassword(String value){
		password = value;
	}
}
