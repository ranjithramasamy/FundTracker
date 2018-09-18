package com.me.fundtracker.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class PopMenuItemClickEvent extends CairngormEvent
	{
		/**
		 * Member Constants.
		 */		
		public static const APPLICATION_EXIT : String = "applicationexit";
		
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function PopMenuItemClickEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Returns a cloned copy of the event object by setting the type property and any new properties in the clone. 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new PopMenuItemClickEvent( type, bubbles, cancelable );
		}
	}
}