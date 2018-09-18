package com.me.fundtracker.command.master
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.master.CategoryDelegate;
	import com.me.fundtracker.delegates.master.MemberViewDelegate;
	import com.me.fundtracker.events.master.CategoryEvent;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class DeleteMemberCommand implements ICommand, IResponder
	{
		/**
		 * Holds the instance of model. 
		 */		
		private var _model : MasterModelLocator = MasterModelLocator.getInstance();
		
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
			var memberEvent : MembersViewEvent = event as MembersViewEvent;
			var delegate:MemberViewDelegate = new MemberViewDelegate(this);
			var memberVO : MembersVO = memberEvent.data as MembersVO;
			
			delegate.deleteMemberDetails( memberVO.memberID );
		}
		
		/**
		 * Result handler of remote service. 
		 * @param data
		 */		
		public function result(data:Object):void
		{
			if ( data.result != null )
			{
				_model.collMembersDetail = data.result as ArrayCollection;
				
				if ( _model.collMembersDetail.length > 0 )
				_model.membersGridSelectedItem = _model.collMembersDetail[0] as MembersVO;
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