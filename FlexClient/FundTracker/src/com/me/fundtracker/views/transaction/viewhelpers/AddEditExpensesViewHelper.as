package com.me.fundtracker.views.transaction.viewhelpers
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.events.transaction.ExpenseViewEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.master.MasterGlobeMessages;
	import com.me.fundtracker.utils.transaction.TransactionGlobeConstants;
	import com.me.fundtracker.utils.transaction.TransactionGlobeMessages;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
	import com.me.fundtracker.valueobjects.transaction.ExpenseFilterVO;
	import com.me.fundtracker.valueobjects.transaction.ExpenseTypesVO;
	import com.me.fundtracker.views.transaction.AddEditExpenses;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.DateField;
	import mx.managers.PopUpManager;
	import mx.utils.ObjectUtil;
	import mx.utils.StringUtil;
	
	public class AddEditExpensesViewHelper extends ViewHelper
	{		
		/**
		 * Holds the instance of fundtracker util. 
		 */
		private var _fundTrackerUtil : FundTrackerUtil = FundTrackerUtil.getInstance();
		
		/**
		 * Holds the instance of model. 
		 */
		[Bindable]
		public var model : TransactionModelLocator = TransactionModelLocator.getInstance();
		
		/**
		 * Expense Filter VO. 
		 */
		public var expFilterVO : ExpenseFilterVO;
		
		/**
		 * Holds the instance of model. 
		 */
		private var _fundTrackerModel : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Determines weather popup opened as "Add / Edit".
		 */		
		private var _viewMode : String;
		
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		private var _view : AddEditExpenses;
		
		/**
		 * Setter 
		 * @param value
		 * 
		 */		
		[Bindable]
		public function set viewMode( value : String ) : void{
			_viewMode = value;
		}
		
		/**
		 * Getter 
		 * @return 
		 * 
		 */		
		public function get viewMode() : String{
			return _viewMode;
		}
		
		/**
		 * On initialize handler.
		 */
		public function onComplete() : void
		{
			_view = AddEditExpenses(view);
			_view.cmb_expense_type.setFocus();			
			_fundTrackerModel.fundTrackerEventDispatcher.addEventListener(ExpenseViewEvent.EXPENSE_CATEGORY_LIST_LOADED, setDailyExpenseAttributeValues);
			getExpenseTypesList();
			
			// Reset the collection if the popup opened in add mode.
			if( viewMode == TransactionGlobeConstants.ADD_EXPENSE_MODE )
			{
				model.collEditableExpenseDetail = new ArrayCollection();
			}	
			else // In edit mode, we disabled the datagrid, where we won't allow to perform any operation in datagrid.
			{
				_view.btn_add.enabled = false;
				_view.btn_delete.enabled = false;
				_view.dg_activeitems.enabled = false;
			}	
		}
		
		/**
		 * Add the new exepenses details and the details kept in temprorary collection. 
		 * The newly added details will update to DB once hit the Save button.
		 */		
		public function addDailyExpenseDetails() : void
		{
			//Check weather all inputs having a valid data.
			if ( validateIsEmpty() )
				addAffectedDailyExpensesToCollection();
		}
		
		/**
		 * Dispatch event to update the member details to DB via remote service call.
		 */		
		public function saveDailyExpenseDetails() : void
		{
			var event : ExpenseViewEvent;
			var isValid : Boolean = false;
			
			// Allow user to Call validate method & dispatch event weather the grid having item with Add mode or edit mode.
			if ( viewMode == TransactionGlobeConstants.ADD_EXPENSE_MODE && checkAllAttributesEmpty() && model.collEditableExpenseDetail.length > 0 )
				isValid = true;
			// Validate member attributes, if any of them updated, (i.e) attributes not empty.
			else if ( viewMode == TransactionGlobeConstants.ADD_EXPENSE_MODE && !checkAllAttributesEmpty() )
			{
				isValid = validateIsEmpty();
				// If all attributes are valid, then we should be added into the collection.
				if ( isValid )
					addAffectedDailyExpensesToCollection(); //Get the member details.
			}				
			else
				isValid = validateIsEmpty();
			
			// Dispatch event if member attributes having valid details.
			if ( isValid )
			{
				if ( viewMode == TransactionGlobeConstants.ADD_EXPENSE_MODE )
					event = new ExpenseViewEvent(ExpenseViewEvent.INSERT_DAILY_EXPENSE_DETAILS);
				else
				{
					//Get edited details from the respective attributes.
					getAffectedExpenseDetails( model.collEditableExpenseDetail[0] as DailyExpenseVO );
					event = new ExpenseViewEvent(ExpenseViewEvent.UPDATE_DAILY_EXPENSE_DETAILS);
				}
				
				event.expenseFilterVO = expFilterVO;
				event.collDailyExpenseDetail = model.collEditableExpenseDetail;
				CairngormEventDispatcher.getInstance().dispatchEvent(event);
			}
		}
		
		/**
		 * Dispatch event to update the member details to DB via remote service call.
		 */		
		public function deleteSelectedItemFromCollection() : void
		{
			if ( _view.dg_activeitems.selectedItem != null )
			{
				var index : int = model.collEditableExpenseDetail.getItemIndex( _view.dg_activeitems.selectedItem );
				model.collEditableExpenseDetail.removeItemAt( index );
			}
			else
				Alert.show(TransactionGlobeMessages.ITEM_NOT_SELETED_IN_DATAGRID, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Close the popup.
		 */
		public function closePopup() : void
		{
			if ( _view != null )
				PopUpManager.removePopUp(_view);
		}
		
		
		// -------------------------------------------------------------------------------------------------------------------------
		//											Private Methods Definition
		// -------------------------------------------------------------------------------------------------------------------------
		/**
		 * Load the available Expense type list. 
		 * 
		 */		
		private function getExpenseTypesList() : void
		{
			var expenseTypeListEvent : ExpenseViewEvent = new ExpenseViewEvent( ExpenseViewEvent.GET_ALL_EXPENSE_CATEGORY_LIST );
			
			CairngormEventDispatcher.getInstance().dispatchEvent(expenseTypeListEvent);
		}
		
		/**
		 * Add the affected expense details to collection.
		 */		
		private function addAffectedDailyExpensesToCollection() : void
		{
			var dailyExpVO : DailyExpenseVO = new DailyExpenseVO();
			
			getAffectedExpenseDetails( dailyExpVO );
			model.collEditableExpenseDetail.addItem( dailyExpVO );
			_view.dg_activeitems.selectedItem = dailyExpVO;
				
			// Reset textinput values only if popup view mode is ADD MODE..
			resetValues();
		}
		
		/**
		 * Get the affected data and construct as dailyExpVO object. 
		 * @param dailyExpVO
		 */		
		private function getAffectedExpenseDetails( dailyExpVO : DailyExpenseVO ) : void
		{
			var expTypesVO : ExpenseTypesVO = _view.cmb_expense_type.selectedItem as ExpenseTypesVO;
			
			dailyExpVO.date = _fundTrackerUtil.formatDate(_view.expense_date.selectedDate, TransactionGlobeConstants.DATE_FORMAT);
			dailyExpVO.expCategoryID = expTypesVO.expCategoryID;
			dailyExpVO.expCategoryType = expTypesVO.expCategoryType;
			dailyExpVO.narration = _view.txt_narration.text;
			dailyExpVO.amount = _view.txt_amount.text;
		}
		
		/**
		 * Set the expense details to its respective textinput control. 
		 * @param event
		 */		
		private function setDailyExpenseAttributeValues( event : ExpenseViewEvent ) : void
		{
			_fundTrackerModel.fundTrackerEventDispatcher.removeEventListener(ExpenseViewEvent.EXPENSE_CATEGORY_LIST_LOADED, setDailyExpenseAttributeValues);
			
			if ( model.collEditableExpenseDetail.length > 0 )
			{
				var dailyExpVO : DailyExpenseVO = model.collEditableExpenseDetail[0] as DailyExpenseVO;
				var selectedDate : Date = _fundTrackerUtil.convertDateStringToDate(dailyExpVO.date, TransactionGlobeConstants.DATE_FORMAT);
				var listSelectedItem : ExpenseTypesVO = getSelectedItem( dailyExpVO.expCategoryID );
				
				_view.expense_date.selectedDate = selectedDate;
				_view.cmb_expense_type.selectedItem = listSelectedItem;
				_view.txt_narration.text = dailyExpVO.narration;
				_view.txt_amount.text = dailyExpVO.amount;
			}
		}
		
		/**
		 * Get the selected item for expense types. 
		 * @param expCategoryID
		 * @return 
		 * 
		 */		
		private function getSelectedItem( expCategoryID : int ) : ExpenseTypesVO
		{
			var selectedItem : ExpenseTypesVO;
			
			for each ( var item : ExpenseTypesVO in model.collExpensTypes )
			{
				if( item.expCategoryID == expCategoryID )
				{
					selectedItem = item;
					break;
				}
			}
			
			return selectedItem;
		}
		
		/**
		 * Check weather all attributes are empty or not. 
		 * @return 
		 */		
		private function checkAllAttributesEmpty() : Boolean
		{
			var isAllEmpty : Boolean;
			
			isAllEmpty = (( _view.expense_date.selectedDate == null ) && ( _view.cmb_expense_type.selectedItem == null ) && ( _view.txt_amount.text == "" ));
				
			return isAllEmpty;
		}
		
		/**
		 * Validate the input values
		 */		
		private function validateIsEmpty() : Boolean
		{
			var isValid : Boolean = true;
			
			if( _view.expense_date.selectedDate == null )
			{
				isValid = false;
				Alert.show( TransactionGlobeMessages.EXPENSE_DATE_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			else if( _view.cmb_expense_type.selectedItem == null )
			{
				isValid = false;
				Alert.show( TransactionGlobeMessages.EXPENSE_TYPE_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			else if( StringUtil.trim(_view.txt_amount.text) == "" )
			{
				isValid = false;
				_view.txt_amount.setFocus();
				Alert.show( TransactionGlobeMessages.AMOUNT_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			
			return isValid;
		}
		
		/**
		 * Reset all expense attributes.
		 */		
		private function resetValues() : void
		{
			_view.expense_date.selectedDate = null;
			_view.cmb_expense_type.selectedIndex = -1;
			_view.txt_narration.text = "";
			_view.txt_amount.text = "";
		}
	}
}