package com.me.fundtracker.utils
{
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.views.master.Category;
	import com.me.fundtracker.views.master.Members;
	import com.me.fundtracker.views.transaction.Donation;
	import com.me.fundtracker.views.transaction.Expenses;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	
	import spark.formatters.DateTimeFormatter;

	public class FundTrackerUtil
	{
		/**
		 * Model instance. 
		 */		
		private var _model : FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Static - holds the instance of this class. 
		 */		
		private static var _instance : FundTrackerUtil;
		
		/**
		 * Instance of DateTimeFormatter 
		 */		
		private var _dateFormatter : DateFormatterWrapper = new DateFormatterWrapper();
		
		/**
		 * Constructor 
		 * @param enforcer
		 * 
		 */		
		public function FundTrackerUtil( enforcer : SingletonEnforcer ) 
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
		public static function getInstance() : FundTrackerUtil 
		{
			if ( _instance == null )
				_instance = new FundTrackerUtil( new SingletonEnforcer() );
			
			return _instance;
		}
		
		/**
		 * Change the different views based on requested page events.  
		 * @param evtType
		 * 
		 */		
		public function changeView( evtType : String ) : void
		{
			switch( evtType ){
				case GlobalConstants.DAILY_EXPENSE_ENTRY_VIEW:
					showDailyExpenseEntryPage();
					break;
				case GlobalConstants.AUCTION_DETAIL_VIEW:
					showDailyExpenseEntryPage();
					break;
				case GlobalConstants.MEMBER_MANAGEMENT_VIEW:
					showMemberMasterPage();
					break;
				case GlobalConstants.EXPENSE_CATEGORY_VIEW:
					showExpenseCategoryPage();
					break;
				case GlobalConstants.DONATION_VIEW:
					showDonationEntryPage();
					break;
			}
		}
		
		/**
		 * Show expenditure view 
		 * 
		 */		
		public function showDailyExpenseEntryPage() : void{
			// Reuse the existing instance across the application with out creating a new instance.
			if ( _model.DAILY_EXPENSE_ENTRY_VIEW_INSTANCE == null )
				_model.DAILY_EXPENSE_ENTRY_VIEW_INSTANCE = new Expenses();
			else
				_model.DAILY_EXPENSE_ENTRY_VIEW_INSTANCE.expenseViewHelper.getAllDailyExpenseDetailsByDate();
			
			_model.NAVIGATIONAL_CONTAINER.addElement(_model.DAILY_EXPENSE_ENTRY_VIEW_INSTANCE);
			_model.CURRENT_VIEW = GlobalConstants.NAVIGATIONAL_VIEW;
		}
		
		/**
		 * Show donation view 
		 * 
		 */		
		public function showDonationEntryPage() : void{
			// Reuse the existing instance across the application with out creating a new instance.
			if ( _model.DONATION_ENTRY_VIEW_INSTANCE == null )
				_model.DONATION_ENTRY_VIEW_INSTANCE = new Donation();
			else
				_model.DONATION_ENTRY_VIEW_INSTANCE.donationViewHelper.getAllDonationDetailsByDate();
			
			_model.NAVIGATIONAL_CONTAINER.addElement(_model.DONATION_ENTRY_VIEW_INSTANCE);
			_model.CURRENT_VIEW = GlobalConstants.NAVIGATIONAL_VIEW;
		}
		
		/**
		 * Shows the member management view. 
		 * 
		 */		
		public function showMemberMasterPage() : void{
			// Reuse the existing instance across the application with out creating a new instance.
			if ( _model.MEMBER_MANAGEMENT_VIEW_INSTANCE == null )
				_model.MEMBER_MANAGEMENT_VIEW_INSTANCE = new Members();
			else
				_model.MEMBER_MANAGEMENT_VIEW_INSTANCE.memberViewHelper.getAllMembers();
			
			_model.NAVIGATIONAL_CONTAINER.addElement(_model.MEMBER_MANAGEMENT_VIEW_INSTANCE);
			_model.CURRENT_VIEW = GlobalConstants.NAVIGATIONAL_VIEW;
		}
		
		/**
		 * Shows the expenditure category view. 
		 * 
		 */		
		public function showExpenseCategoryPage() : void{
			// Reuse the existing instance across the application with out creating a new instance.
			if ( _model.EXPENDITURE_CATEGORY_VIEW_INSTANCE == null )
				_model.EXPENDITURE_CATEGORY_VIEW_INSTANCE = new Category();
			else
				_model.EXPENDITURE_CATEGORY_VIEW_INSTANCE.categoryViewHelper.getAllCategoryAndAccountGroups();
			
			_model.NAVIGATIONAL_CONTAINER.addElement(_model.EXPENDITURE_CATEGORY_VIEW_INSTANCE);
			_model.CURRENT_VIEW = GlobalConstants.NAVIGATIONAL_VIEW;
		}
		
		/**
		 * Fromat the date with given format. 
		 * @param value
		 * @return 
		 * 
		 */		
		public function formatDate( value : Date, pattern : String ) : String
		{			
			_dateFormatter.formatString = pattern;
			
			return _dateFormatter.format(value);
		}
		
		/**
		 * Parse Date string to Date object. 
		 * @param value
		 * @param pattern
		 * @return 
		 * 
		 */		
		public function convertDateStringToDate( value : String, pattern : String ) : Date
		{			
			_dateFormatter.formatString = pattern;
			
			return _dateFormatter.parseDateStringToDate(value);
		}
		
		/**
		 * Prompt the alert to view the remote service fault error message. 
		 * @param info
		 * 
		 */		
		public function handleServiceFaultError( info : Object ) : void
		{
			Alert.show("Fault occured...\n\n" + info.message, GlobalConstants.ALERT_TITLE_SERVICE_FAULT);
		}
	}
}
	
// -----------------------------------------------------------------------------------------------------------------------------------------
//					Internal class which is accessed by current class itself that are enforcing the strict Singleton model
// -----------------------------------------------------------------------------------------------------------------------------------------

class SingletonEnforcer {}
