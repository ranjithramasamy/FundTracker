package com.me.fundtracker.command.master
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.adobe.cairngorm.view.ViewLocator;
	import com.me.fundtracker.delegates.master.CategoryDelegate;
	import com.me.fundtracker.delegates.master.MemberViewDelegate;
	import com.me.fundtracker.events.master.CategoryEvent;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.master.CategoryAndAccountGroupsVO;
	import com.me.fundtracker.valueobjects.master.CategoryVO;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.views.master.viewhelpers.AddEditMembersViewHelper;
	import com.me.fundtracker.views.master.viewhelpers.CategoryViewHelper;
	import com.me.fundtracker.views.master.viewhelpers.MemberViewHelper;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	
	public class SaveCategoryDetailsCommand implements ICommand, IResponder
	{		
		/**
		 * Holds the instance of model. 
		 */		
		private var _model : MasterModelLocator = MasterModelLocator.getInstance();
		/**
		 *Keeps the Category Event instance. 
		 */		
		private var _categoryEvent : CategoryEvent;
		/**
		 * Holds the instance of Fund Tracker util class. 
		 */		
		private var _fundTrackerUtil : FundTrackerUtil = FundTrackerUtil.getInstance();
		
		/**
		 * Execute command 
		 * @param event
		 * 
		 */		
		public function execute( event : CairngormEvent ) : void
		{
			_categoryEvent = event as CategoryEvent;
			var delegate:CategoryDelegate = new CategoryDelegate(this);			
			
			// Call the respective remote methods either insert / update based on the event dispatched.
			if( _categoryEvent.type == CategoryEvent.INSERT_CATEGORY_DETAILS)
				delegate.insertCategoryDetails( _categoryEvent.categoryDetailVO );
			else
				delegate.updateCategoryDetails( _categoryEvent.categoryDetailVO );
		}
		
		/**
		 * Result handler 
		 * @param data
		 * 
		 */		
		public function result( data : Object ) : void
		{
			if ( data.result != null )
			{
				//Refresh the category list in datagrid.
				_model.collCategoryList = data.result as ArrayCollection;
				
				//Set the selected index for members details datagrid.
				if( _model.collCategoryList.length > 0 )
					_model.categoryListGridSelectedItem = _model.collCategoryList[0] as CategoryVO;

				//Reset textfield values.
				CategoryViewHelper(ViewLocator.getInstance().getViewHelper("categoryViewHelper")).resetInputValues();
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