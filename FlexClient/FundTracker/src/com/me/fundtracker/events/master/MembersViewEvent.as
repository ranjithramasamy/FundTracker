package com.me.fundtracker.events.master
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	public class MembersViewEvent extends CairngormEvent
	{
		/**
		 * Event constants. 
		 */		
		public static const GET_ALL_MEMBERS_DETAIL : String = "getallmembersdetail";
		
		public static const INSERT_MEMBER_DETAIL : String = "addnewmemberdetail";
		
		public static const UPDATE_MEMBER_DETAIL : String = "updatememberdetail";
		
		public static const DELETE_MEMBER_DETAIL : String = "deletememberdetail";
		
		/**
		 * Holds the collection of MembersVO to add / edit their details. 
		 */		
		public var collMembersDetail : ArrayCollection = null;
		
		/**
		 * Constructor 
		 * @param type
		 * @param collMembers
		 * @param bubbles
		 * @param cancelable
		 */		
		public function MembersViewEvent(type:String, collMembers:ArrayCollection = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			this.collMembersDetail = collMembers;
			
			super(type, bubbles, cancelable);
		}
		
		
		/**
		 * Returns a cloned copy of the event object by setting the type property and any new properties in the clone.
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new MembersViewEvent( type, collMembersDetail );
		}
	}
}