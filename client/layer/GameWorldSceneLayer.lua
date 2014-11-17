-- 游戏世界场景视图;
-- @author crazyjohn
-- @date 2014-11-06 22:37:14
--

-- create logger;
local logger = LoggerFactory:getLogger("GameWorldSceneLayer")
-- create class;
local GameWorldSceneLayer = class("GameWorldSceneLayer", function()
    local self = loadUI("GameWorldScene.json")
    --local self = Layout:create()
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, GameWorldSceneLayer)
    return self
end)

-- ctor;
function GameWorldSceneLayer:ctor( ... )
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- eventBus;
function GameWorldSceneLayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function GameWorldSceneLayer:__enter()
    -- TODO: do enter things
    -- add some actions
    -- local fadeOut = CCFadeOut:create(5)
    -- local fadeIn = CCFadeIn:create(5)
    -- self.__bgImg:runAction(CCRepeatForever:create(transition.sequence({fadeOut, fadeIn})))
    display.addSpriteFramesWithFile("effectFeiJi.plist", "effectFeiJi.png")
    local frames = display.newFrames("effect_fuben_feiji_%d.png", 10001, 20)
    local animation = display.newAnimation(frames, 2 / 20) -- 2 秒播放 20 桢
    local animate = CCAnimate:create(animation)
    -- local action = CCRepeatForever:create(animate)
    local animateSprite = CCSprite:create()
    animateSprite:runAction(transition.sequence({
            animate,
            CCCallFunc:create(function( ... )
                -- body
                self:removeNode(animateSprite)
            end)
        }))
    animateSprite:setScale(2)
    animateSprite:setPosition(ccp(display.cx, display.cy))
    self:addNode(animateSprite)
    logger:debug("AnchorPoint: %d, %d", animateSprite:getAnchorPoint().x, animateSprite:getAnchorPoint().y)
    -- 通知进入场景完毕
    CGPlayerMessage:CG_ENTER_SCENE_READY()
end

-- exit;
function GameWorldSceneLayer:__exit()
    -- TODO: do exit things
end

-- declare the field you want to use;
function GameWorldSceneLayer:__onDeclareVars( ... )
    -- TODO: do declare things
    -- eg: self.__account = tolua.cast(UIHelper:seekWidgetByName(self, "account"), "TextField")
    self.__bgImg = tolua.cast(UIHelper:seekWidgetByName(self, "bgImg"), "ImageView")
   
end

-- init;
function GameWorldSceneLayer:__onInit( ... )
    -- TODO: do init things
    -- 游戏世界UI层
    local uiLayer = requireNewLayer("GameWorldUILayer")
    self:addChild(uiLayer)
    -- set bg
    uiLayer:setSceneBg(self.__bgImg)
    -- building layer
    local arenaBuilding = requireNewLayer("GameWorldBuildingLayer")
    arenaBuilding:setData({bgImg = "town/魔法塔.png"})
    arenaBuilding:setScale(4)
    arenaBuilding:setPosition(CCPoint(100, 100))
    self:addChild(arenaBuilding)
end

return GameWorldSceneLayer
