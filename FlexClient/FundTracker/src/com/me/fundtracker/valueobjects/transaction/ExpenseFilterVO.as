package com.me.fundtracker.valueobjects.transaction
{
	import com.adobe.cairngorm.vo.IValueObject;
	
	[Bindable]
	[RemoteClass(alias="com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO")]
	public class ExpenseFilterVO implements IValueObject
	{
		/**
		 * From Date 
		 */		
		public var fromDate : String;
		
		/**
		 *To Date 
		 */		
		public var toDate : String;
	}
}