package com.me.fundtracker.command.master
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.me.fundtracker.delegates.master.MemberViewDelegate;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.views.master.viewhelpers.AddEditMembersViewHelper;
	import com.me.fundtracker.views.master.viewhelpers.MemberViewHelper;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class SaveMemberDetailsCommand implements ICommand, IResponder
	{		
		/**
		 * Holds the instance of model. 
		 */		
		private var _model : MasterModelLocator = MasterModelLocator.getInstance();
		/**
		 * Keeps the member view event instance. 
		 */		
		private var _memberEvent : MembersViewEvent;
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
			_memberEvent = event as MembersViewEvent;
			var delegate:MemberViewDelegate = new MemberViewDelegate(this);			
			
			// Call the respective remote methods either insert / update based on the event dispatched.
			if( _memberEvent.type == MembersViewEvent.INSERT_MEMBER_DETAIL)
				delegate.insertMemberDetails( _memberEvent.collMembersDetail );
			else
				delegate.updateMemberDetails( _memberEvent.collMembersDetail[0] as MembersVO );
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
				_model.collMembersDetail = new ArrayCollection();
				//Update the members details datagrid with fresh list.
				_model.collMembersDetail = data.result as ArrayCollection;
				//Set the selected index for members details datagrid.
				if( _model.collMembersDetail.length > 0 )
					_model.membersGridSelectedItem = _model.collMembersDetail[0] as MembersVO;

				//Close the Add/Edit member details popup.
				AddEditMembersViewHelper(ViewLocator.getInstance().getViewHelper("addEditMemberHelper")).closePopup();
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