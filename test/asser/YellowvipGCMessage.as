
package com.hifun.soul.game.net.messages {
	import flash.utils.IDataInput;
	import com.hifun.soul.game.net.handlers.*;
	import com.hifun.soul.game.net.datas.*;
	import com.hifun.soul.framework.utils.Long;
	import com.hifun.soul.framework.net.AbstractMessageReceiver;
	import com.hifun.soul.game.net.MessageType;
	
	public class YellowvipGCMessage extends AbstractMessageReceiver
	{
		override protected function collectObservers():void
		{
				register(MessageType.GC_OPEN_YELLOW_VIP_REWARD_PANEL,GC_OPEN_YELLOW_VIP_REWARD_PANEL);
				register(MessageType.GC_UPDATE_YELLOW_VIP_REWARD_STATE,GC_UPDATE_YELLOW_VIP_REWARD_STATE);
		}
 
  		/**
		 * 更新黄钻新手礼包领取状态
		 * @param onceRewardState 新手礼包领取状态(0不可领取,1可领取，2已领取)
		 * @param dailyRewardState 每日礼包领取状态(0不可领取,1可领取，2已领取)
		 * @param levelUpRewardState 升级礼包领取状态(0不可领取,1可领取，2已领取)
		 * @param yearVipRewardState 年费黄钻礼包领取状态(0不可领取,1可领取，2已领取)
		 */
		public function GC_OPEN_YELLOW_VIP_REWARD_PANEL(data:IDataInput):void 
		{
			var i:int,size:int;
			var onceRewardState:int = data.readInt();		
			var dailyRewardState:int = data.readInt();		
			var levelUpRewardState:Array = [];
			size = data.readShort();
			for(i=0; i<size; i++)
			{
								levelUpRewardState[i] = data.readInt();
							}
			var yearVipRewardState:int = data.readInt();		
			YellowvipHandler.GC_OPEN_YELLOW_VIP_REWARD_PANEL(onceRewardState,dailyRewardState,levelUpRewardState,yearVipRewardState);
		}
 
  		/**
		 * 更新黄钻礼包领取状态
		 * @param rewardType 领取奖励类型
		 * @param rewardState 领取状态(0不可领取,1可领取，2已领取)
		 */
		public function GC_UPDATE_YELLOW_VIP_REWARD_STATE(data:IDataInput):void 
		{
			var i:int,size:int;
			var rewardType:int = data.readInt();		
			var rewardState:Array = [];
			size = data.readShort();
			for(i=0; i<size; i++)
			{
								rewardState[i] = data.readInt();
							}
			YellowvipHandler.GC_UPDATE_YELLOW_VIP_REWARD_STATE(rewardType,rewardState);
		}
	}
}