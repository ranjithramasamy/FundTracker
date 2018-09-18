package com.me.fundtracker.delegates.master
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.master.CategoryVO;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class CategoryDelegate
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
		 */		
		public function CategoryDelegate( responder : IResponder )
		{
			this._service = ServiceLocator.getInstance().getRemoteObject( GlobalConstants.FUND_TRACKER_REMOTE_SERVICE_NAME );
			this._responder = responder;
		}
		
		/**
		 * Call service to get all expense category detail.
		 */		
		public function getAllCategoryAndGroupDetail() : void
		{
			var call : AsyncToken = _service.getAllCategoryAndGroupDetail();
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to save new expense category detail.
		 */		
		public function insertCategoryDetails( categoryVO : CategoryVO ) : void
		{
			var call : AsyncToken = _service.insertCategoryDetails( categoryVO );
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to update existing expense category detail.
		 */		
		public function updateCategoryDetails( categoryVO : CategoryVO ) : void
		{
			var call : AsyncToken = _service.updateCategoryDetails( categoryVO );
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to delete expense category detail.
		 */		
		public function deleteCategoryDetail( categoryID : int ) : void
		{
			var call : AsyncToken = _service.deleteCategoryDetail( categoryID );
			
			call.addResponder( _responder );
		}
	}
}