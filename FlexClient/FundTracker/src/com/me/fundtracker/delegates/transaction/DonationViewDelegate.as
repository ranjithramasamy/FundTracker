package com.me.fundtracker.delegates.transaction
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.transaction.DonationFilterVO;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class DonationViewDelegate
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
		public function DonationViewDelegate( responder : IResponder )
		{
			this._service = ServiceLocator.getInstance().getRemoteObject( GlobalConstants.FUND_TRACKER_REMOTE_SERVICE_NAME );
			this._responder = responder;
		}
		
		/**
		 * Call service to get all donation details.
		 */		
		public function getAllDailyExpenseDetailsByDate( filterVO : DonationFilterVO ) : void
		{
			var call : AsyncToken = _service.getAllDailyExpenseDetailsByDate( filterVO );
			
			call.addResponder( _responder );
		}
	}
}