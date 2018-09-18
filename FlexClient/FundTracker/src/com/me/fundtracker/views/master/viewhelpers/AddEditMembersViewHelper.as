package com.me.fundtracker.views.master.viewhelpers
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.events.master.MembersViewEvent;
	import com.me.fundtracker.model.master.MasterModelLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.master.MasterGlobeConstants;
	import com.me.fundtracker.utils.master.MasterGlobeMessages;
	import com.me.fundtracker.valueobjects.master.MembersVO;
	import com.me.fundtracker.views.master.AddEditMembers;
	import com.me.fundtracker.views.master.Members;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	public class AddEditMembersViewHelper extends ViewHelper
	{		
		/**
		 * Holds the instance of model. 
		 */
		[Bindable]
		public var model : MasterModelLocator = MasterModelLocator.getInstance();
		
		/**
		 * Determines weather popup opened as "Add / Edit".
		 */		
		private var _viewMode : String;
		
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		private var _view : AddEditMembers;
		
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
			_view = AddEditMembers(view);
			_view.txt_firstname.setFocus();
			
			// Reset the collection if the popup opened in add mode.
			if( viewMode == MasterGlobeConstants.ADD_MEMBER_MODE )
			{
				model.collEditableMembersDetail = new ArrayCollection();
			}	
			else // In edit mode, we disabled the datagrid, where we won't allow to perform eny operation in datagrid.
			{
				_view.btn_add.enabled = false;
				_view.btn_delete.enabled = false;
				_view.dg_activeitems.enabled = false;
				
				if ( model.collEditableMembersDetail.length > 0 )
					setMemberAttributeValues( model.collEditableMembersDetail[0] as MembersVO );
			}	
		}
		
		/**
		 * Add the new member details and the details kept in temprorary collection. 
		 * The newly added details will update to DB once hit the Save button.
		 */		
		public function addMemberDetails() : void
		{
			//Check weather having valid data.
			if ( validateIsEmpty() )
				addAffectedMembersToCollection();
		}
		
		/**
		 * Dispatch event to update the member details to DB via remote service call.
		 */		
		public function saveMemberDetails() : void
		{
			var event : MembersViewEvent;
			var isValid : Boolean = false;
			
			// Allow user to Call validate method & dispatch event weather the grid having item with Add mode or edit mode.
			if ( viewMode == MasterGlobeConstants.ADD_MEMBER_MODE && checkAllAttributesEmpty() && model.collEditableMembersDetail.length > 0 )
				isValid = true;
			// Validate member attributes, if any of them updated, (i.e) attributes noe empty.
			else if ( viewMode == MasterGlobeConstants.ADD_MEMBER_MODE && !checkAllAttributesEmpty() )
			{
				isValid = validateIsEmpty();
				// If all attributes are valid, then we should be added into the collection.
				if ( isValid )
					addAffectedMembersToCollection(); //Get the member details.
			}				
			else
				isValid = validateIsEmpty();
			
			// Dispatch event if member attributes having valid details.
			if ( isValid )
			{
				if ( viewMode == MasterGlobeConstants.ADD_MEMBER_MODE )
					event = new MembersViewEvent(MembersViewEvent.INSERT_MEMBER_DETAIL);
				else
				{
					//Get edited details from the respective attributes.
					getAffectedMemberDetails( model.collEditableMembersDetail[0] as MembersVO );
					event = new MembersViewEvent(MembersViewEvent.UPDATE_MEMBER_DETAIL);
				}				
				
				event.collMembersDetail = model.collEditableMembersDetail;
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
				var index : int = model.collEditableMembersDetail.getItemIndex( _view.dg_activeitems.selectedItem );
				model.collEditableMembersDetail.removeItemAt( index );
			}
			else
				Alert.show(MasterGlobeMessages.ITEM_NOT_SELETED_IN_DATAGRID, GlobalConstants.ALERT_TITLE_INFO);
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
		 * Add the affected member details to collection.
		 */		
		private function addAffectedMembersToCollection() : void
		{
			var memberVO : MembersVO = new MembersVO();
			
			getAffectedMemberDetails( memberVO );
			model.collEditableMembersDetail.addItem( memberVO );
			_view.dg_activeitems.selectedItem = memberVO;
				
			// Reset textinput values only if popup view mode is ADD MODE..
			resetValues();
		}
		
		/**
		 * Get the affected data and construct as MemberVO object. 
		 * @param memberVO
		 */		
		private function getAffectedMemberDetails( memberVO : MembersVO ) : void
		{
			memberVO.firstName = _view.txt_firstname.text;
			memberVO.lastName = _view.txt_lastname.text;
			memberVO.nickName = _view.txt_nickname.text;
			memberVO.gender = ((_view.rbtn_male.selected) ? MasterGlobeConstants.GENDER_MALE : MasterGlobeConstants.GENDER_FEMALE );
			memberVO.address = _view.txt_address.text;
			memberVO.city = _view.txt_city.text;
			memberVO.pincode = _view.txt_pincode.text;
			memberVO.telephoneNo = _view.txt_areacode.text + "-" + _view.txt_phoneno.text;
			memberVO.mobileNo = _view.txt_mobileno.text;
			memberVO.active = (( _view.chk_active.selected ) ? 1 : 0 );
		}
		
		/**
		 * Set the member details to its respective textinput control. 
		 * @param memberVO
		 */		
		private function setMemberAttributeValues( memberVO : MembersVO ) : void
		{
			_view.txt_firstname.text = memberVO.firstName;
			_view.txt_lastname.text = memberVO.lastName;
			_view.txt_nickname.text = memberVO.nickName;
			((memberVO.gender = MasterGlobeConstants.GENDER_MALE ) ? _view.rbtn_male.selected = true : _view.rbtn_male.selected = false );
			((memberVO.gender = MasterGlobeConstants.GENDER_FEMALE ) ? _view.rbtn_female.selected = true : _view.rbtn_female.selected = false );
			_view.txt_address.text = memberVO.address;
			_view.txt_city.text = memberVO.city;
			_view.txt_pincode.text = memberVO.pincode;
			_view.txt_mobileno.text = memberVO.mobileNo;
			_view.chk_active.selected = (( memberVO.active == 1 ) ? true : false );
			
			// Split the telephone as Area Code & Phone No.
			if ( memberVO.telephoneNo != "" && memberVO.telephoneNo != null )
			{
				var arrTeleNo : Array = memberVO.telephoneNo.split( MasterGlobeConstants.TELEPHONE_DELIMETER )
				_view.txt_areacode.text = arrTeleNo[0];
				_view.txt_phoneno.text = arrTeleNo[1];
			}
		}
		
		/**
		 * Check weather all attributes are empty or not. 
		 * @return 
		 */		
		private function checkAllAttributesEmpty() : Boolean
		{
			var isAllEmpty : Boolean;
			
			isAllEmpty = ((_view.txt_firstname.text == "") && (_view.txt_lastname.text == "") && (_view.txt_nickname.text == "") && (_view.rbtn_male.selected == true)
						 && (_view.txt_address.text == "") && (_view.txt_city.text == "") && (_view.txt_pincode.text == "") && (_view.txt_mobileno.text == "") && (_view.chk_active.selected == true));
				
			return isAllEmpty;
		}
		
		/**
		 * Validate the input values
		 */		
		private function validateIsEmpty() : Boolean
		{
			var isValid : Boolean = true;
			
			if( StringUtil.trim(_view.txt_firstname.text) == "" )
			{
				isValid = false;
				_view.txt_firstname.setFocus();
				Alert.show( MasterGlobeMessages.FIRST_NAME_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			else if( StringUtil.trim(_view.txt_nickname.text) == "" )
			{
				isValid = false;
				_view.txt_nickname.setFocus();
				Alert.show( MasterGlobeMessages.NICK_NAME_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			else if( StringUtil.trim(_view.txt_mobileno.text) == "" )
			{
				isValid = false;
				_view.txt_mobileno.setFocus();
				Alert.show( MasterGlobeMessages.MOBILE_NO_EMPTY, GlobalConstants.ALERT_TITLE_INFO );
			}
			else if( StringUtil.trim(_view.txt_mobileno.text).length != 10 )
			{
				isValid = false;
				_view.txt_mobileno.setFocus();
				Alert.show( MasterGlobeMessages.INVALID_MOBILE_NO, GlobalConstants.ALERT_TITLE_INFO );
			}
			
			return isValid;
		}
		
		/**
		 * Reset all member attributes.
		 */		
		private function resetValues() : void
		{
			_view.txt_firstname.text = "";
			_view.txt_firstname.setFocus();
			_view.txt_lastname.text = "";
			_view.txt_nickname.text = "";
			_view.rbtn_male.selected = true;
			_view.rbtn_female.selected = false;
			_view.txt_address.text = "";
			_view.txt_city.text = "";
			_view.txt_pincode.text = "";
			_view.txt_areacode.text = "";
			_view.txt_phoneno.text = "";
			_view.txt_mobileno.text = "";
			_view.chk_active.selected = true;
		}
	}
}