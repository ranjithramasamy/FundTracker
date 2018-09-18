package com.me.fundtracker.dispatcher
{
	import com.me.fundtracker.events.PopMenuItemClickEvent;
	import com.me.fundtracker.events.master.CategoryEvent;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;
	
	public class FundTrackerEventDispatcher extends EventDispatcher
	{
		public function FundTrackerEventDispatcher( target:IEventDispatcher = null )
		{
			super(target);
		}
		
		public function dispatchShowLoginPageEvent() : void{
			var event : PopMenuItemClickEvent = new PopMenuItemClickEvent(PopMenuItemClickEvent.APPLICATION_EXIT);
			dispatchEvent(event);
		}
		
		public function dispatchCategoryGroupLoadedEvent() : void{
			var event : CategoryEvent = new CategoryEvent(CategoryEvent.CATEGORY_AND_ACCOUNT_GROUPS_LOADED);
			dispatchEvent(event);
		}
		
		public function dispatchExpenseCategoryTypeLoadedEvent() : void{
			var event : ExpenseViewEvent = new ExpenseViewEvent(ExpenseViewEvent.EXPENSE_CATEGORY_LIST_LOADED);
			dispatchEvent(event);
		}
	}
}