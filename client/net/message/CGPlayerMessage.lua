	local CGPlayerMessage = class("CGPlayerMessage")
  
 		--[[
		 -- 用户登录
		 -- @param account 玩家的账户
		 -- @param password 玩家的密码 
		 ]]
		function CGPlayerMessage:CG_PLAYER_LOGIN(account,password)
				-- bodyArray;
				local msgBody = requireNewByteArray()
				msgBody:writeStringUShort(account)
				msgBody:writeStringUShort(password)
				GameSocket:sendPacket(MessageType.CG_PLAYER_LOGIN, msgBody)
		end
 
 		--[[
		 -- 玩家使用cookie登录
		 -- @param jsonValue 使用json字符串传递的信息
		 ]]
		function CGPlayerMessage:CG_PLAYER_COOLIE_LOGIN(jsonValue)
				-- bodyArray;
				local msgBody = requireNewByteArray()
				msgBody:writeStringUShort(jsonValue)
				GameSocket:sendPacket(MessageType.CG_PLAYER_COOLIE_LOGIN, msgBody)
		end
 
 		--[[
		 -- 玩家请求角色列表
		 ]]
		function CGPlayerMessage:CG_GET_CHAR_LIST()
				GameSocket:sendPacket(MessageType.CG_GET_CHAR_LIST)
		end
 
 		--[[
		 -- 玩家选角色
		 -- @param charIndex 角色索引 
		 ]]
		function CGPlayerMessage:CG_SELECT_CHAR(charIndex)
				-- bodyArray;
				local msgBody = requireNewByteArray()
				msgBody:writeInt(charIndex)
				GameSocket:sendPacket(MessageType.CG_SELECT_CHAR, msgBody)
		end
 
 		--[[
		 -- 玩家创建角色
		 -- @param name 角色名称 
		 -- @param occupation 角色职业 
		 ]]
		function CGPlayerMessage:CG_CREATE_CHAR(name,occupation)
				-- bodyArray;
				local msgBody = requireNewByteArray()
				msgBody:writeStringUShort(name)
				msgBody:writeInt(occupation)
				GameSocket:sendPacket(MessageType.CG_CREATE_CHAR, msgBody)
		end
 
 		--[[
		 -- 通知服务器已经准备好进入场景
		 ]]
		function CGPlayerMessage:CG_ENTER_SCENE_READY()
				GameSocket:sendPacket(MessageType.CG_ENTER_SCENE_READY)
		end
 
 		--[[
		 -- 自动生成角色名字请求
		 -- @param occupation 角色职业 
		 ]]
		function CGPlayerMessage:CG_AUTO_NAME(occupation)
				-- bodyArray;
				local msgBody = requireNewByteArray()
				msgBody:writeInt(occupation)
				GameSocket:sendPacket(MessageType.CG_AUTO_NAME, msgBody)
		end
 
 		--[[
		 -- 玩家心跳包，防止长时间不活动被TGW(server)踢掉
		 ]]
		function CGPlayerMessage:CG_PLAYER_HEART_BEAT()
				GameSocket:sendPacket(MessageType.CG_PLAYER_HEART_BEAT)
		end
	
return CGPlayerMessage