package com.me.fundtracker.events.transaction
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class ExpenseViewEvent extends CairngormEvent
	{
		/**
		 * Event constants. 
		 */		
		public static const GET_ALL_DAILY_EXPENSE_DETAILS : String = "getalldailyexpensedetails";
		
		public static const GET_ALL_EXPENSE_CATEGORY_LIST : String = "getallexpensecategorylist";
		
		public static const EXPENSE_CATEGORY_LIST_LOADED : String = "expensecategorylistloaded";
		
		public static const INSERT_DAILY_EXPENSE_DETAILS : String = "inserdailyexpensedetails";
		
		public static const UPDATE_DAILY_EXPENSE_DETAILS : String = "updatedailyexpensedetails";
		
		public static const DELETE_DAILY_EXPENSE_DETAILS : String = "deletedailyexpensedetails";
		
		/**
		 * Holds the expense filter values.
		 */		
		public var expenseFilterVO : ExpenseFilterVO;
		
		/**
		 * Holds the collection of MembersVO to add / edit their details. 
		 */		
		public var collDailyExpenseDetail : ArrayCollection = null;
		
		/**
		 * Constructor 
		 * @param type
		 * @param collMembers
		 * @param bubbles
		 * @param cancelable
		 */		
		public function ExpenseViewEvent(type:String, expFilterVO:ExpenseFilterVO = null, collDailyExp:ArrayCollection = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.expenseFilterVO = expFilterVO;
			
			this.collDailyExpenseDetail = collDailyExp;
			
			super(type, bubbles, cancelable);
		}
		
		
		/**
		 * Returns a cloned copy of the event object by setting the type property and any new properties in the clone.
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new ExpenseViewEvent( type );
		}
	}
}