package com.me.fundtracker.views.transaction.viewhelpers
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.events.transaction.DonationViewEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.transaction.TransactionGlobeConstants;
	import com.me.fundtracker.utils.transaction.TransactionGlobeMessages;
	import com.me.fundtracker.valueobjects.transaction.DonationFilterVO;
	import com.me.fundtracker.views.transaction.Donation;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	
	import spark.components.gridClasses.GridColumn;
	import spark.formatters.CurrencyFormatter;

	public class DonationViewHelper extends ViewHelper
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
		private var _view : Donation;
		
		/**
		 * Constructor
		 */
		public function DonationViewHelper()
		{
			super();
		}
		
		/**
		 * On initialize.
		 */		
		public function onInit() : void
		{
			_view = Donation(view);
		}
		
		/**
		 * On Complete.
		 */		
		public function onComplete() : void
		{
			_view.filter_comp.fromDate = new Date();
			_view.filter_comp.toDate = new Date();
			
			// Load donation details by filters.
			getAllDonationDetailsByDate();
		}
		
		/**
		 * Call remote service to get the all donation details list. 
		 */		
		public function getAllDonationDetailsByDate() : void
		{
			var filterVO : DonationFilterVO = new DonationFilterVO();
			var event : DonationViewEvent = new DonationViewEvent(DonationViewEvent.GET_ALL_DONATION_DETAILS);
			
			filterVO.fromDate = _fundTrackerUtil.formatDate(_view.filter_comp.fromDate, TransactionGlobeConstants.DATE_FORMAT);
			filterVO.toDate = _fundTrackerUtil.formatDate(_view.filter_comp.toDate, TransactionGlobeConstants.DATE_FORMAT);
			event.donationFilterVO = filterVO;
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		/**
		 * Show Add/Edit donation popup in add mode.
		 */		
		public function addNewDonationDetail() : void
		{
			showAddEditDonationPopup( TransactionGlobeConstants.ADD_EXPENSE_MODE );
		}
		
		/**
		 * Show Add/Edit donation popup in edit mode.
		 */	
		public function editDonationDetails() : void
		{
			if ( _view.dg_donationdetails.selectedItem != null )
				showAddEditDonationPopup( TransactionGlobeConstants.EDIT_EXPENSE_MODE );
			else
				Alert.show(TransactionGlobeMessages.DATAGRID_ITEM_NOT_SELECTED, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Get confirmation to delete donation details.
		 */		
		public function confirmDeleteDonationDetails() : void
		{
			if ( _view.dg_donationdetails.selectedItem != null )
				Alert.show(TransactionGlobeMessages.CONFIRM_DELETE_EXPENSE_DETAILS, GlobalConstants.ALERT_TITLE_CONFIRMATION, Alert.YES | Alert.NO, null, deleteDonationDetail);
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
		 * Show Add/Edit donation popup.
		 */
		private function showAddEditDonationPopup( viewMode : String ) : void
		{
			/* var popup : AddEditExpenses = AddEditExpenses(PopUpManager.createPopUp(DisplayObject(FlexGlobals.topLevelApplication), AddEditExpenses, true));
			
			popup.addEditExpenseHelper.viewMode = viewMode;
			popup.addEditExpenseHelper.expFilterVO = getExpFilterVO();
			
			// If the popup opened in "Edit" mode, then keep the edited member details in collection.
			if ( viewMode == TransactionGlobeConstants.EDIT_EXPENSE_MODE )
			{
				model.collEditableExpenseDetail.removeAll();
				model.collEditableExpenseDetail.addItem( _view.dg_dailyexpensedetails.selectedItem as DailyExpenseVO );
			}
			
			PopUpManager.centerPopUp(popup); */
		}
		
		/**
		 * Get filters to load donation details. 
		 * @return 
		 * 
		 */		
		private function getDonationFilterVO() : DonationFilterVO
		{
			var filterVO : DonationFilterVO = new DonationFilterVO();
			
			filterVO.fromDate = _fundTrackerUtil.formatDate(_view.filter_comp.fromDate, TransactionGlobeConstants.DATE_FORMAT);
			filterVO.toDate = _fundTrackerUtil.formatDate(_view.filter_comp.toDate, TransactionGlobeConstants.DATE_FORMAT);
			
			return filterVO;
		}
		
		/**
		 * Dispatch event to delete the donation details in DB via remote service call.
		 * @param event
		 * 
		 */		
		private function deleteDonationDetail( event : CloseEvent ) : void
		{
			if ( event.detail == Alert.YES )
			{
				var deleteExpEvent : DonationViewEvent = new DonationViewEvent( DonationViewEvent.DELETE_DONATION_DETAILS );
				
				deleteExpEvent.donationFilterVO = getDonationFilterVO();
				//deleteExpEvent.data = _view.dg_donationdetails.selectedItem as DailyExpenseVO;
				// Dsipatch Delete event to perform remote operations.
				CairngormEventDispatcher.getInstance().dispatchEvent(deleteExpEvent);
			}
		}
	}
}