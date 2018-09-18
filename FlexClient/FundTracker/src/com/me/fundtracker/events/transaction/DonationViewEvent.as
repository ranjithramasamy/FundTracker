package com.me.fundtracker.events.transaction
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.valueobjects.transaction.DonationFilterVO;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class DonationViewEvent extends CairngormEvent
	{
		/**
		 * Event constants. 
		 */		
		public static const GET_ALL_DONATION_DETAILS : String = "getalldonationdetails";
		
		public static const GET_ALL_DONATION_CATEGORY_LIST : String = "getalldonationcategorylist";
		
		public static const DONATION_CATEGORY_LIST_LOADED : String = "donationcategorylistloaded";
		
		public static const INSERT_DONATION_DETAILS : String = "inserdonationdetails";
		
		public static const UPDATE_DONATION_DETAILS : String = "updatedonationdetails";
		
		public static const DELETE_DONATION_DETAILS : String = "deletedonationdetails";
		
		/**
		 * Holds the expense filter values.
		 */		
		public var donationFilterVO : DonationFilterVO;
		
		/**
		 * Holds the collection of MembersVO to add / edit their details. 
		 */		
		public var collDonationDetail : ArrayCollection = null;
		
		/**
		 * Constructor 
		 * @param type
		 * @param collMembers
		 * @param bubbles
		 * @param cancelable
		 */		
		public function DonationViewEvent(type:String, donFilterVO:DonationFilterVO = null, collDonation:ArrayCollection = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.donationFilterVO = donFilterVO;
			
			this.collDonationDetail = collDonation;
			
			super(type, bubbles, cancelable);
		}
		
		
		/**
		 * Returns a cloned copy of the event object by setting the type property and any new properties in the clone.
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new DonationViewEvent( type );
		}
	}
}