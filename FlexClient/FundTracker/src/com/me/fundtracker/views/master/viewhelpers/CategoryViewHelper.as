package com.me.fundtracker.views.master.viewhelpers
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.components.GenericCheckbox;
	import com.me.fundtracker.events.master.CategoryEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.master.MasterGlobeConstants;
	import com.me.fundtracker.utils.master.MasterGlobeMessages;
	import com.me.fundtracker.valueobjects.master.CategoryGroupVO;
	import com.me.fundtracker.valueobjects.master.CategoryVO;
	import com.me.fundtracker.views.master.Category;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.utils.StringUtil;
	
	import spark.components.gridClasses.GridColumn;
	
	public class CategoryViewHelper extends ViewHelper
	{
		/**
		 * Holds the instance of model. 
		 */
		[Bindable]
		public var model : MasterModelLocator = MasterModelLocator.getInstance();
		
		/**
		 * Add / Edit mode
		 */
		[Bindable]
		public var viewMode : String = "";
		
		/**
		 * Holds the instance of model. 
		 */
		private var _fundTrackerModel : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		public var _view : Category;
		

		/**
		 * Constructor
		 */
		public function CategoryViewHelper()
		{
			super();
		}
		
		/**
		 * On initialize.
		 */		
		public function onInit() : void
		{
			_view = Category(view);
			
			_fundTrackerModel.fundTrackerEventDispatcher.addEventListener(CategoryEvent.CATEGORY_AND_ACCOUNT_GROUPS_LOADED, createDynamicCategoryGroups);
		}
		
		/**
		 * Call remote service to get the all category details list. 
		 */		
		public function getAllCategoryAndAccountGroups() : void
		{
			var event : CategoryEvent = new CategoryEvent(CategoryEvent.GET_ALL_CATEGORY_AND_ACCOUNT_GROUPS_DETAIL);
			
			CairngormEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		/**
		 * Add category.
		 */		
		public function addNewCategoryDetails() : void
		{
			resetInputValues();
			addEditExpCategory( MasterGlobeConstants.ADD_EXP_CATEGORY_MODE );
			_view.txt_description.setFocus();
		}
		
		/**
		 * Save Expense category details & retains same view(Add view).
		 */		
		public function saveCategoryDetails() : void
		{
			//Check weather all textfields having valid data.
			if ( validateInputValues() )
			{
				var event : CategoryEvent;
				var categoryVO : CategoryVO = new CategoryVO();
				
				categoryVO.accountGroupKey = getSelectedAccountGroupKeys();
				categoryVO.description = _view.txt_description.text;
				categoryVO.defaultAccountType = _view.rg_defult.selectedValue + "";
				
				// Add category ID, if view mode is in edit mode.
				if ( viewMode ==  MasterGlobeConstants.EDIT_EXP_CATEGORY_MODE )
				{
					categoryVO.categoryID = _view.dg_expensecategory.selectedItem.categoryID;
					event = new CategoryEvent( CategoryEvent.UPDATE_CATEGORY_DETAILS, categoryVO );
				}
				else
				{
					event = new CategoryEvent( CategoryEvent.INSERT_CATEGORY_DETAILS, categoryVO );
				}
				
				// Dsipatch Add / Edit event to perform remote operations.
				CairngormEventDispatcher.getInstance().dispatchEvent(event);
			}
		}
		
		/**
		 * Save Expense category details & switch to search view.
		 */		
		public function saveCategory() : void
		{
			saveCategoryDetails();
			showSearchView();
		}
		
		/**
		 * Edit category.
		 */	
		public function editCategoryDetails() : void
		{
			if ( _view.dg_expensecategory.selectedItem != null )
				addEditExpCategory( MasterGlobeConstants.EDIT_EXP_CATEGORY_MODE );
			else
				Alert.show(MasterGlobeMessages.DATAGRID_ITEM_NOT_SELECTED, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Get confirmation to delete member details.
		 */		
		public function confirmDeleteExpenseCategory() : void
		{
			if ( _view.dg_expensecategory.selectedItem != null )
				Alert.show(MasterGlobeMessages.CONFIRM_DELETE_EXPENSE_CATEGORY_DETAILS, GlobalConstants.ALERT_TITLE_CONFIRMATION, Alert.YES | Alert.NO, null, deleteExpenseCategory);
			else
				Alert.show(MasterGlobeMessages.NO_ITEM_TO_DELETE, GlobalConstants.ALERT_TITLE_INFO);
		}
		
		/**
		 * Show the search component.
		 */		
		public function showSearchView() : void
		{
			_view.categoryViewStack.selectedIndex = MasterGlobeConstants.SEARCH_CATEGORY_VIEW;
		}
		
		/**
		 * Label function for Group Name datagrid column. 
		 * @param item
		 * @param column
		 * @return 
		 * 
		 */		
		public function groupNameLabelFunction( item : Object, column : GridColumn ) : String
		{
			var categoryItem : CategoryVO = item as CategoryVO;
			var groupName : String = "";
			
			if ( categoryItem.accountGroupKey.indexOf(MasterGlobeConstants.GROUP_KEY_DELIMETER) == -1 )
				groupName = categoryItem.accountGroupName;
			else
				groupName = categoryItem.accountGroupName + " - " + categoryItem.accountGroupKey;
			
			return groupName;
		}
		
		/**
		 * Show the home page.
		 */		
		public function showHomePage() : void
		{
			_fundTrackerModel.NAVIGATIONAL_CONTAINER.removeAllElements();
			_fundTrackerModel.CURRENT_VIEW = GlobalConstants.HOME_VIEW;
		}
		
		/**
		 * Reset the input values
		 */		
		public function resetInputValues() : void
		{
			resetAccountGroupCheckboxes();
			_view.txt_description.text = "";
			_view.rg_defult.selectedValue = MasterGlobeConstants.DEFAULT_TYPE_DEBIT;
			_view.txt_description.setFocus();
		}
		
		
		// -------------------------------------------------------------------------------------------------------------------------
		//											Private Methods Definition
		// -------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * Create dynamic checkbox groups. 
		 * @param event
		 * 
		 */		
		private function createDynamicCategoryGroups( event:CategoryEvent ) : void
		{
			var groupCheckbox : GenericCheckbox;
			_view.hgrpGroupCheckboxContainer.removeAllElements();
			model.collCategoryGrpCheckboxInstance.removeAll();
			
			for each ( var item : CategoryGroupVO in model.collAccountGroups )
			{
				groupCheckbox = new GenericCheckbox();
				groupCheckbox.label = item.groupName;
				groupCheckbox.data = item.groupKey;
				
				_view.hgrpGroupCheckboxContainer.addElement(groupCheckbox);
				model.collCategoryGrpCheckboxInstance.addItem(groupCheckbox);
			}
		}
		
		
		/**
		 * Show Add/Edit category types.
		 */
		private function addEditExpCategory( mode : String ) : void
		{
			viewMode = mode;
			_view.categoryViewStack.selectedIndex = MasterGlobeConstants.ADD_EXP_CATEGORY_VIEW;
			
			// Assign the editedable values to its respective component, if the mode is "Edit".
			if ( viewMode == MasterGlobeConstants.EDIT_EXP_CATEGORY_MODE )
			{
				var categoryVO : CategoryVO = _view.dg_expensecategory.selectedItem as CategoryVO
					
				resetAccountGroupCheckboxes();
				setSelectedAccountGroup( categoryVO.accountGroupKey );
				_view.txt_description.text = categoryVO.description;
				_view.rg_defult.selectedValue = categoryVO.defaultAccountType;
			}
		}
		/**
		 *  Get the selected account group item.
		 * @param groupName
		 * @return 
		 * 
		 */
		private function setSelectedAccountGroup( groupKey : String ) : void
		{
			var arrGroupItem : Array = groupKey.split(MasterGlobeConstants.GROUP_KEY_DELIMETER);
			
			for each ( var accGroupItem : String in arrGroupItem )
			{
				for each ( var chkGroup : GenericCheckbox in model.collCategoryGrpCheckboxInstance )
				{
					if ( String(chkGroup.data).toUpperCase() == accGroupItem.toUpperCase() )
					{
						chkGroup.selected = true;
						break;
					}
				}
			}
		}
		
		/**
		 * Validate the input values
		 */		
		private function validateInputValues() : Boolean
		{
			var isValid : Boolean = true;
			
			if( getSelectedAccountGroupKeys() == "" )
			{
				isValid = false;
				Alert.show( MasterGlobeMessages.CATEGORY_GROUP_NOT_SELECTED, GlobalConstants.ALERT_TITLE_INFO );
			}			
			else if( StringUtil.trim(_view.txt_description.text) == "" )
			{
				isValid = false;
				_view.txt_description.setFocus();
				Alert.show( MasterGlobeMessages.CATEGORY_NAME_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			
			return isValid;
		}
		
		private function resetAccountGroupCheckboxes() : void
		{
			for each ( var chkGroup : GenericCheckbox in model.collCategoryGrpCheckboxInstance )
				chkGroup.selected = false;
		}
		
		/**
		 * Get selected group key 
		 * @return 
		 * 
		 */		
		private function getSelectedAccountGroupKeys() : String
		{
			var selectedKey : String = "";
			
			for each ( var chkGroup : GenericCheckbox in model.collCategoryGrpCheckboxInstance )
			{
				if ( chkGroup.selected )
				{
					if ( selectedKey == "" )							
						selectedKey = String(chkGroup.data);
					else
						selectedKey = selectedKey + MasterGlobeConstants.GROUP_KEY_DELIMETER + String(chkGroup.data);
				}
			}
			
			return selectedKey;
		}
		
		/**
		 * Delete Expense category details & switch to search view.
		 * @param event
		 * 
		 */		
		private function deleteExpenseCategory( event : CloseEvent ) : void
		{
			if ( event.detail == Alert.YES )
			{
				var categoryVO : CategoryVO = _view.dg_expensecategory.selectedItem as CategoryVO;
				var categoryevent : CategoryEvent = new CategoryEvent( CategoryEvent.DELETE_CATEGORY_DETAILS, categoryVO );
				
				// Dsipatch Delete event to perform remote operations.
				CairngormEventDispatcher.getInstance().dispatchEvent(categoryevent);
			}
			else
			{
				Alert.show(MasterGlobeMessages.NO_ITEM_TO_DELETE, GlobalConstants.ALERT_TITLE_INFO);
			}
		}
	}
}