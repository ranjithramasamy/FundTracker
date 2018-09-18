package com.me.fundtracker.model
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.me.fundtracker.dispatcher.FundTrackerEventDispatcher;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.LoginVO;
	import com.me.fundtracker.views.master.Category;
	import com.me.fundtracker.views.master.Members;
	import com.me.fundtracker.views.transaction.Donation;
	import com.me.fundtracker.views.transaction.Expenses;
	
	import mx.core.IVisualElementContainer;
	
	[Bindable]
	public class FundTrackerModelLocator implements ModelLocator
	{
		/**
		 * Static - holds the instance of this class. 
		 */		
		private static var _instance : FundTrackerModelLocator;
		
		/**
		 * Constructor 
		 * @param enforcer
		 * 
		 */		
		public function FundTrackerModelLocator( enforcer : SingletonEnforcer ) 
		{
			if (enforcer == null) {
				throw new Error( "You Can Only Have One ModelLocator" );
			}
		}
		
		/**
		 * Creates the new instance if the class not instatiated. Else returns the existing instance..
		 * @return 
		 * 
		 */		
		public static function getInstance() : FundTrackerModelLocator 
		{
			if ( _instance == null )
				_instance = new FundTrackerModelLocator( new SingletonEnforcer() );
			
			return _instance;
		}
		
		// -----------------------------------------------------------------------------------------------
		//							Public variable declarations
		// -----------------------------------------------------------------------------------------------
		
		public var loginVo : LoginVO;
		
		public var CURRENT_VIEW : int = GlobalConstants.LOGIN_VIEW;
		
		public var isPopMenuOpened : Boolean = false;
		
		public var fundTrackerEventDispatcher : FundTrackerEventDispatcher = new FundTrackerEventDispatcher();
		
		public var NAVIGATIONAL_CONTAINER : IVisualElementContainer = null;
		
		
		// -----------------------------------------------------------------------------------------------
		//									Dynamic view instances
		// -----------------------------------------------------------------------------------------------
		
		public var MEMBER_MANAGEMENT_VIEW_INSTANCE : Members = null;
		
		public var EXPENDITURE_CATEGORY_VIEW_INSTANCE : Category = null;
		
		public var DAILY_EXPENSE_ENTRY_VIEW_INSTANCE : Expenses = null;
		
		public var DONATION_ENTRY_VIEW_INSTANCE : Donation = null;
	}
}

// -----------------------------------------------------------------------------------------------------------------------------------------
//					Internal class which is accessed by current class itself that are enforcing the strict Singleton model
// -----------------------------------------------------------------------------------------------------------------------------------------

class SingletonEnforcer {}