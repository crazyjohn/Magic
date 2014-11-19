-- 登录视图;
-- 第一个视图, 尝试通过此视图总结出视图的基本框架结构，然后通过模版文件生成。
-- @author crazyjohn;
-- @date: 2014-11-04

-- create logger;
local logger = LoggerFactory:getLogger("LoginLayer")
local LoginLayer = class("LoginLayer", function()
	-- body
	--local self = UILayout:create()
	local self = loadUI("LoginUI.json")
	local t = tolua.getpeer(self)
	if not t then
		t= {}
		tolua.setpeer(self, t)
	end
	setmetatable(t, LoginLayer)
	return self
end)

local __socket

function LoginLayer:__connect()
	if not __socket then
		__socket = GameSocket
	end
	__socket:connect()
end

-- template method;
-- 构造方法;
function LoginLayer:ctor( ... )
	-- 1. declareVar
	self:__onDeclareVars(...)
	-- 2. registEvents
	self:registerScriptHandler(handler(self, self.__eventBus))
	-- 3. init
	self:__onInit(...)
end

-- eventBus;
function LoginLayer:__eventBus(event)
	if event == "enter" then
		self:__enter()
	elseif event == "exit" then
		self:__exit()
	end
end

-- enter;
function LoginLayer:__enter()
	-- body
end

-- exit;
function LoginLayer:__exit()
	-- body
end

-- template method;
-- 声明变量的方法;
function LoginLayer:__onDeclareVars( ... )
	-- body
	-- editby: crazyjohn cocos2dx 2.2.5以后的getChildByName只会搜索深度为1的子节点
	-- 所以需要改而使用：UIHelper:seekWidgetByName 的方式来获取子节点
	self.__bgImg = tolua.cast(UIHelper:seekWidgetByName(self, "bgImg"), "ImageView")
	self.__quickLoginBtn = tolua.cast(UIHelper:seekWidgetByName(self, "enterBtn"), "Button")
	self.__centerLayer = tolua.cast(UIHelper:seekWidgetByName(self, "enterBtn"), "Layout")
	-- end
end
-- template method;
-- 初始化的方法;
function LoginLayer:__onInit( ... )
	-- body
	self.__quickLoginBtn:addTouchEventListener(function(touch, event)
		-- body
		if event == TOUCH_EVENT_ENDED then
			self:__connect()
		end
		
	end)
	-- serverListBtn test
	local selectServerBtn = Button:create()
	selectServerBtn:setTitleFontSize(24)
	selectServerBtn:setPosition(ccp(500, 300))
	self.__quickLoginBtn:getParent():addChild(selectServerBtn)
	selectServerBtn:loadTextureNormal("enterBtn.png", UI_TEX_TYPE_PLIST)
	selectServerBtn:addTouchEventListener(function(touch, event)
		if event == TOUCH_EVENT_ENDED then
			logger:debug("Select server")
			local serverListLayer = requireNewLayer("ServerListLayer")
			PopUpManager:addPopUp(serverListLayer, true, true)
		end
	end)
end

return LoginLayer