package com.me.fundtracker.valueobjects.transaction
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	[RemoteClass(alias="com.me.fundtracker.valueobjects.transaction.ExpenseTypesVO")]
	public class ExpenseTypesVO implements IValueObject
	{
		private var _expCategoryID : int;
		private var _expCategoryType : String;		
		private var _defaultAccountType : String;
		
		public function get expCategoryID() : int
		{
			return _expCategoryID;
		}
		
		public function get expCategoryType() : String
		{
			return _expCategoryType;
		}
		
		public function get defaultAccountType() : String
		{
			return _defaultAccountType;
		}
		
		public function set expCategoryID( value : int ) : void
		{
			_expCategoryID = value;
		}
		
		public function set expCategoryType( value : String ) : void
		{
			_expCategoryType = value;
		}
		
		public function set defaultAccountType( value : String ) : void
		{
			_defaultAccountType = value;
		}
	}
}