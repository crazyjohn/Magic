package com.hifun.soul.framework.net
{
	import com.hifun.soul.framework.log.Logger;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	public class GameSocket extends Socket
	{
		/**
		 * 消息类型映射表 
		 */
		public static var MESSAGETYPE_MAP:Dictionary;
		
		/**
		 * 日志 
		 */
		private static var log:Logger = new Logger("GameSocket");

		public static function getInstance():GameSocket
		{
			if (!instance)
			{
				instance=new GameSocket();
			}

			return instance;
		}

		private static var instance:GameSocket;

		public function GameSocket()
		{
			if (instance)
			{
				throw new Error("GameSocket instance has already been constructed!")
			}

			instance=this;
			
			instance.timeout = 8000;

			init();
		}

		private var handleMap:Dictionary=new Dictionary();

		public function register(type:*, handle:Function):void
		{
			if (type in handleMap)
			{
				log.warn((MESSAGETYPE_MAP ? MESSAGETYPE_MAP[type] : type) + "已经在MESSAGETYPE_MAP中被注册");
			}
			if (handle == null)
			{
				throw new Error("Cannot registe a null hanlder to GameSocket")
			}
			handleMap[type]=handle;
		}

		public function unRegister(type:*):void
		{
			if (type in handleMap)
			{
				delete handleMap[type];
			}
			else
			{
				log.warn("找不到该类型", MESSAGETYPE_MAP ? MESSAGETYPE_MAP[type] : type);
			}
		}

		public var handleTrace:Function = null;
		
		private function excuteHandle(type:*, content:*):void
		{
			log.debug("消息接收", type is String ? type : MESSAGETYPE_MAP ? MESSAGETYPE_MAP[type] : type,type);
			if (handleTrace != null)
				handleTrace("消息接收,"+(type is String ? type : MESSAGETYPE_MAP ? MESSAGETYPE_MAP[type] : type)+","+type,0xEE82EE);
			if (type in handleMap)
			{
				handleMap[type](content);
			}
			else
			{
				log.warn("找不到对映的处理函数", MESSAGETYPE_MAP ? MESSAGETYPE_MAP[type] : type);
			}
		}


		private function init():void
		{
			addEventListener(Event.CONNECT, connectHandler);
			addEventListener(Event.CLOSE, closeHandler);
			addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}

		public var sendPackageTrace:Function = null;
		
		public function sendPackage(cmd:int, body:ByteArray):void
		{
			log.debug("消息发送", MESSAGETYPE_MAP ? MESSAGETYPE_MAP[cmd] : cmd, cmd);
			if (sendPackageTrace != null)
				sendPackageTrace("消息发送,"+(MESSAGETYPE_MAP ? MESSAGETYPE_MAP[cmd] : cmd)+","+cmd);
			
			writeShort(body.length + 4);
			writeShort(cmd);
			writeBytes(body);
			flush();
		}

		private function connectHandler(e:Event):void
		{
			excuteHandle(Event.CONNECT, e)
		}

		private function closeHandler(e:Event):void
		{
			excuteHandle(Event.CLOSE, e)
		}

		private function errorHandler(e:IOErrorEvent):void
		{
			excuteHandle(IOErrorEvent.IO_ERROR, e)
		}

		private function securityErrorHandler(e:SecurityErrorEvent):void
		{
			excuteHandle(SecurityErrorEvent.SECURITY_ERROR, e)
		}

		private var len:int;
		private var cmd:int;
		private var recvCache:ByteArray=new ByteArray();
		private var recvArray:ByteArray=new ByteArray();
		private var dataBody:ByteArray=new ByteArray();

		private function socketDataHandler(e:ProgressEvent):void
		{
			len=0;
			cmd=0;
			recvCache.length=0;
			readBytes(recvCache);

			if (recvArray.position == 0)
			{
				recvCache.position=0;
				while (recvCache.bytesAvailable >= 4)
				{
					len=recvCache.readUnsignedShort();
					if (len - 2 <= recvCache.bytesAvailable)
					{
						cmd=recvCache.readShort();
						dataBody.length=0;
						dataBody.writeBytes(recvCache, recvCache.position, len - 4);
						recvCache.position+=len - 4;
						dataBody.position=0;

						excuteHandle(cmd, dataBody);
					}
					else
					{
						recvCache.position-=2;
						break;
					}
				}
				if (recvCache.bytesAvailable > 0)
				{
					recvArray.length=0;
					recvArray.writeBytes(recvCache, recvCache.position, recvCache.bytesAvailable);
				}
			}
			else
			{
				recvCache.position=0;
				recvCache.readBytes(recvArray, recvArray.length, recvCache.length);
				recvArray.position=0;
				while (recvArray.bytesAvailable >= 4)
				{
					len=recvArray.readUnsignedShort();
					if (len - 2 <= recvArray.bytesAvailable)
					{
						cmd=recvArray.readShort();
						dataBody.length=0;
						dataBody.writeBytes(recvArray, recvArray.position, len - 4);
						recvArray.position+=len - 4;
						dataBody.position=0;

						excuteHandle(cmd, dataBody);
					}
					else
					{
						recvArray.position-=2;
						break;
					}
				}
				if (recvArray.bytesAvailable > 0)
				{
					dataBody.length=0;
					dataBody.writeBytes(recvArray, recvArray.position, recvArray.bytesAvailable);
					dataBody.position=0;
					recvArray.length=dataBody.length;
					recvArray.position=0;
					recvArray.writeBytes(dataBody);
				}
				else
				{
					recvArray.position=0;
					recvArray.length=0;
				}
			}
		}
	}
}