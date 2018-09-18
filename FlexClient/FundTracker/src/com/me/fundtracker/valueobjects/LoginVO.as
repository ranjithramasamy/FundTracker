package com.me.fundtracker.valueobjects
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	[RemoteClass(alias="com.me.fundtracker.valueobjects.login.LoginVO")]
	public class LoginVO implements IValueObject
	{
		private var _username : String = "";
		
		private var _password : String = "";
		
		public function get username() : String
		{
			return _username;
		}
		
		public function get password() : String
		{
			return _password;
		}
		
		public function set username( value : String ) : void
		{
			_username = value;
		}
		
		public function set password( value : String ) : void
		{
			_password = value;
		}
	}
}