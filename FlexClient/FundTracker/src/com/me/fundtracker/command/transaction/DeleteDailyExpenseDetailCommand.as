package com.me.fundtracker.command.transaction
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.transaction.ExpenseViewDelegate;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class DeleteDailyExpenseDetailCommand implements ICommand, IResponder
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
		 * Call the respective remote call to get the members detail. 
		 * @param event
		 */		
		public function execute(event:CairngormEvent):void
		{			
			var expViewEvent : ExpenseViewEvent = event as ExpenseViewEvent;
			var delegate:ExpenseViewDelegate = new ExpenseViewDelegate(this);
			var dailExpVO : DailyExpenseVO = expViewEvent.data as DailyExpenseVO;
			
			delegate.deleteDailyExpenseDetail( parseInt(dailExpVO.expId), expViewEvent.expenseFilterVO );
		}
		
		/**
		 * Result handler of remote service. 
		 * @param data
		 */		
		public function result(data:Object):void
		{
			if ( data.result != null )
			{
				_model.collDailyExpenseDetails = data.result as ArrayCollection;
				
				//Set the selected index of daily expense details datagrid.
				if( _model.collDailyExpenseDetails.length > 0 )
					_model.dailyExpenseGridSelectedItem = _model.collDailyExpenseDetails[0] as DailyExpenseVO;
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