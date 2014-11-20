	local GCPlayerMessage = class("GCPlayerMessage")
		function GCPlayerMessage:register()
				-- register handler method
				GlobalMessageRegistry:register(MessageType.GC_PLAYER_LOGIN_RESULT, handler(self, self.GC_PLAYER_LOGIN_RESULT))
				GlobalMessageRegistry:register(MessageType.GC_CHAR_LIST, handler(self, self.GC_CHAR_LIST))
				GlobalMessageRegistry:register(MessageType.GC_CREATE_CHAR_RESULT, handler(self, self.GC_CREATE_CHAR_RESULT))
				GlobalMessageRegistry:register(MessageType.GC_ENTER_SCENE, handler(self, self.GC_ENTER_SCENE))
				GlobalMessageRegistry:register(MessageType.GC_CHARACTER_TEMPLATE, handler(self, self.GC_CHARACTER_TEMPLATE))
				GlobalMessageRegistry:register(MessageType.GC_AUTO_NAME, handler(self, self.GC_AUTO_NAME))
				GlobalMessageRegistry:register(MessageType.GC_BATTLE_POP, handler(self, self.GC_BATTLE_POP))
				GlobalMessageRegistry:register(MessageType.GC_DIRECT_TO_AREA_SCENE, handler(self, self.GC_DIRECT_TO_AREA_SCENE))
				-- register handler
				GlobalHandlers:register("PlayerHandler", requireNewHandler("PlayerHandler"))
		end
 
  		--[[
		 -- 用户登录结果
		 -- @param resultCode 登录结果码 
		 ]]
		function GCPlayerMessage:GC_PLAYER_LOGIN_RESULT(data)
			local resultCode = data:readInt()	
			GlobalHandlers:getHandler("PlayerHandler"):GC_PLAYER_LOGIN_RESULT(resultCode)
		end
 
  		--[[
		 -- 服务器返回玩家角色列表
		 -- @param charList 角色列表 
		 ]]
		function GCPlayerMessage:GC_CHAR_LIST(data)
			local i
			local size
			local charList = {}
			size = data:readShort()
			for i=1, size do
				charList[i] = requireNewProtoData("LoginCharData")
				local charList_obj = charList[i]
				charList[i].humanGuid = data:readLong() --角色的guid
				charList_obj.name = data:readStringUShort()
				charList_obj.occupation = data:readInt()
				charList_obj.level = data:readInt()
				charList[i].energy = data:readLong() --当前精力值
				charList_obj.homeLevel = data:readInt()
				charList[i].coins = data:readLong() --角色当前金币数量
			end
			GlobalHandlers:getHandler("PlayerHandler"):GC_CHAR_LIST(charList)
		end
 
  		--[[
		 -- 玩家创建角色结果
		 -- @param resultCode 创建角色结果码 
		 ]]
		function GCPlayerMessage:GC_CREATE_CHAR_RESULT(data)
			local resultCode = data:readInt()	
			GlobalHandlers:getHandler("PlayerHandler"):GC_CREATE_CHAR_RESULT(resultCode)
		end
 
  		--[[
		 -- 通知客户端准备进入场景
		 ]]
		function GCPlayerMessage:GC_ENTER_SCENE(data)
			GlobalHandlers:getHandler("PlayerHandler"):GC_ENTER_SCENE()
		end
 
  		--[[
		 -- 玩家角色职业模版
		 -- @param characterTemplates 用于创建角色的模版 
		 ]]
		function GCPlayerMessage:GC_CHARACTER_TEMPLATE(data)
			local i
			local size
			local characterTemplates = {}
			size = data:readShort()
			for i=1, size do
				characterTemplates[i] = requireNewProtoData("CharacterOccupationTemplateData")
				local characterTemplates_obj = characterTemplates[i]
				characterTemplates_obj.occupationType = data:readInt()
				characterTemplates_obj.nameIcon = data:readInt()
				characterTemplates_obj.feature = data:readStringUShort()
				characterTemplates_obj.classes = data:readStringUShort()
				characterTemplates_obj.giftIcon1 = data:readInt()
				characterTemplates_obj.giftName1 = data:readStringUShort()
				characterTemplates_obj.giftDesc1 = data:readStringUShort()
				characterTemplates_obj.giftIcon2 = data:readInt()
				characterTemplates_obj.giftName2 = data:readStringUShort()
				characterTemplates_obj.giftDesc2 = data:readStringUShort()
				characterTemplates_obj.giftIcon3 = data:readInt()
				characterTemplates_obj.giftName3 = data:readStringUShort()
				characterTemplates_obj.giftDesc3 = data:readStringUShort()
			end
			GlobalHandlers:getHandler("PlayerHandler"):GC_CHARACTER_TEMPLATE(characterTemplates)
		end
 
  		--[[
		 -- 服务器返回自动生成的角色名字
		 -- @param roleName 角色名字 
		 ]]
		function GCPlayerMessage:GC_AUTO_NAME(data)
			local roleName = data:readStringUShort()	
			GlobalHandlers:getHandler("PlayerHandler"):GC_AUTO_NAME(roleName)
		end
 
  		--[[
		 -- 战斗中的战斗pop信息
		 -- @param allPops 所有的战斗泡泡信息 
		 -- @param maxPveRound PVE最大的回合数 
		 -- @param maxPvpRound PVP最大回合数 
		 ]]
		function GCPlayerMessage:GC_BATTLE_POP(data)
			local i
			local size
			local allPops = {}
			size = data:readShort()
			for i=1, size do
				allPops[i] = requireNewProtoData("BattlePopInfoData")
				local allPops_obj = allPops[i]
				allPops[i].roleId = data:readLong() --角色ID
				local words_allPops_obj
local allPops_obj_words = {}
local allPops_obj_wordsSize = data:readShort()
allPops_obj.words = allPops_obj_words
for words_allPops_obj=1, allPops_obj_wordsSize do
	allPops_obj.words[words_allPops_obj] = data:readStringUShort()
end
			end
			local maxPveRound = data:readInt()	
			local maxPvpRound = data:readInt()	
			GlobalHandlers:getHandler("PlayerHandler"):GC_BATTLE_POP(allPops,maxPveRound,maxPvpRound)
		end
 
  		--[[
		 -- 通知客户端直接进征战场景
		 ]]
		function GCPlayerMessage:GC_DIRECT_TO_AREA_SCENE(data)
			GlobalHandlers:getHandler("PlayerHandler"):GC_DIRECT_TO_AREA_SCENE()
		end
	return GCPlayerMessage
