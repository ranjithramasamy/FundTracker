package com.me.fundtracker.valueobjects.master
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
    [RemoteClass(alias="com.me.fundtracker.valueobjects.master.MembersVO")]
	public class MembersVO implements IValueObject
	{
		private var _memberID : int;		
		private var _firstName : String;
		private var _lastName : String;
		private var _nickName : String;
		
		private var _gender : String;
		private var _address : String;
		private var _city : String;
		
		private var _pincode : String;
		private var _telephoneNo : String;
		private var _mobileNo : String;
		private var _active : int;
		
		public function get memberID() : int
		{
			return _memberID;
		}
		
		public function get firstName() : String
		{
			return _firstName;
		}
		
		public function get lastName() : String
		{
			return _lastName;
		}
		
		public function get nickName() : String
		{
			return _nickName;
		}
		
		public function get gender() : String
		{
			return _gender;
		}
		
		public function get address() : String
		{
			return _address;
		}
		
		public function get city() : String
		{
			return _city;
		}
		
		public function get pincode() : String
		{
			return _pincode;
		}
		
		public function get telephoneNo() : String
		{
			return _telephoneNo;
		}
		
		public function get mobileNo() : String
		{
			return _mobileNo;
		}
		
		public function get active() : int
		{
			return _active;
		}
		
		public function set memberID( value : int ) : void
		{
			_memberID = value;
		}
		
		public function set firstName( value : String ) : void
		{
			_firstName = value;
		}
		
		public function set lastName( value : String ) : void
		{
			_lastName = value;
		}
		
		public function set nickName( value : String ) : void
		{
			_nickName = value;
		}
		
		public function set gender( value : String ) : void
		{
			_gender = value;
		}
		
		public function set address( value : String ) : void
		{
			_address = value;
		}
		
		public function set city( value : String ) : void
		{
			_city = value;
		}
		
		public function set pincode( value : String ) : void
		{
			_pincode = value;
		}
		
		public function set telephoneNo( value : String ) : void
		{
			_telephoneNo = value;
		}
		
		public function set mobileNo( value : String ) : void
		{
			_mobileNo = value;
		}
		
		public function set active( value : int ) : void
		{
			_active = value;
		}
	}
}