package com.me.fundtracker.views.viewhelpers
{
	import com.adobe.cairngorm.control.CairngormEventDispatcher;
	import com.adobe.cairngorm.view.ViewHelper;
	import com.me.fundtracker.events.LoginEvent;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.utils.GlobalMessages;
	import com.me.fundtracker.valueobjects.LoginVO;
	import com.me.fundtracker.views.Login;
	
	import mx.controls.Alert;
	import mx.messaging.channels.AMFChannel;
	
	public class LoginViewHelper extends ViewHelper
	{
		/**
		 * Holds the instance of current view which is associate with this helper.
		 */ 
		private var _view : Login;
		
		/**
		 * Constructor
		 */
		public function LoginViewHelper()
		{
			super();
		}
		
		/**
		 * On initialize handler.
		 */
		public function onInit() : void
		{
			_view = Login(view);
			_view.txt_username.setFocus();
		}
		
		/**
		 * Switch to password field while the cursor in username field.
		 */
		public function switchToPasswordField() : void
		{
			_view.txt_password.setFocus();
		}
				
		/**
		 * Validate the given username & password with database data.
		 */
		public function validate() : void
		{
			if ( !checkIsEmpty() )
			{
				var loginEvent : LoginEvent = new LoginEvent(LoginEvent.VALIDATE_LOGIN);
				var loginVo : LoginVO = new LoginVO(); 
				
				loginVo.username = _view.txt_username.text;
				loginVo.password = _view.txt_password.text;
				loginEvent.login = loginVo;
				
				CairngormEventDispatcher.getInstance().dispatchEvent( loginEvent );
			}
		}
		
		/**
		 * Reset the username & password with empty value.
		 */
		public function reset() : void
		{
			_view.txt_username.text = "";
			_view.txt_password.text = "";
			_view.txt_username.setFocus();
		}
		
		
		// -----------------------------------------------------------------------------------------------------------------------
		//							Private function definition starts here
		// -----------------------------------------------------------------------------------------------------------------------
		
		
		/**
		 * Check weather the given username & password values are empty.
		 */
		private function checkIsEmpty() : Boolean
		{
			var isEmpty : Boolean = false;
			
			if ( _view.txt_username.text == "" )
			{
				isEmpty = true;
				_view.txt_username.setFocus();
				Alert.show(GlobalMessages.EMPTY_USERNAME, GlobalConstants.ALERT_TITLE_INFO);
			}
			else if ( _view.txt_password.text == "" )
			{				
				isEmpty = true;
				_view.txt_password.setFocus();
				Alert.show(GlobalMessages.EMPTY_PASSWORD, GlobalConstants.ALERT_TITLE_INFO);
			}
			
			return isEmpty;
		}
		
	}
}