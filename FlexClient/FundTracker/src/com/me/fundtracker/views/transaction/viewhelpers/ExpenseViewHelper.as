package com.me.fundtracker.views.transaction.viewhelpers
{
	import assets.skins.Blue.Application;
	
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.GlobalMessages;
	import com.me.fundtracker.utils.master.MasterGlobeConstants;
	import com.me.fundtracker.utils.master.MasterGlobeMessages;
	import com.me.fundtracker.utils.transaction.TransactionGlobeConstants;
	import com.me.fundtracker.utils.transaction.TransactionGlobeMessages;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
	import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
	import com.me.fundtracker.views.master.AddEditMembers;
	import com.me.fundtracker.views.master.Members;
	import com.me.fundtracker.views.transaction.AddEditExpenses;
	import com.me.fundtracker.views.transaction.Expenses;
	
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.FlexGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.components.gridClasses.GridColumn;
	import spark.formatters.CurrencyFormatter;
	
	public class ExpenseViewHelper extends ViewHelper
	{
		/**
		 * Holds the instance of model. 
		 */
		[Bindable]
		public var model : TransactionModelLocator = TransactionModelLocator.getInstance();
		
		/**
		 * Holds the instance of model. 
		 */
		private var _fundTranckermodel : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Holds the instance of fundtracker util. 
		 */
		private var _fundTrackerUtil : FundTrackerUtil = FundTrackerUtil.getInstance();
		
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		private var _view : Expenses;
		
		/**
		 * Constructor
		 */
		public function ExpenseViewHelper()
		{
			super();
		}
		
		/**
		 * On initialize.
		 */		
		public function onInit() : void
		{
			_view = Expenses(view);
		}
		
		/**
		 * On Complete.
		 */		
		public function onComplete() : void
		{
			_view.filter_comp.fromDate = new Date();
			_view.filter_comp.toDate = new Date();
			
			// Load daily expense details by filters.
			getAllDailyExpenseDetailsByDate();
		}
		
		/**
		 * Call remote service to get the all members details list. 
		 */		
		public function getAllDailyExpenseDetailsByDate() : void
		{
			var filterVO : ExpenseFilterVO = new ExpenseFilterVO();
			var event : ExpenseViewEvent = new ExpenseViewEvent(ExpenseViewEvent.GET_ALL_DAILY_EXPENSE_DETAILS);
			
			filterVO.fromDate = _fundTrackerUtil.formatDate(_view.filter_comp.fromDate, TransactionGlobeConstants.DATE_FORMAT);
			filterVO.toDate = _fundTrackerUtil.formatDate(_view.filter_comp.toDate, TransactionGlobeConstants.DATE_FORMAT);
			event.expenseFilterVO = filterVO;
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		/**
		 * Show Add/Edit members popup in add mode.
		 */		
		public function addNewExpense() : void
		{
			showAddEditExpensePopup( TransactionGlobeConstants.ADD_EXPENSE_MODE );
		}
		
		/**
		 * Show Add/Edit members popup in edit mode.
		 */	
		public function editExpenseDetails() : void
		{
			if ( _view.dg_dailyexpensedetails.selectedItem != null )
				showAddEditExpensePopup( TransactionGlobeConstants.EDIT_EXPENSE_MODE );
			else
				Alert.show(TransactionGlobeMessages.DATAGRID_ITEM_NOT_SELECTED, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Get confirmation to delete member details.
		 */		
		public function confirmDeleteExpenseDetails() : void
		{
			if ( _view.dg_dailyexpensedetails.selectedItem != null )
				Alert.show(TransactionGlobeMessages.CONFIRM_DELETE_EXPENSE_DETAILS, GlobalConstants.ALERT_TITLE_CONFIRMATION, Alert.YES | Alert.NO, null, deleteExpenseDetail);
			else
				Alert.show(TransactionGlobeMessages.NO_ITEM_TO_DELETE, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Format Amount column 
		 * @param item
		 * @param column
		 * @return 
		 * 
		 */		
		public function formatAmount( item : Object, column : GridColumn ) : String
		{
			var currFormatter : CurrencyFormatter = new CurrencyFormatter();
			
			currFormatter.fractionalDigits = 2;
			currFormatter.trailingZeros = true;
			currFormatter.currencySymbol = "Rs.";
			currFormatter.useCurrencySymbol = true;
			
			return currFormatter.format( item.amount );
		}
		
		/**
		 * Show the home page.
		 */		
		public function showHomePage() : void
		{
			_fundTranckermodel.NAVIGATIONAL_CONTAINER.removeAllElements();
			_fundTranckermodel.CURRENT_VIEW = GlobalConstants.HOME_VIEW;
		}
		
		
		// -------------------------------------------------------------------------------------------------------------------------
		//											Private Methods Definition
		// -------------------------------------------------------------------------------------------------------------------------
		
		
		/**
		 * Show Add/Edit member popup.
		 */
		private function showAddEditExpensePopup( viewMode : String ) : void
		{
			var popup : AddEditExpenses = AddEditExpenses(PopUpManager.createPopUp(DisplayObject(FlexGlobals.topLevelApplication), AddEditExpenses, true));
			
			popup.addEditExpenseHelper.viewMode = viewMode;
			popup.addEditExpenseHelper.expFilterVO = getExpFilterVO();
			
			// If the popup opened in "Edit" mode, then keep the edited member details in collection.
			if ( viewMode == TransactionGlobeConstants.EDIT_EXPENSE_MODE )
			{
				model.collEditableExpenseDetail.removeAll();
				model.collEditableExpenseDetail.addItem( _view.dg_dailyexpensedetails.selectedItem as DailyExpenseVO );
			}
			
			PopUpManager.centerPopUp(popup);
		}
		
		private function getExpFilterVO() : ExpenseFilterVO
		{
			var filterVO : ExpenseFilterVO = new ExpenseFilterVO();
			
			filterVO.fromDate = _fundTrackerUtil.formatDate(_view.filter_comp.fromDate, TransactionGlobeConstants.DATE_FORMAT);
			filterVO.toDate = _fundTrackerUtil.formatDate(_view.filter_comp.toDate, TransactionGlobeConstants.DATE_FORMAT);
			
			return filterVO;
		}
		
		/**
		 * Dispatch event to delete the member details in DB via remote service call.
		 * @param event
		 * 
		 */		
		private function deleteExpenseDetail( event : CloseEvent ) : void
		{
			if ( event.detail == Alert.YES )
			{
				var deleteExpEvent : ExpenseViewEvent = new ExpenseViewEvent( ExpenseViewEvent.DELETE_DAILY_EXPENSE_DETAILS );
				
				deleteExpEvent.expenseFilterVO = getExpFilterVO();
				deleteExpEvent.data = _view.dg_dailyexpensedetails.selectedItem as DailyExpenseVO;
				// Dsipatch Delete event to perform remote operations.
				CairngormEventDispatcher.getInstance().dispatchEvent(deleteExpEvent);
			}
		}
	}
}