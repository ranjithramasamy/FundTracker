package com.me.fundtracker.delegates
{
	import com.adobe.cairngorm.business.ServiceLocator;
	import com.me.fundtracker.utils.GlobalConstants;
	import com.me.fundtracker.valueobjects.LoginVO;
	
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.remoting.RemoteObject;

	public class LoginDelegate
	{
		private var _responder : IResponder;
		private var _service : RemoteObject;
		private var _token : AsyncToken;
		
		public function LoginDelegate( responder : IResponder )
		{        
			this._service = ServiceLocator.getInstance().getRemoteObject( GlobalConstants.FUND_TRACKER_REMOTE_SERVICE_NAME );
			this._responder = responder;
		}
		
		public function validateLogin( login : LoginVO ) : void
		{            
			/*var channelSet:ChannelSet = new ChannelSet();
			var amfChannel:AMFChannel = new AMFChannel("my-amf","http://localhost:8080/FundTracker/messagebroker/amf");
			
			channelSet.addChannel(amfChannel);
			this.service.channelSet = channelSet;*/
			
			var call : AsyncToken = _service.validateLogin(login);
			
			call.addResponder( _responder );
		}
		
		
	}
}