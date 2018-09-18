package com.me.fundtracker.control
{
	import com.adobe.cairngorm.control.FrontController;
	import com.me.fundtracker.command.LoginCommand;
	import com.me.fundtracker.events.LoginEvent;
	
	public class LoginController extends FrontController
	{
		public function LoginController()
		{
			initializeCommands();
		}
		
		private function initializeCommands() : void
		{
			addCommand( LoginEvent.VALIDATE_LOGIN, LoginCommand );
		}
	}
}