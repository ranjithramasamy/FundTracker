package com.me.fundtracker.control.master
{
	import com.adobe.cairngorm.control.FrontController;
	import com.me.fundtracker.command.master.DeleteCategroyCommand;
	import com.me.fundtracker.command.master.DeleteMemberCommand;
	import com.me.fundtracker.command.master.GetAllCategoryAndGroupDetailCommand;
	import com.me.fundtracker.command.master.GetAllMembersDetailCommand;
	import com.me.fundtracker.command.master.SaveCategoryDetailsCommand;
	import com.me.fundtracker.command.master.SaveMemberDetailsCommand;
	import com.me.fundtracker.events.master.CategoryEvent;
	import com.me.fundtracker.events.master.MembersViewEvent;
	
	public class MasterController extends FrontController
	{
		/**
		 * Constructor 
		 * 
		 */		
		public function MasterController()
		{
			initializeCommands();
		}
		
		/**
		 * Associate the commands with respective cairngorm events.
		 * 
		 */		
		private function initializeCommands() : void
		{
			// -----------------------------------------------------------------------------------------------------------------------------------------
			//					Command associate with corresponding cairngorm events for Members Management View and its child pages.
			// -----------------------------------------------------------------------------------------------------------------------------------------
			// Get all the members details list.
			addCommand( MembersViewEvent.GET_ALL_MEMBERS_DETAIL, GetAllMembersDetailCommand );
			//Insert the new member details.
			addCommand( MembersViewEvent.INSERT_MEMBER_DETAIL, SaveMemberDetailsCommand );
			//Update the member details by given member id.
			addCommand( MembersViewEvent.UPDATE_MEMBER_DETAIL, SaveMemberDetailsCommand );
			//Delete the member details by given member id.
			addCommand( MembersViewEvent.DELETE_MEMBER_DETAIL, DeleteMemberCommand );
			
			
			// -----------------------------------------------------------------------------------------------------------------------------------------
			//							Command associate with corresponding cairngorm events for Expense Category View
			// -----------------------------------------------------------------------------------------------------------------------------------------
			// Get all the expense category details list.
			addCommand( CategoryEvent.GET_ALL_CATEGORY_AND_ACCOUNT_GROUPS_DETAIL, GetAllCategoryAndGroupDetailCommand );
			//Insert the new expense category details.
			addCommand( CategoryEvent.INSERT_CATEGORY_DETAILS, SaveCategoryDetailsCommand );
			//Update the expense category details by given categroy id.
			addCommand( CategoryEvent.UPDATE_CATEGORY_DETAILS, SaveCategoryDetailsCommand );
			//Delete the expense category details by given member id.
			addCommand( CategoryEvent.DELETE_CATEGORY_DETAILS, DeleteCategroyCommand );
		}
	}
}