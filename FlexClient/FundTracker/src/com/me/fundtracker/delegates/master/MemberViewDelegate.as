package com.me.fundtracker.delegates.master
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class MemberViewDelegate
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
		public function MemberViewDelegate( responder : IResponder )
		{
			this._service = ServiceLocator.getInstance().getRemoteObject( GlobalConstants.FUND_TRACKER_REMOTE_SERVICE_NAME );
			this._responder = responder;
		}
		
		/**
		 * Call service to get all members detail.
		 */		
		public function getAllMembersDetail() : void
		{
			var call : AsyncToken = _service.getAllMembersDetail();
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to save new members detail.
		 */		
		public function insertMemberDetails( collection : ArrayCollection ) : void
		{
			var call : AsyncToken = _service.insertMemberDetails( collection );
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to update existing members detail.
		 */		
		public function updateMemberDetails( memberVO : MembersVO ) : void
		{
			var call : AsyncToken = _service.updateMemberDetails( memberVO );
			
			call.addResponder( _responder );
		}
		
		/**
		 * Call service to update existing members detail.
		 */		
		public function deleteMemberDetails( memberID : int ) : void
		{
			var call : AsyncToken = _service.deleteMemberDetails( memberID );
			
			call.addResponder( _responder );
		}
	}
}