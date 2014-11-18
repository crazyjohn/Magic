package com.hifun.soul.game.common.managers
{
	import com.hifun.soul.game.common.views.ResourceLoadingView;
	import com.hifun.soul.game.resources.ResourcePath;
	
	import flash.utils.Dictionary;
	
	import feathers.core.PopUpManager;
	
	import starling.utils.AssetManager;

	/**
	 * 纹理资源管理器;
	 * <ul>
	 * <li>同一种类型的资源如果正在加载, 则会忽略后面的请求</li>
	 * <li>不同类型的资源可以异步同时加载</li>
	 * </ul>
	 * @author crazyjohn;
	 */
	public class TextureManager
	{
		//素材包已加载列表，以ResourceType为key.
		private static var librayList:Dictionary = new Dictionary();
		// 战斗资源管理器
		private var _battleAssets:AssetManager;
		// 游戏世界资源管理器
		private var _gameWorldAssets:AssetManager;
		// 创建角色资源管理器
		private var _createRoleAssets:AssetManager;
		// 资源加载视图
		private var _resourceLoadingView:ResourceLoadingView;
		// singletone
		private static var _instance:TextureManager;	
		// 正在加载中的资源;如果此时再来加载请求, 会直接返回;
		private var inLoadingResMap:Dictionary = new Dictionary();
		// 资源加载完成的回调映射;
		private var completeCallbackMap:Dictionary = new Dictionary();
		
		
		public function TextureManager() {
			// 构建gameWorldAssets
			_gameWorldAssets = new AssetManager(GameSettings.SCALE);
			_battleAssets = new AssetManager(GameSettings.SCALE);
			_createRoleAssets = new AssetManager(GameSettings.SCALE);
			_resourceLoadingView = new ResourceLoadingView();
		}
		
		public function get createRoleAssets():AssetManager
		{
			return _createRoleAssets;
		}

		public function get gameWorldAssets():AssetManager
		{
			return _gameWorldAssets;
		}


		public function get battleAssets():AssetManager
		{
			return _battleAssets;
		}

		public static function getInstance():TextureManager
		{
			if (!_instance)
			{
				_instance = new TextureManager();
			}
			return _instance;
		}
	
		
		/**
		 * 加载UI资源的接口;<br>
		 * @param assetsDesc; 资源的描述，这里要注意UI资源的目录名前缀和纹理文件的前缀要保持一致，否则会发生错误;
		 * */
		public function loadUIAssets(assetsDesc:Object, allComplete:Function=null):void
		{
			// 解析资源描述
			var assetsDescAuth:String = null;
			if(assetsDesc is String)
			{
				/** 如果是字符串，将其作为路径*/
				assetsDescAuth = assetsDesc as String;
			}
			else if(assetsDesc is Array)
			{
				/** 如果是数组，将其第一个元素作为路径*/
				assetsDescAuth = (assetsDesc as Array)[0];
			}
			
			// 是否是正在加载的相同资源
			if (isLoadingRes(assetsDescAuth)) {
				return;
			}
			// 注册完成回调函数
			registerCompleteCallbackByType(assetsDescAuth, allComplete);
			// 是否是已经注册的资源
			if (this.isRegisterLib(assetsDescAuth))
			{
				onUIResourceLoadingComplete(assetsDescAuth);
				return;
			}
			// 取出资源类型
			var prefixType:String = ResourcePath.PNG;
			if (ResourcePath.resPrefixTypeMap[assetsDesc] != null) {
				prefixType = ResourcePath.resPrefixTypeMap[assetsDesc];
			}
			var assets:AssetManager = new AssetManager(GameSettings.SCALE);
			
			if(assetsDesc is String)
			{
				/** 如果是字符串，加载与路径同名资源*/
				assets.enqueue(ResourcePath.getUIAssetPath(assetsDesc + "/" + assetsDesc + prefixType),ResourcePath.getUIAssetPath(assetsDesc + "/" + assetsDesc + ".xml"));
			}
			else if(assetsDesc is Array)
			{
				/** 如果是数组，将其第一个元素作为路径*/
				for(var i:int = 1; i < (assetsDesc as Array).length ; i++)
				{
					trace(ResourcePath.getUIAssetPath(assetsDescAuth + "/" + assetsDesc[i])+ prefixType);
					assets.enqueue(ResourcePath.getUIAssetPath(assetsDescAuth + "/" + assetsDesc[i] + prefixType), ResourcePath.getUIAssetPath(assetsDescAuth + "/" + assetsDesc[i] + ".xml"));
				}
			}
			
			// 设置为正在加载的资源
			addLoadingRes(assetsDescAuth);
			// 展示加载视图
			this.showLoading();
			assets.loadQueue(function(ratio:Number):void{
				if (_resourceLoadingView != null) {
					_resourceLoadingView.onProgress(ratio);
				}
				if(ratio == 1.0)
				{
					addLibrary(assetsDescAuth,assets);
					removeLoadingRes(assetsDescAuth);
					onUIResourceLoadingComplete(assetsDescAuth);
				}
			});
		}
		/**
		 * 注册对应资源的完成回调;
		 */
		private function registerCompleteCallbackByType(assetsDescAuth:String, allComplete:Function):void
		{
			this.completeCallbackMap[assetsDescAuth] = allComplete;
		}
		/**
		 * 移除对应资源的完成回调;
		 */
		private function unRegisterCompleteCallbackByType(assetsDescAuth:String):void
		{
			var resComplete:Function = this.completeCallbackMap[assetsDescAuth];
			if (resComplete != null) {
				resComplete();
			}
			this.completeCallbackMap[assetsDescAuth] = null;
			delete completeCallbackMap[assetsDescAuth];
		}
		
		private function addLoadingRes(assetsDescAuth:String):void
		{
			inLoadingResMap[assetsDescAuth] = assetsDescAuth;
		}
		
		private function removeLoadingRes(assetsDescAuth:String):void
		{
			inLoadingResMap[assetsDescAuth] = null;
			delete inLoadingResMap[assetsDescAuth];
		}
		
		private function isLoadingRes(assetsDescAuth:String):Boolean
		{
			return (assetsDescAuth in inLoadingResMap);
		}
		
		/**
		 * 卸载UI资源;
		 */
		public function unLoadUIAssets(assetsDesc:Object):void
		{
			var assetsDescAuth:String = null;
			if(assetsDesc is String)
			{
				/** 如果是字符串，将其作为路径*/
				assetsDescAuth = assetsDesc as String;
			}
			else if(assetsDesc is Array)
			{
				/** 如果是数组，将其第一个元素作为路径*/
				assetsDescAuth = (assetsDesc as Array)[0];
			}
			// 如果资源没有注册就直接返回
			if (!this.isRegisterLib(assetsDescAuth))
			{
				return;
			}
			// 移除资源;
			var assets:AssetManager = librayList[assetsDescAuth];
			assets.purge();
			removeLibrary(assetsDescAuth);
		}
		
		/**
		 * 移除资源映射;
		 */
		private function removeLibrary(resType:String):void
		{
			if(resType in librayList)
			{
				librayList[resType] = null;
				delete librayList[resType];
			}
		}
		
		/**
		 * 添加打包后的素材库
		 * @param type
		 * @param lib
		 *
		 */
		private function addLibrary(type:String,loaded:AssetManager):void
		{
			if(type in librayList)
			{
				throw new Error("发生资源覆盖，危险！！");
			}
			else
			{
				librayList[type]=loaded;
			}
		}
		
		private function showLoading():void
		{
			if(_resourceLoadingView != null)
			{
				//GameSceneManager.rootSprite.addChild(_resourceLoadingView);
				if(PopUpManager.isPopUp(_resourceLoadingView)) {
					return;
				}
				PopUpManager.addPopUp(_resourceLoadingView, false, true);
				_resourceLoadingView.play();
			}
		}
		
		private function hideLoading():void
		{
			if(_resourceLoadingView!=null)
			{
				_resourceLoadingView.stop();
				//_resourceLoadingView.removeFromParent();
				_resourceLoadingView.removeFromParent();
			}
		}
		
	
		/**
		 * 资源是否注册;
		 */
		private function isRegisterLib(type:String):Boolean
		{
			if (type in librayList)
				return true;
			return false;
		}
		
		/**
		 * 资源加载完成的回调;
		 */
		private function onUIResourceLoadingComplete(assetsDescAuth:String):void
		{
			this.hideLoading();
			// 移除成回调函数
			unRegisterCompleteCallbackByType(assetsDescAuth);
		}
		
		
		
		/**
		 * 根据资源类型获取资源的接口;<br>
		 * @param type; 资源类型, 参考 PanleAssetsType
		 * */
		public static function getAsset(type:String):AssetManager
		{
			if (type in librayList)
				return librayList[type];
			return null;
		}
		
		
	}
}