package com.me.fundtracker.events.components
{
	import flash.events.Event;
	
	public class InteractiveComponentEvent extends Event
	{
		/**
		 * Event Constants. 
		 */		
		public static const REFRESH : String = "refresh";
		
		/**
		 * Constructor 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function InteractiveComponentEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
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
			return new InteractiveComponentEvent( type );
		}
	}
}