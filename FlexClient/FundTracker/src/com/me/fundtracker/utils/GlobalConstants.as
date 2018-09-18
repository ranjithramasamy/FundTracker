package com.me.fundtracker.utils
{
	import mx.collections.ArrayCollection;

	public class GlobalConstants
	{
		// -----------------------------------------------------------------------------------------------
		//							Login Page Configurations
		// -----------------------------------------------------------------------------------------------
		
		public static const LOGIN_VIEW : int = 0;
		
		public static const HOME_VIEW : int = 1;
		
		public static const NAVIGATIONAL_VIEW : int = 2;
		
		public static const ALERT_TITLE_ERROR : String = "Error";
		
		public static const ALERT_TITLE_INFO : String = "Information";
		
		public static const ALERT_TITLE_SERVICE_FAULT : String = "Service Fault";
		
		public static const ALERT_TITLE_CONFIRMATION : String = "Confirmation";
		
		// -----------------------------------------------------------------------------------------------
		//							Home Page Configurations
		// -----------------------------------------------------------------------------------------------
		
		public static const MENU_LIST_LABEL_FIELD : String = "label";
		
		// -----------------------------------------------------------------------------------------------
		//							Remoteobject - Services
		// -----------------------------------------------------------------------------------------------
		
		public static const FUND_TRACKER_REMOTE_SERVICE_NAME : String = "fundTrackerRemoteObject";
		
		
		// -----------------------------------------------------------------------------------------------
		//							Pop Menu List Event Types - Home Page
		// -----------------------------------------------------------------------------------------------
		
		public static const APP_EXIT : String = "exit";
		
		public static const DAILY_EXPENSE_ENTRY_VIEW : String = "dailyexpense";
		
		public static const AUCTION_DETAIL_VIEW : String = "auction";
		
		public static const MEMBER_MANAGEMENT_VIEW : String = "member";
		
		public static const DONATION_VIEW : String = "donation";
		
		public static const FUND_ISSUE_VIEW : String = "fundissue";
		
		public static const FUND_VIEW : String = "fund";
		
		public static const BALANCE_SHEET_VIEW : String = "balancesheet";
		
		public static const AUCTION_REPORT_VIEW : String = "auctionreport";
		
		public static const EXPENSE_CATEGORY_VIEW : String = "expenditurecategory";
		
		public static const BALANCE_TRANSFER_VIEW : String = "balancetransfer";
		
		public static const OPENNING_BALANCE_VIEW : String = "openningbalance";
		
		
		// -----------------------------------------------------------------------------------------------
		//							Menu List Items - Home Page
		// -----------------------------------------------------------------------------------------------
		public static const MENU_LIST : ArrayCollection = new ArrayCollection([
						{ title: "Transaction", leaf: false, list: [ { label: "Expenditure", data: "Expenditure", eventType: DAILY_EXPENSE_ENTRY_VIEW },
														{ label: "Auction  Detail", data: "Auction  Detail", eventType: AUCTION_DETAIL_VIEW },
														{ label: "Donation Detail", data: "Donation Detail", eventType: DONATION_VIEW }]},
						
						{ title: "Funds", leaf: false, list: [ { label: "Fund Issue", data: "Fund Issue", eventType: FUND_ISSUE_VIEW },
												  { label: "Fund", data: "Fund", eventType: FUND_VIEW }]},
						
						{ title: "Reports", leaf: false, list: [ { label: "Balance Sheet", data: "Balance Sheet", eventType: BALANCE_SHEET_VIEW },
												    { label: "Auction Report", data: "Auction Report", eventType: AUCTION_REPORT_VIEW }]},
						
						{ title: "Master", leaf: false, list: [ { label: "Member Management", data: "Member Management", eventType: MEMBER_MANAGEMENT_VIEW },
												   { label: "Expenditure Category", data: "Expenditure Category", eventType: EXPENSE_CATEGORY_VIEW }]},
						
						{ title: "Admin", leaf: false, list: [ { label: "Balance Transfer", data: "Balance Transfer", eventType: BALANCE_TRANSFER_VIEW },
												   { label: "Openning Balance", data: "Openning Balance", eventType: OPENNING_BALANCE_VIEW }]},
						{ title: "Exit", leaf: true, list: []}
						
					]);
	}
}