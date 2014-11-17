package com.hifun.soul.framework.net
{
	import flash.utils.Dictionary;

	public class AbstractMessageReceiver
	{
		public function AbstractMessageReceiver()
		{
		}

		protected function collectObservers():void
		{
			throw new Error("collectObservers must be implemented by subclass");
		}

		private var hasCollected:Boolean=false;

		public function getObservers():Dictionary
		{
			if (!hasCollected)
			{
				collectObservers();
				hasCollected=true;
			}

			return _dic;
		}

		private var _dic:Dictionary=new Dictionary;

		protected function register(cmd:int, excuter:Function):void
		{
			if (cmd in _dic)
			{
				trace("Warning  " + cmd + " has already been registed");
			}
			if (excuter == null)
			{
				throw new Error("Cannot registe a null hanlder")
			}

			_dic[cmd]=excuter;
		}
	}
}