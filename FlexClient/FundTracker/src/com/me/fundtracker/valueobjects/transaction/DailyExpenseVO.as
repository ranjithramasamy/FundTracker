package com.me.fundtracker.valueobjects.transaction
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	[RemoteClass(alias="com.me.fundtracker.valueobjects.transaction.DailyExpenseVO")]
	public class DailyExpenseVO implements IValueObject
	{
		private var _expId : String;		
		private var _date : String;		
		private var _expCategoryID : int;		
		private var _expCategoryType : String;		
		private var _narration : String;		
		private var _amount : String;

		/** 
		 * @return 
		 * 
		 */		
		public function get expId():String
		{
			return _expId;
		}
		
		/** 
		 * @param value
		 * 
		 */		
		public function set expId(value:String):void
		{
			_expId = value;
		}
		
		/** 
		 * @return 
		 * 
		 */		
		public function get date():String
		{
			return _date;
		}
		
		/** 
		 * @param value
		 * 
		 */		
		public function set date(value:String):void
		{
			_date = value;
		}

		/** 
		 * @return 
		 * 
		 */		
		public function get expCategoryID():int
		{
			return _expCategoryID;
		}
		
		/** 
		 * @param value
		 * 
		 */		
		public function set expCategoryID(value:int):void
		{
			_expCategoryID = value;
		}
		
		/** 
		 * @return 
		 * 
		 */		
		public function get expCategoryType():String
		{
			return _expCategoryType;
		}
		
		/** 
		 * @param value
		 * 
		 */		
		public function set expCategoryType(value:String):void
		{
			_expCategoryType = value;
		}
		
		/** 
		 * @return 
		 * 
		 */		
		public function get narration():String
		{
			return _narration;
		}
		
		/** 
		 * @param value
		 * 
		 */		
		public function set narration(value:String):void
		{
			_narration = value;
		}
		
		/** 
		 * @return 
		 * 
		 */		
		public function get amount():String
		{
			return _amount;
		}

		/** 
		 * @param value
		 * 
		 */		
		public function set amount(value:String):void
		{
			_amount = value;
		}
	}
}