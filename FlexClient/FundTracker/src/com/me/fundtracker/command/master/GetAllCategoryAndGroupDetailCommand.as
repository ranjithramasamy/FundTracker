package com.me.fundtracker.command.master
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.master.CategoryDelegate;
	import com.me.fundtracker.delegates.master.MemberViewDelegate;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.master.CategoryAndAccountGroupsVO;
	import com.me.fundtracker.valueobjects.master.CategoryVO;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class GetAllCategoryAndGroupDetailCommand implements ICommand, IResponder
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
		 * Holds the instance of Fund Tracker Model Loacator class. 
		 */	
		private var _fundTrackerModel : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Call the respective remote call to get the expense category detail. 
		 * @param event
		 */		
		public function execute(event:CairngormEvent):void
		{			
			var delegate:CategoryDelegate = new CategoryDelegate(this);
			
			delegate.getAllCategoryAndGroupDetail();
		}
		
		/**
		 * Result handler of remote service. 
		 * @param data
		 */		
		public function result(data:Object):void
		{
			if ( data.result != null )
			{
				var result : CategoryAndAccountGroupsVO = data.result as CategoryAndAccountGroupsVO;
				
				// Destroy the exisitng items in the collections.
				_model.collCategoryList.removeAll();
				_model.collAccountGroups.removeAll();
				
				//Update the collCategoryList details datagrid with fresh list.
				_model.collCategoryList = result.categoryList;
				_model.collAccountGroups = result.accountGroups;
				
				if ( _model.collCategoryList.length > 0 )
				_model.categoryListGridSelectedItem = _model.collCategoryList[0] as CategoryVO;
				
				// Dispatch event once the category groups loaded.
				_fundTrackerModel.fundTrackerEventDispatcher.dispatchCategoryGroupLoadedEvent();
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