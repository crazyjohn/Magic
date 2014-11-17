package com.hifun.soul.game.common.controllers
{
	import com.hifun.soul.framework.core.Controller;
	import com.hifun.soul.game.net.MessageManager;
	import com.hifun.soul.game.net.messages.PlayerGCMessage;
	import com.hifun.soul.game.net.system.SystemMessage;
	
	public class LoginMessageController extends Controller
	{		
		public function LoginMessageController()
		{
			super();
		}
		
		override protected function initController():void
		{
			MessageManager.getInstance().registerMessageReciever(new PlayerGCMessage);
			MessageManager.getInstance().registerMessageReciever(new SystemMessage);
		}
	}
}