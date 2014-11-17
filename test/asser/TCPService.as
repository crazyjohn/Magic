package com.hifun.soul.framework.net
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;

	public class TCPService
	{
		private static var lossConnectHandle:Function;
		protected static var _socket:GameSocket;
		public function init(socket:GameSocket=null):void
		{
			if (socket == null)
			{
				socket=new GameSocket();
			}

			_socket=socket;
			if (temp.length > 0)
			{
				while (temp.length > 0)
				{
					var dic:Dictionary=temp.pop() as Dictionary;
					for (var key:* in dic)
					{
						_socket.register(key, dic[key]);
					}
				}
			}

			_socket.register(Event.CONNECT, onConnect);
			_socket.register(Event.CLOSE, onDisConnect)
			_socket.register(IOErrorEvent.IO_ERROR, onConnectFailed)
			_socket.register(SecurityErrorEvent.SECURITY_ERROR, onConnectFailed);
			
			lossConnectHandle = lossContnect;
		}

		public function connect(host:String, port:int):void
		{
			if (!_socket)
			{
				init()
			}
			_socket.connect(host, port)
		}

		public function get connected():Boolean
		{
			return _socket ? _socket.connected : false;
		}

		private var temp:Array=[];

		public function registerMessageReciever(reciever:AbstractMessageReceiver):void
		{
			var dic:Dictionary=reciever.getObservers();
			if (_socket)
			{
				for (var key:* in dic)
				{
					_socket.register(key, dic[key]);
				}
			}
			else
			{
				temp.push(dic);
			}
		}

		public function removeMessageReciver(reciever:AbstractMessageReceiver):void
		{
			if (_socket)
			{
				var dic:Dictionary=reciever.getObservers();
				for (var key:* in dic)
				{
					_socket.unRegister(key);
				}
			}
		}

		public static function sendPackage(cmd:int, body:ByteArray):void
		{
			if(_socket && _socket.connected)
			{
				_socket.sendPackage(cmd, body);
			}
			else
			{
				if(_socket.connected == false)
				{
					lossConnectHandle();
				}
			}
		}

		protected function onConnect(e:Event):void
		{
			/*没有实现*/
		}

		protected function onDisConnect(e:Event):void
		{
			/*没有实现*/
		}

		protected function onConnectFailed(e:Event):void
		{
			/*没有实现*/
		}
		
		protected function lossContnect():void
		{
			/*没有实现*/
		}
	}
}