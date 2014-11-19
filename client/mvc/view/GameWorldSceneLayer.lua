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
    
    -- 建筑层
    local buildingLayer = Layout:create()
    buildingLayer:setSize(CCSize(display.width, display.height))
    self:addChild(buildingLayer)
    -- 1. 技能塔
    local towerBuilding = requireNewLayer("GameWorldBuildingLayer")
    towerBuilding:setData({bgImg = "town/魔法塔.png", titleImg = "town/魔法塔_name.png"})
    towerBuilding:setPosition(CCPoint(200, 440))
    buildingLayer:addChild(towerBuilding)
    -- 2. 技能塔
    local arenaBuilding = requireNewLayer("GameWorldBuildingLayer")
    arenaBuilding:setData({bgImg = "town/竞技场.png", titleImg = "town/竞技场_name.png"})
    arenaBuilding:setPosition(CCPoint(400, 280))
    buildingLayer:addChild(arenaBuilding)
    -- 3. 主城
    local castleBuilding = requireNewLayer("GameWorldBuildingLayer")
    castleBuilding:setData({bgImg = "town/主城.png", titleImg = "town/jianzhu_002.png"})
    castleBuilding:setPosition(CCPoint(635, 515))
    buildingLayer:addChild(castleBuilding)
    -- 4. 矿场
    local mineBuilding = requireNewLayer("GameWorldBuildingLayer")
    mineBuilding:setData({bgImg = "town/精炼厂.png", titleImg = "town/矿场_name.png"})
    mineBuilding:setPosition(CCPoint(400, 430))
    buildingLayer:addChild(mineBuilding)
    -- 5. 战争学院
    local collegeBuilding = requireNewLayer("GameWorldBuildingLayer")
    collegeBuilding:setData({bgImg = "town/战争学院.png", titleImg = "town/战争学院_name.png"})
    collegeBuilding:setPosition(CCPoint(865, 300))
    buildingLayer:addChild(collegeBuilding)
    -- 6. 训练场
    local slaveBuilding = requireNewLayer("GameWorldBuildingLayer")
    slaveBuilding:setData({bgImg = "town/训练场.png", titleImg = "town/战俘营_name.png"})
    slaveBuilding:setPosition(CCPoint(680, 320))
    buildingLayer:addChild(slaveBuilding)
    -- 7. 铁匠铺
    local smithBuilding = requireNewLayer("GameWorldBuildingLayer")
    smithBuilding:setData({bgImg = "town/铁匠铺.png", titleImg = "town/铁匠铺_name.png"})
    smithBuilding:setPosition(CCPoint(630, 210))
    buildingLayer:addChild(smithBuilding)
    -- 8. 占星屋
    local starBuilding = requireNewLayer("GameWorldBuildingLayer")
    starBuilding:setData({bgImg = "town/天命神殿.png", titleImg = "town/占星_name.png"})
    starBuilding:setPosition(CCPoint(865, 530))
    buildingLayer:addChild(starBuilding)


    -- 游戏世界UI层
    local uiLayer = requireNewLayer("GameWorldUILayer")
    self:addChild(uiLayer)
    -- set bg
    uiLayer:setSceneBg(self.__bgImg)
end

return GameWorldSceneLayer
