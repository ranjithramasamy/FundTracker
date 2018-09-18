package com.me.fundtracker.command.transaction
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.transaction.ExpenseViewDelegate;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	
	public class GetAllExpenseTypesCommand implements IResponder, ICommand
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
		 * Holds the instance of Fund Tracker Model Loacator class. 
		 */	
		private var _fundTrackerModel : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Call the respective remote call to get the expense types list. 
		 * @param event
		 */	
		public function execute(event:CairngormEvent):void
		{
			var delegate:ExpenseViewDelegate = new ExpenseViewDelegate(this);
			
			delegate.getAllExpenseTypesList( );
		}
		
		/**
		 * Result handler of remote service. 
		 * @param data
		 */	
		public function result(data:Object):void
		{
			if ( data.result != null )
				_model.collExpensTypes = data.result as ArrayCollection;
			else
				_model.collExpensTypes = new ArrayCollection();
			
			// Dispatch event once the category groups loaded.
			_fundTrackerModel.fundTrackerEventDispatcher.dispatchExpenseCategoryTypeLoadedEvent();
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