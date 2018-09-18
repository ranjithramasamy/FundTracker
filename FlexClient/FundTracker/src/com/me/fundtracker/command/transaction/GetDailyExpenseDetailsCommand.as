package com.me.fundtracker.command.transaction
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.transaction.ExpenseViewDelegate;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class GetDailyExpenseDetailsCommand implements IResponder, ICommand
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
		public function execute(event:CairngormEvent):void
		{
			var filterVO : ExpenseFilterVO = ExpenseViewEvent(event).expenseFilterVO;
			var delegate:ExpenseViewDelegate = new ExpenseViewDelegate(this);
			
			delegate.getAllDailyExpenseDetails( filterVO );
		}
		
		/**
		 * Service result handler. 
		 * @param data
		 * 
		 */		
		public function result(data:Object):void
		{
			if ( data.result != null )
				_model.collDailyExpenseDetails = data.result as ArrayCollection;
			else
				_model.collDailyExpenseDetails = new ArrayCollection();
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