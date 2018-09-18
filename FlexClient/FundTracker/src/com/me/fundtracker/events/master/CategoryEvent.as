package com.me.fundtracker.events.master
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.valueobjects.master.CategoryVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class CategoryEvent extends CairngormEvent
	{
		/**
		 * Event constants. 
		 */		
		public static const GET_ALL_CATEGORY_AND_ACCOUNT_GROUPS_DETAIL : String = "getallcategoryandaccountgroupsdetail";
		
		public static const CATEGORY_AND_ACCOUNT_GROUPS_LOADED : String = "categoryandaccountgroupsloaded";
		
		public static const INSERT_CATEGORY_DETAILS : String = "insertcategorydetails";
		
		public static const UPDATE_CATEGORY_DETAILS : String = "updatecategorydetails";
		
		public static const DELETE_CATEGORY_DETAILS : String = "deletecategorydetails";
		
		/**
		 * Holds the collection of ExpenseCategoryVO to add / edit their details. 
		 */		
		public var categoryDetailVO : CategoryVO = null;
		
		/**
		 * Constructor 
		 * @param type
		 * @param collMembers
		 * @param bubbles
		 * @param cancelable
		 */		
		public function CategoryEvent(type:String, expCategoryVO:CategoryVO = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.categoryDetailVO = expCategoryVO;
			
			super(type, bubbles, cancelable);
		}
		
		
		/**
		 * Returns a cloned copy of the event object by setting the type property and any new properties in the clone.
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new CategoryEvent( type, categoryDetailVO );
		}
	}
}