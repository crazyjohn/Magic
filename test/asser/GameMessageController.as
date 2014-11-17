package com.hifun.soul.game.common.controllers
{
	import com.hifun.soul.framework.core.Controller;
	import com.hifun.soul.game.net.MessageManager;
	import com.hifun.soul.game.net.messages.AbattoirGCMessage;
	import com.hifun.soul.game.net.messages.ActivityGCMessage;
	import com.hifun.soul.game.net.messages.ArenaGCMessage;
	import com.hifun.soul.game.net.messages.AutobattleGCMessage;
	import com.hifun.soul.game.net.messages.BagGCMessage;
	import com.hifun.soul.game.net.messages.BattleGCMessage;
	import com.hifun.soul.game.net.messages.BattleguideGCMessage;
	import com.hifun.soul.game.net.messages.BloodtempleGCMessage;
	import com.hifun.soul.game.net.messages.BossGCMessage;
	import com.hifun.soul.game.net.messages.BulletinGCMessage;
	import com.hifun.soul.game.net.messages.CdGCMessage;
	import com.hifun.soul.game.net.messages.ChatGCMessage;
	import com.hifun.soul.game.net.messages.CostnotifyGCMessage;
	import com.hifun.soul.game.net.messages.CrystalexchangeGCMessage;
	import com.hifun.soul.game.net.messages.ElitestageGCMessage;
	import com.hifun.soul.game.net.messages.EscortGCMessage;
	import com.hifun.soul.game.net.messages.FactionGCMessage;
	import com.hifun.soul.game.net.messages.FosterGCMessage;
	import com.hifun.soul.game.net.messages.FriendGCMessage;
	import com.hifun.soul.game.net.messages.FunctionhelperGCMessage;
	import com.hifun.soul.game.net.messages.GemGCMessage;
	import com.hifun.soul.game.net.messages.GiftGCMessage;
	import com.hifun.soul.game.net.messages.GmquestionGCMessage;
	import com.hifun.soul.game.net.messages.GodsoulGCMessage;
	import com.hifun.soul.game.net.messages.GuideGCMessage;
	import com.hifun.soul.game.net.messages.HelperGCMessage;
	import com.hifun.soul.game.net.messages.HonourshopGCMessage;
	import com.hifun.soul.game.net.messages.HoroscopeGCMessage;
	import com.hifun.soul.game.net.messages.HumanGCMessage;
	import com.hifun.soul.game.net.messages.ItemGCMessage;
	import com.hifun.soul.game.net.messages.LegionGCMessage;
	import com.hifun.soul.game.net.messages.LegionbossGCMessage;
	import com.hifun.soul.game.net.messages.LegionmineGCMessage;
	import com.hifun.soul.game.net.messages.LevyGCMessage;
	import com.hifun.soul.game.net.messages.LoginrewardGCMessage;
	import com.hifun.soul.game.net.messages.MagicGCMessage;
	import com.hifun.soul.game.net.messages.MailGCMessage;
	import com.hifun.soul.game.net.messages.MallGCMessage;
	import com.hifun.soul.game.net.messages.MarsGCMessage;
	import com.hifun.soul.game.net.messages.MatchbattleGCMessage;
	import com.hifun.soul.game.net.messages.MeditationGCMessage;
	import com.hifun.soul.game.net.messages.MineGCMessage;
	import com.hifun.soul.game.net.messages.NostrumGCMessage;
	import com.hifun.soul.game.net.messages.OnlinerewardGCMessage;
	import com.hifun.soul.game.net.messages.PredictGCMessage;
	import com.hifun.soul.game.net.messages.PrisonGCMessage;
	import com.hifun.soul.game.net.messages.QuestGCMessage;
	import com.hifun.soul.game.net.messages.QuestionGCMessage;
	import com.hifun.soul.game.net.messages.RankGCMessage;
	import com.hifun.soul.game.net.messages.RechargeGCMessage;
	import com.hifun.soul.game.net.messages.RechargetxGCMessage;
	import com.hifun.soul.game.net.messages.RefineGCMessage;
	import com.hifun.soul.game.net.messages.RewardGCMessage;
	import com.hifun.soul.game.net.messages.ShopGCMessage;
	import com.hifun.soul.game.net.messages.SignGCMessage;
	import com.hifun.soul.game.net.messages.SkillGCMessage;
	import com.hifun.soul.game.net.messages.SpriteGCMessage;
	import com.hifun.soul.game.net.messages.StageGCMessage;
	import com.hifun.soul.game.net.messages.TargetGCMessage;
	import com.hifun.soul.game.net.messages.TechnologyGCMessage;
	import com.hifun.soul.game.net.messages.TitleGCMessage;
	import com.hifun.soul.game.net.messages.TrainingGCMessage;
	import com.hifun.soul.game.net.messages.TurntableGCMessage;
	import com.hifun.soul.game.net.messages.VipGCMessage;
	import com.hifun.soul.game.net.messages.WarriorGCMessage;
	import com.hifun.soul.game.net.messages.YellowvipGCMessage;

	public class GameMessageController extends Controller
	{		
		public function GameMessageController()
		{
			super();
		}
		
		override protected function initController():void
		{
			MessageManager.getInstance().registerMessageReciever(new FactionGCMessage);
			MessageManager.getInstance().registerMessageReciever(new SignGCMessage);
			MessageManager.getInstance().registerMessageReciever(new LegionGCMessage);
			MessageManager.getInstance().registerMessageReciever(new HumanGCMessage);
			MessageManager.getInstance().registerMessageReciever(new BagGCMessage);
			MessageManager.getInstance().registerMessageReciever(new QuestGCMessage);
			MessageManager.getInstance().registerMessageReciever(new MallGCMessage);
			MessageManager.getInstance().registerMessageReciever(new BulletinGCMessage);
			MessageManager.getInstance().registerMessageReciever(new RankGCMessage);
			MessageManager.getInstance().registerMessageReciever(new MailGCMessage);
			MessageManager.getInstance().registerMessageReciever(new ShopGCMessage);
			MessageManager.getInstance().registerMessageReciever(new LevyGCMessage);
			MessageManager.getInstance().registerMessageReciever(new HoroscopeGCMessage);
			MessageManager.getInstance().registerMessageReciever(new GemGCMessage);
			MessageManager.getInstance().registerMessageReciever(new ItemGCMessage);
			MessageManager.getInstance().registerMessageReciever(new BattleGCMessage);
			MessageManager.getInstance().registerMessageReciever(new SkillGCMessage);
			MessageManager.getInstance().registerMessageReciever(new StageGCMessage);
			MessageManager.getInstance().registerMessageReciever(new TechnologyGCMessage);
			MessageManager.getInstance().registerMessageReciever(new TurntableGCMessage);
			MessageManager.getInstance().registerMessageReciever(new CdGCMessage);
			MessageManager.getInstance().registerMessageReciever(new TrainingGCMessage);
			MessageManager.getInstance().registerMessageReciever(new LoginrewardGCMessage);
			MessageManager.getInstance().registerMessageReciever(new QuestionGCMessage);
			MessageManager.getInstance().registerMessageReciever(new CrystalexchangeGCMessage);
			MessageManager.getInstance().registerMessageReciever(new VipGCMessage);
			//MessageManager.getInstance().registerMessageReciever(new SystemMessage);
			MessageManager.getInstance().registerMessageReciever(new ChatGCMessage);
			MessageManager.getInstance().registerMessageReciever(new FriendGCMessage);
			MessageManager.getInstance().registerMessageReciever(new ArenaGCMessage);
			MessageManager.getInstance().registerMessageReciever(new MeditationGCMessage);
			MessageManager.getInstance().registerMessageReciever(new BossGCMessage);
			MessageManager.getInstance().registerMessageReciever(new ActivityGCMessage);
			MessageManager.getInstance().registerMessageReciever(new ElitestageGCMessage);
			MessageManager.getInstance().registerMessageReciever(new OnlinerewardGCMessage);
			MessageManager.getInstance().registerMessageReciever(new GmquestionGCMessage);
			MessageManager.getInstance().registerMessageReciever(new GuideGCMessage);
			MessageManager.getInstance().registerMessageReciever(new MineGCMessage);			
			MessageManager.getInstance().registerMessageReciever(new CostnotifyGCMessage);
			MessageManager.getInstance().registerMessageReciever(new RewardGCMessage);
			MessageManager.getInstance().registerMessageReciever(new HelperGCMessage);
			MessageManager.getInstance().registerMessageReciever(new AutobattleGCMessage);
			MessageManager.getInstance().registerMessageReciever(new HonourshopGCMessage);
			MessageManager.getInstance().registerMessageReciever(new GiftGCMessage);
			MessageManager.getInstance().registerMessageReciever(new FosterGCMessage);

			MessageManager.getInstance().registerMessageReciever(new MatchbattleGCMessage);

			MessageManager.getInstance().registerMessageReciever(new RefineGCMessage);
			MessageManager.getInstance().registerMessageReciever(new FunctionhelperGCMessage);
			MessageManager.getInstance().registerMessageReciever(new WarriorGCMessage);
			MessageManager.getInstance().registerMessageReciever(new BattleguideGCMessage);
			MessageManager.getInstance().registerMessageReciever(new YellowvipGCMessage);
			MessageManager.getInstance().registerMessageReciever(new RechargetxGCMessage);
			MessageManager.getInstance().registerMessageReciever(new TitleGCMessage);
			MessageManager.getInstance().registerMessageReciever(new GodsoulGCMessage);
			MessageManager.getInstance().registerMessageReciever(new PrisonGCMessage);
			MessageManager.getInstance().registerMessageReciever(new SpriteGCMessage);
			MessageManager.getInstance().registerMessageReciever(new AbattoirGCMessage);
			MessageManager.getInstance().registerMessageReciever(new BloodtempleGCMessage);
			MessageManager.getInstance().registerMessageReciever(new RechargeGCMessage);
			MessageManager.getInstance().registerMessageReciever(new MagicGCMessage);
			MessageManager.getInstance().registerMessageReciever(new MarsGCMessage);
			MessageManager.getInstance().registerMessageReciever(new TargetGCMessage);
			MessageManager.getInstance().registerMessageReciever(new LegionbossGCMessage);
			MessageManager.getInstance().registerMessageReciever(new LegionmineGCMessage);
			MessageManager.getInstance().registerMessageReciever(new NostrumGCMessage);
			MessageManager.getInstance().registerMessageReciever(new EscortGCMessage);
			MessageManager.getInstance().registerMessageReciever(new PredictGCMessage);
		}
	}
}