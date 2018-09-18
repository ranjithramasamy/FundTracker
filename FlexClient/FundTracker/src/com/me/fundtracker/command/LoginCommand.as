package com.me.fundtracker.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.me.fundtracker.delegates.LoginDelegate;
	import com.me.fundtracker.events.LoginEvent;
	import com.me.fundtracker.model.FundTrackerModelLocator;
	import com.me.fundtracker.utils.FundTrackerUtil;
	import com.me.fundtracker.utils.GlobalConstants;
	
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class LoginCommand implements ICommand, IResponder
	{		
		/**
		 * Model Locator 
		 */		
		private var _model:FundTrackerModelLocator = FundTrackerModelLocator.getInstance();
		
		/**
		 * Holds the instance of Fund Tracker util class. 
		 */		
		private var _fundTrackerUtil : FundTrackerUtil = FundTrackerUtil.getInstance();
		
		/**
		 * Command Execution 
		 * @param event
		 * 
		 */		
		public function execute(event:CairngormEvent):void
		{
			var loginEvent : LoginEvent =   event as LoginEvent;
			
			var delegate:LoginDelegate = new LoginDelegate(this);
			delegate.validateLogin( loginEvent.login );
		}
		
		/**
		 * Service result handler 
		 * @param data
		 * 
		 */		
		public function result(data:Object):void
		{
			if ( data.result != null )
			{
				if ( data.result == true )
					_model.CURRENT_VIEW = GlobalConstants.HOME_VIEW
				else
					Alert.show("Invalid credentials", "Login Failed");
			}
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