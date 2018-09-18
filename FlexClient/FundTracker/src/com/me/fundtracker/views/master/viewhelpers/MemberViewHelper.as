package com.me.fundtracker.views.master.viewhelpers
{
	import assets.skins.Blue.Application;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.GlobalMessages;
	import com.me.fundtracker.utils.master.MasterGlobeConstants;
	import com.me.fundtracker.utils.master.MasterGlobeMessages;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.views.master.AddEditMembers;
	import com.me.fundtracker.views.master.Members;
	
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	public class MemberViewHelper extends ViewHelper
	{
		/**
		 * Holds the instance of model. 
		 */
		[Bindable]
		public var model : MasterModelLocator = MasterModelLocator.getInstance();
		
		/**
		 * Holds the instance of model. 
		 */
		private var _model : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		public var _view : Members;
		
		/**
		 * Constructor
		 */
		public function MemberViewHelper()
		{
			super();
		}
		
		/**
		 * On initialize.
		 */		
		public function onInit() : void
		{
			_view = Members(view);
		}
		
		/**
		 * Call remote service to get the all members details list. 
		 */		
		public function getAllMembers() : void
		{
			var event : MembersViewEvent = new MembersViewEvent(MembersViewEvent.GET_ALL_MEMBERS_DETAIL);
			
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		/**
		 * Show Add/Edit members popup in add mode.
		 */		
		public function addMemberDetails() : void
		{
			showAddEditMembersPopup( MasterGlobeConstants.ADD_MEMBER_MODE );
		}
		
		/**
		 * Show Add/Edit members popup in edit mode.
		 */	
		public function editMemberDetails() : void
		{
			if ( _view.dg_memberdetails.selectedItem != null )
				showAddEditMembersPopup( MasterGlobeConstants.EDIT_MEMBER_MODE );
			else
				Alert.show(MasterGlobeMessages.DATAGRID_ITEM_NOT_SELECTED, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Get confirmation to delete member details.
		 */		
		public function confirmDeleteMemberDetails() : void
		{
			if ( _view.dg_memberdetails.selectedItem != null )
				Alert.show(MasterGlobeMessages.CONFIRM_DELETE_MEMBER_DETAILS, GlobalConstants.ALERT_TITLE_CONFIRMATION, Alert.YES | Alert.NO, null, deleteMemberDetail);
			else
				Alert.show(MasterGlobeMessages.NO_ITEM_TO_DELETE, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Show the home page.
		 */		
		public function showHomePage() : void
		{
			_model.NAVIGATIONAL_CONTAINER.removeAllElements();
			_model.CURRENT_VIEW = GlobalConstants.HOME_VIEW;
		}
		
		
		// -------------------------------------------------------------------------------------------------------------------------
		//											Private Methods Definition
		// -------------------------------------------------------------------------------------------------------------------------
		/**
		 * Show Add/Edit member popup.
		 */
		private function showAddEditMembersPopup( viewMode : String ) : void
		{
			var popup : AddEditMembers = AddEditMembers(PopUpManager.createPopUp(DisplayObject(FlexGlobals.topLevelApplication), AddEditMembers, true));
			
			popup.addEditMemberHelper.viewMode = viewMode;
			
			// If the popup opened in "Edit" mode, then keep the edited member details in collection.
			if ( viewMode == MasterGlobeConstants.EDIT_MEMBER_MODE )
			{
				model.collEditableMembersDetail.removeAll();
				model.collEditableMembersDetail.addItem( _view.dg_memberdetails.selectedItem as MembersVO );
			}
			
			PopUpManager.centerPopUp(popup);
		}
		
		/**
		 * Dispatch event to delete the member details in DB via remote service call.
		 * @param event
		 * 
		 */		
		private function deleteMemberDetail( event : CloseEvent ) : void
		{
			if ( event.detail == Alert.YES )
			{
				var memberVO : MembersVO = _view.dg_memberdetails.selectedItem as MembersVO;
				var memberEvent : MembersViewEvent = new MembersViewEvent( MembersViewEvent.DELETE_MEMBER_DETAIL );
				
				memberEvent.data = memberVO;
				// Dsipatch Delete event to perform remote operations.
				CairngormEventDispatcher.getInstance().dispatchEvent(memberEvent);
			}
		}
	}
}