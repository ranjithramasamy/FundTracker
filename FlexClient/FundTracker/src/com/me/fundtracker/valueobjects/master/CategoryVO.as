package com.me.fundtracker.valueobjects.master
{
	import com.adobe.cairngorm.vo.IValueObject;

	[Bindable]
    [RemoteClass(alias="com.me.fundtracker.valueobjects.master.CategoryVO")]
	public class CategoryVO implements IValueObject
	{
		private var _categoryID : int;	
		private var _accountGroupKey : String;
		private var _accountGroupName : String;
		private var _defaultAccountType : String;
		private var _description : String;
		
		public function get categoryID() : int
		{
			return _categoryID;
		}
		
		public function get accountGroupKey() : String
		{
			return _accountGroupKey;
		}
		
		public function get accountGroupName() : String
		{
			return _accountGroupName;
		}
		
		public function get description() : String
		{
			return _description;
		}
		
		public function get defaultAccountType() : String
		{
			return _defaultAccountType;
		}
		
		public function set categoryID( value : int ) : void
		{
			_categoryID = value;
		}
		
		public function set accountGroupKey( value : String ) : void
		{
			_accountGroupKey = value;
		}
		
		public function set accountGroupName( value : String ) : void
		{
			_accountGroupName = value;
		}
		
		public function set description( value : String ) : void
		{
			_description = value;
		}
		
		public function set defaultAccountType( value : String ) : void
		{
			_defaultAccountType = value;
		}
	}
}