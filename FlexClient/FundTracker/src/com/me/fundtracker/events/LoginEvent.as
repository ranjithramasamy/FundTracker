package com.me.fundtracker.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.valueobjects.LoginVO;
	
	import flash.events.Event;
	
	public class LoginEvent extends CairngormEvent
	{
		/**
		 * Event Constants. 
		 */		
		public static const VALIDATE_LOGIN : String = "validatelogin";
		
		public var login : LoginVO;
		
		/**
		 * Constructor 
		 * @param type
		 * @param data
		 * @param bubbles
		 * @param cancelable
		 * 
		 */		
		public function LoginEvent(type:String, data:LoginVO = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
			
			this.login = data;
		}
		
		/**
		 * Returns a cloned copy of the event object by setting the type property and any new properties in the clone.
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new LoginEvent( type, data );
		}
	}
}