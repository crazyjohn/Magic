package com.hifun.soul.game.net.messages {
	import flash.utils.ByteArray;
	
	import com.hifun.soul.game.net.MessageType;
	import com.hifun.soul.framework.utils.Long;
	import com.hifun.soul.game.net.datas.*;
	import com.hifun.soul.game.net.handlers.*;
	import com.hifun.soul.framework.net.TCPService;
	
	public class YellowvipCGMessage{
		public static var msgBody:ByteArray = new ByteArray();
  
 		/**
		 * 更新黄钻新手礼包领取状态
		 */
		public static function CG_OPEN_YELLOW_VIP_REWARD_PANEL():void {
				msgBody.length = 0;
				TCPService.sendPackage(MessageType.CG_OPEN_YELLOW_VIP_REWARD_PANEL,msgBody);
			}
 
 		/**
		 * 领取黄钻礼包请求
		 * @param rewardType 领取奖励类型
		 */
		public static function CG_RECEIVE_YELLOW_VIP_REWARD(rewardType:int):void {
				msgBody.length = 0;
				msgBody.writeInt(rewardType);
				TCPService.sendPackage(MessageType.CG_RECEIVE_YELLOW_VIP_REWARD,msgBody);
			}
 
 		/**
		 * 领取黄钻升级礼包请求
		 * @param rewardIndex 升级奖励索引
		 */
		public static function CG_RECEIVE_YELLOW_VIP_LEVEL_UP_REWARD(rewardIndex:int):void {
				msgBody.length = 0;
				msgBody.writeInt(rewardIndex);
				TCPService.sendPackage(MessageType.CG_RECEIVE_YELLOW_VIP_LEVEL_UP_REWARD,msgBody);
			}
	}
}