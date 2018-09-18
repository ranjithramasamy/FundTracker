package com.me.fundtracker.control.transaction
{
	import com.adobe.cairngorm.control.FrontController;
	import com.me.fundtracker.command.transaction.DeleteDailyExpenseDetailCommand;
	import com.me.fundtracker.command.transaction.GetAllExpenseTypesCommand;
	import com.me.fundtracker.command.transaction.GetDailyExpenseDetailsCommand;
	import com.me.fundtracker.command.transaction.SaveDailyExpenseDetailsCommand;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	
	public class TransactionController extends FrontController
	{
		public function TransactionController()
		{
			initializeCommands();
		}
		
		/**
		 * Associate the commands with respective cairngorm events.
		 * 
		 */		
		private function initializeCommands() : void
		{
			// -----------------------------------------------------------------------------------------------------------------------------------------
			//					Command to associate with corresponding cairngorm events for Expense View and its child pages.
			// -----------------------------------------------------------------------------------------------------------------------------------------
			
			// Get daily expense details list.
			addCommand( ExpenseViewEvent.GET_ALL_DAILY_EXPENSE_DETAILS, GetDailyExpenseDetailsCommand );
			
			// Get all expense types list.
			addCommand( ExpenseViewEvent.GET_ALL_EXPENSE_CATEGORY_LIST, GetAllExpenseTypesCommand );
			
			// Add daily expense list.
			addCommand( ExpenseViewEvent.INSERT_DAILY_EXPENSE_DETAILS, SaveDailyExpenseDetailsCommand );
			
			// Edit daily expense list.
			addCommand( ExpenseViewEvent.UPDATE_DAILY_EXPENSE_DETAILS, SaveDailyExpenseDetailsCommand );
			
			// Delete daily expense detail.
			addCommand( ExpenseViewEvent.DELETE_DAILY_EXPENSE_DETAILS, DeleteDailyExpenseDetailCommand );
			
			// -----------------------------------------------------------------------------------------------------------------------------------------
			//					Command to associate with corresponding cairngorm events for Donation View and its child pages.
			// -----------------------------------------------------------------------------------------------------------------------------------------
			
			// Get daily expense details list.
			addCommand( ExpenseViewEvent.GET_ALL_DAILY_EXPENSE_DETAILS, GetDailyExpenseDetailsCommand );
			
			// Get all expense types list.
			addCommand( ExpenseViewEvent.GET_ALL_EXPENSE_CATEGORY_LIST, GetAllExpenseTypesCommand );
			
			// Add daily expense list.
			addCommand( ExpenseViewEvent.INSERT_DAILY_EXPENSE_DETAILS, SaveDailyExpenseDetailsCommand );
			
			// Edit daily expense list.
			addCommand( ExpenseViewEvent.UPDATE_DAILY_EXPENSE_DETAILS, SaveDailyExpenseDetailsCommand );
			
			// Delete daily expense detail.
			addCommand( ExpenseViewEvent.DELETE_DAILY_EXPENSE_DETAILS, DeleteDailyExpenseDetailCommand );
			
		}
	}
}