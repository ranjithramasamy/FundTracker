package com.me.fundtracker.model.transaction
{
	import com.adobe.cairngorm.model.ModelLocator;
	import com.me.fundtracker.valueobjects.transaction.DailyExpenseVO;
	import com.me.fundtracker.valueobjects.transaction.DonationVO;
	
	import mx.collections.ArrayCollection;
	
	[Bindable]
	public class TransactionModelLocator implements ModelLocator
	{
		/**
		 * Static - holds the instance of this class. 
		 */		
		private static var _instance : TransactionModelLocator;
		
		/**
		 * Constructor 
		 * @param enforcer
		 * 
		 */		
		public function TransactionModelLocator( enforcer : SingletonEnforcer ) 
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
		public static function getInstance() : TransactionModelLocator 
		{
			if ( _instance == null )
				_instance = new TransactionModelLocator( new SingletonEnforcer() );
			
			return _instance;
		}
		
		// -----------------------------------------------------------------------------------------------------------------------------------------
		//							Public member variable declarations for Daily Expenses and its child pages.
		// -----------------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * Flex Datagrid datasource which holds the collection of DailyExpensesVO objects for Expenses.mxml page.
		 */	
		public var collDailyExpenseDetails:ArrayCollection = new ArrayCollection();
		
		/**
		 * Flex Datagrid datasource which holds the collection of DailyExpensesVO objects for AddEditExpenses.mxml page.
		 */	
		public var collEditableExpenseDetail:ArrayCollection = new ArrayCollection();
		
		/**
		 * Have the Expense category details where the collection assigned to Expense Types Combobox in AddEditExpenses Popup.
		 */	
		public var collExpensTypes:ArrayCollection = new ArrayCollection();
		
		/**
		 * Set the selected index for daily expenses list datagrid.
		 */		
		public var dailyExpenseGridSelectedItem : DailyExpenseVO;
		
		
		// -----------------------------------------------------------------------------------------------------------------------------------------
		//							Public member variable declarations for Donation and its child pages.
		// -----------------------------------------------------------------------------------------------------------------------------------------
		
		/**
		 * Flex Datagrid datasource which holds the collection of DonationVO objects for Donation.mxml page.
		 */	
		public var collAllDonationDetails:ArrayCollection = new ArrayCollection();
		
		/**
		 * Flex Datagrid datasource which holds the collection of DonationVO objects for AddEditDonation.mxml page.
		 */	
		public var collEditableDonationDetail:ArrayCollection = new ArrayCollection();
		
		/**
		 * Have the donation category details where the collection assigned to Donation Category Combobox in AddEditDonation Popup.
		 */	
		public var collDonationCategory:ArrayCollection = new ArrayCollection();
		
		/**
		 * Set the selected index for donation list datagrid.
		 */		
		public var donationGridSelectedItem : DonationVO;
	}
}


// -----------------------------------------------------------------------------------------------------------------------------------------
//					Internal class which is accessed by current class itself that are enforcing the strict Singleton model
// -----------------------------------------------------------------------------------------------------------------------------------------

class SingletonEnforcer {}