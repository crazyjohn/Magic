-- ServerListLayer
-- @author crazyjohn
-- @date 2014-11-19 17:51:04
--

-- create logger;
local logger = LoggerFactory:getLogger("ServerListLayer")
-- create class;
local ServerListLayer = class("ServerListLayer", function()
    -- TODO: parse ui file
    local self = Layout:create()
    --local self = loadUI("ServerListLayer.json")
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, ServerListLayer)
    return self
end)

-- ctor;
function ServerListLayer:ctor( ... )
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- declare the field you want to use;
function ServerListLayer:__onDeclareVars( ... )
    -- TODO: do declare things
    -- eg: self.__account = tolua.cast(UIHelper:seekWidgetByName(self, "account"), "TextField")
   
end

-- init;
function ServerListLayer:__onInit( ... )
    -- TODO: do init things(addEventListener...)
    local bgImg = ImageView:create()
    bgImg:loadTexture("loginBox.jpg", UI_TEX_TYPE_PLIST)
    self:addChild(bgImg)
    bgImg:setTouchEnabled(true)
    bgImg:addTouchEventListener(function(touch, event)
        if event == TOUCH_EVENT_ENDED then
            logger:debug("Touch me")
            PopUpManager:removePopUp(self)
        end
    end)
end

-- eventBus;
function ServerListLayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function ServerListLayer:__enter()
    -- TODO: do enter things
end

-- render;
function ServerListLayer:__render( ... )
    -- body
end

-- exit;
function ServerListLayer:__exit()
    -- TODO: do exit things
end

return ServerListLayer
