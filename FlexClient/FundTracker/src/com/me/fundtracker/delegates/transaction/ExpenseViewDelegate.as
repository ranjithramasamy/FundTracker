package com.me.fundtracker.delegates.transaction
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
	import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class ExpenseViewDelegate
	{
		/**
		 * Responder object for remote service. 
		 */		
		private var _responder : IResponder;
		
		/**
		 * Holds the instance of remote service.
		 */		
		private var _service : RemoteObject;
		
		/**
		 *  Allows an IResponder to be attached for an individual call.
		 */		
		private var _token : AsyncToken;

		/**
		 * Constructor 
		 * @param responder
		 * 
		 */		
		public function ExpenseViewDelegate( responder : IResponder )
		{
			this._service = ServiceLocator.getInstance().getRemoteObject( GlobalConstants.FUND_TRACKER_REMOTE_SERVICE_NAME );
			this._responder = responder;
		}
		
		/**
		 * Call service to get daily expense details.
		 */		
		public function getAllDailyExpenseDetails( filterVO : ExpenseFilterVO ) : void
		{
			var call : AsyncToken = _service.getAllDailyExpenseDetails( filterVO );
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to get all expense types detail.
		 */		
		public function getAllExpenseTypesList() : void
		{
			var call : AsyncToken = _service.getAllExpenseTypesList();
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to insert daily expense details.
		 */		
		public function insertDailyExpenseDetails( collDailyExpVO : ArrayCollection, expFilterVO : ExpenseFilterVO ) : void
		{
			var call : AsyncToken = _service.insertDailyExpenseDetails(collDailyExpVO, expFilterVO);
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to update daily expense detail.
		 */		
		public function updateDailyExpenseDetails( collDailyExpVO : DailyExpenseVO, expFilterVO : ExpenseFilterVO ) : void
		{
			var call : AsyncToken = _service.updateDailyExpenseDetails(collDailyExpVO, expFilterVO);
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to delete daily expense detail by given ID.
		 */		
		public function deleteDailyExpenseDetail( expID : int, expFilterVO : ExpenseFilterVO ) : void
		{
			var call : AsyncToken = _service.deleteDailyExpenseDetail( expID, expFilterVO );
			
			call.addResponder( _responder );
		}
	}
}