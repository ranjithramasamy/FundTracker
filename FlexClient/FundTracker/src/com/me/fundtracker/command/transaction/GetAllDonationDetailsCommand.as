package com.me.fundtracker.command.transaction
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.transaction.DonationViewDelegate;
	import com.me.fundtracker.events.transaction.DonationViewEvent;
	import com.me.fundtracker.model.transaction.TransactionModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.valueobjects.transaction.DonationFilterVO;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;

	public class GetAllDonationDetailsCommand implements IResponder, ICommand
	{
		/**
		 * Holds the instance of model. 
		 */		
		private var _model : TransactionModelLocator = TransactionModelLocator.getInstance();
		
		/**
		 * Holds the instance of Fund Tracker util class. 
		 */		
		private var _fundTrackerUtil : FundTrackerUtil = FundTrackerUtil.getInstance();
		
		/**
		 * Command execution 
		 * @param event
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			var filterVO : DonationFilterVO = DonationViewEvent(event).donationFilterVO;
			var delegate:DonationViewDelegate = new DonationViewDelegate(this);
			
			delegate.getAllDailyExpenseDetailsByDate( filterVO );
		}
		
		/**
		 * Service result handler. 
		 * @param data
		 * 
		 */		
		public function result(data:Object):void
		{
			if ( data.result != null )
				_model.collAllDonationDetails = data.result as ArrayCollection;
			else
				_model.collAllDonationDetails = new ArrayCollection();
		}
		
		/**
		 * Fault handler of remote service. 
		 * @param info
		 */		
		public function fault( info : Object ) : void
		{
			_fundTrackerUtil.handleServiceFaultError( info );
		}
	}
}