-- 游戏世界UI层视图;
-- @author crazyjohn
-- @date 2014-11-16 20:16:46
--

-- create logger;
local logger = LoggerFactory:getLogger("GameWorldUILayer")
-- create class;
local GameWorldUILayer = class("GameWorldUILayer", function()
    -- TODO: parse ui file
    local self = loadUI("GameWorldUI.json")
    --local self = Layout:create()
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, GameWorldUILayer)
    return self
end)

-- ctor;
function GameWorldUILayer:ctor( ... )
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- declare the field you want to use;
function GameWorldUILayer:__onDeclareVars( ... )
    -- TODO: do declare things
    self.__bottomLayer = tolua.cast(UIHelper:seekWidgetByName(self, "bottomLayer"), "Layout")
    self.__stoneMonsterImg = tolua.cast(UIHelper:seekWidgetByName(self, "stoneMonsterImg"), "ImageView")
    self.__arrowImg = tolua.cast(UIHelper:seekWidgetByName(self, "arrowImg"), "ImageView")
    self.__chatBtn = tolua.cast(UIHelper:seekWidgetByName(self, "chatBtn"), "Button")
    self.__bgImg = tolua.cast(UIHelper:seekWidgetByName(self, "bgImg"), "ImageView")
   
end

-- init;
function GameWorldUILayer:__onInit( ... )
    -- TODO: do init things(addEventListener...)
    -- 石头人开关
    self.__monsterUp = false
    self.__stoneMonsterImg:addTouchEventListener(function(touch, event)
        if event == TOUCH_EVENT_ENDED then
            -- body
            -- 石头人移动
            local moveToAction = CCMoveBy:create(0.3, CCPoint(0, 110))
            -- 箭头旋转
            local rotateToAction = CCRotateBy:create(0.3, 180)
            local rotateBackAction = CCRotateBy:create(0.3, -180)
            local moveBackAction = moveToAction:reverse()
            -- 背景淡入淡出
            local fadeOutAction = CCFadeTo:create(0.3, 255 * 0.4)
            local fadeInAction = CCFadeTo:create(0.3, 255 * 1)
            if not self.__monsterUp then
                self.__bottomLayer:runAction(moveToAction)
                self.__arrowImg:runAction(rotateToAction)
                self.__bgImg:runAction(fadeOutAction)
                self.__monsterUp = true
            else
                self.__bottomLayer:runAction(moveBackAction)
                self.__arrowImg:runAction(rotateBackAction)
                self.__bgImg:runAction(fadeInAction)
                self.__monsterUp = false
            end
        end
        
    end)
    -- 聊天动画
    local chatMoveToAction = CCScaleBy:create(0.3, 0.95)
    self.__chatBtn:runAction(CCRepeatForever:create(transition.sequence({
            chatMoveToAction, 
            chatMoveToAction:reverse()
        })))

end

function GameWorldUILayer:setSceneBg(bg)
    self.__bgImg = bg
end

-- eventBus;
function GameWorldUILayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function GameWorldUILayer:__enter()
    -- TODO: do enter things
end

-- render;
function GameWorldUILayer:__render( ... )
    -- body
end

-- exit;
function GameWorldUILayer:__exit()
    -- TODO: do exit things
end

return GameWorldUILayer
