package com.me.fundtracker.command.transaction
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.me.fundtracker.delegates.master.MemberViewDelegate;
	import com.me.fundtracker.delegates.transaction.ExpenseViewDelegate;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
	import com.me.fundtracker.views.master.viewhelpers.AddEditMembersViewHelper;
	import com.me.fundtracker.views.master.viewhelpers.MemberViewHelper;
	import com.me.fundtracker.views.transaction.viewhelpers.AddEditExpensesViewHelper;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class SaveDailyExpenseDetailsCommand implements ICommand, IResponder
	{		
		/**
		 * Holds the instance of model. 
		 */		
		private var _model : TransactionModelLocator = TransactionModelLocator.getInstance();
		
		/**
		 * Holds the instance of Fund Tracker util class. 
		 */		
		private var _fundTrackerUtil : FundTrackerUtil = FundTrackerUtil.getInstance();
		
		/**
		 * Command execution 
		 * @param event
		 * 
		 */		
		public function execute( event : CairngormEvent ) : void
		{
			var expenseEvent : ExpenseViewEvent = event as ExpenseViewEvent;
			var delegate:ExpenseViewDelegate = new ExpenseViewDelegate(this);			
			
			// Call the respective remote methods either insert / update based on the event dispatched.
			if( expenseEvent.type == ExpenseViewEvent.INSERT_DAILY_EXPENSE_DETAILS)
				delegate.insertDailyExpenseDetails( expenseEvent.collDailyExpenseDetail, expenseEvent.expenseFilterVO );
			else
				delegate.updateDailyExpenseDetails( expenseEvent.collDailyExpenseDetail[0] as DailyExpenseVO, expenseEvent.expenseFilterVO );
		}
		
		/**
		 * Service result handler. 
		 * @param data
		 * 
		 */		
		public function result( data : Object ) : void
		{
			if ( data.result != null )
			{
				// Destroy the exisitng items in the collections.
				_model.collDailyExpenseDetails = new ArrayCollection();
				//Update the members details datagrid with fresh list.
				_model.collDailyExpenseDetails = data.result as ArrayCollection;
				//Set the selected index of daily expense details datagrid.
				if( _model.collDailyExpenseDetails.length > 0 )
					_model.dailyExpenseGridSelectedItem = _model.collDailyExpenseDetails[0] as DailyExpenseVO;

				//Close the Add/Edit member details popup.
				AddEditExpensesViewHelper(ViewLocator.getInstance().getViewHelper("addEditExpenseHelper")).closePopup();
			}				
		}
		
		/**
		 * Fault handler of remote service. 
		 * @param info
		 */		
		public function fault( info : Object ) : void
		{
			_fundTrackerUtil.handleServiceFaultError( info );
		}
	}
}