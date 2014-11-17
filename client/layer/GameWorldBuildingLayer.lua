-- 游戏世界建筑视图抽象;
-- @author crazyjohn
-- @date 2014-11-17 18:25:30
--

-- create logger;
local logger = LoggerFactory:getLogger("GameWorldBuildingLayer")
-- create class;
local GameWorldBuildingLayer = class("GameWorldBuildingLayer", function()
    -- TODO: parse ui file
    local self = Layout:create()
    -- local self = loadUI("GameWorldBuildingLayer.json")
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, GameWorldBuildingLayer)
    return self
end)

-- ctor;
function GameWorldBuildingLayer:ctor( ... )
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- declare the field you want to use;
function GameWorldBuildingLayer:__onDeclareVars( ... )
    -- TODO: do declare things
    -- eg: self.__account = tolua.cast(UIHelper:seekWidgetByName(self, "account"), "TextField")
   
end

-- 设置数据;
-- {背景图片名称, 背景位置, 特效名称, 特效位置}
-- {bgImg, bgPosition, effectName, effectPosition}
function GameWorldBuildingLayer:setData(data)
    -- body
    local bgImg = ImageView:create()
    bgImg:loadTexture(data.bgImg, UI_TEX_TYPE_PLIST)
    self:addChild(bgImg)
end

-- init;
function GameWorldBuildingLayer:__onInit( ... )
    -- TODO: do init things(addEventListener...)
end

-- eventBus;
function GameWorldBuildingLayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function GameWorldBuildingLayer:__enter()
    -- TODO: do enter things
end

-- render;
function GameWorldBuildingLayer:__render( ... )
    -- body
end

-- exit;
function GameWorldBuildingLayer:__exit()
    -- TODO: do exit things
end

return GameWorldBuildingLayer
