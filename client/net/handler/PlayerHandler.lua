-- PlayerHandler;
-- @author crazyjohn;
-- 日志
local logger = LoggerFactory:getLogger("PlayerHandler")
local PlayerHandler = class("PlayerHandler")

function PlayerHandler:GC_PLAYER_LOGIN_RESULT(resultCode)
	-- body
	-- business code
	logger:debug("Login resultCode: " .. resultCode)
	if resultCode == 0 then
		globalExitModule("LoginModule")
	end
	
end

function PlayerHandler:GC_CHARACTER_TEMPLATE(templates)
	logger:debug("Templates size: " .. #templates)
	-- 设置数据
	ModelManager:getModelByName("CreateRoleModel"):setData(templates)
	CGPlayerMessage:CG_GET_CHAR_LIST()
end

function PlayerHandler:GC_CHAR_LIST(chars)
	logger:debug("Chars size: " .. #chars)
	if #chars <= 0 then
		-- 进入创建角色模块
		globalEnterModule("CreateRoleModule")
	else
		-- 选择角色;
		EventBus:fireEvent(EventType.GC_CHAR_LIST)
		CGPlayerMessage:CG_SELECT_CHAR(0)
	end
end

function PlayerHandler:GC_CREATE_CHAR_RESULT(resultCode)
	logger:debug("Create char resultCode: " .. resultCode)
end

function PlayerHandler:GC_ENTER_SCENE()
	-- body
	logger:debug("Prepare to enter scene")
	-- 进入游戏世界;
	globalEnterModule("GameWorldModule")
end

function PlayerHandler:GC_AUTO_NAME(roleName)
	EventBus:fireEvent(EventType.GC_AUTO_NAME, {roleName = roleName})
end

function PlayerHandler:GC_BATTLE_POP(allPops,maxPveRound,maxPvpRound)
	-- body
end

function PlayerHandler:GC_DIRECT_TO_AREA_SCENE()
	-- body
end

return PlayerHandler