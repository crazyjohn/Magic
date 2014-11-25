-- AlertLayer
-- @author crazyjohn
-- @date 2014-11-24 13:07:39
--

-- create logger;
local logger = LoggerFactory:getLogger("AlertLayer")
-- create class;
local AlertLayer = class("AlertLayer", function()
    -- TODO: parse ui file
    --local self = Layout:create()
    local self = loadUI("AlertUI.json")
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, AlertLayer)
    return self
end)

-- ctor;
function AlertLayer:ctor(...)
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- declare the field you want to use;
function AlertLayer:__onDeclareVars( ... )
    -- TODO: do declare things
    -- eg: self.__account = tolua.cast(UIHelper:seekWidgetByName(self, "account"), "TextField")
    self.__contentLbl = tolua.cast(UIHelper:seekWidgetByName(self, "contentLbl"), "Label")
    self.__bgImg = tolua.cast(UIHelper:seekWidgetByName(self, "bgImg"), "ImageView")
end

-- init;
function AlertLayer:__onInit(...)
    -- TODO: do init things(addEventListener...)
    -- self.__bgImg:addTouchEventListener(function(touch, eventType)
    --     if eventType == TOUCH_EVENT_ENDED then
    --         PopUpManager:removePopUp(self)
    --     end
    -- end)
    
end

--[[
    
展示自己;
@param message 消息内容;

]]
function AlertLayer:showMe(message, btns, callbacks)
    -- content
    self.__contentLbl:setText(message)
    PopUpManager:addPopUp(self, true, true)
    -- btns
    if btns ~= nil then
        for i,label in ipairs(btns) do
            local btn = Button:create()
            btn:setTitleText(label)
            btn:setTitleFontSize(24)
            btn:loadTextureNormal("btn_0003.png", UI_TEX_TYPE_PLIST)
            btn:setAnchorPoint(ccp(0, 0))
            self:__setPositionForBtn(btn, i, btns)
            self.__bgImg:addChild(btn)
            btn:addTouchEventListener(function(touch, eventType)
                if eventType == TOUCH_EVENT_ENDED then
                    callbacks[i]()
                end
            end)
        end
    end
end

function AlertLayer:__setPositionForBtn(btn, index, btns)
    -- 1 - btn : 266, 90
    -- 2 - btn : 1(157, 90) 2(365, 90)
    if #btns == 1 then
        btn:setPosition(ccp(200, 70))
    elseif #btns == 2 then
        if index == 1 then
            btn:setPosition(ccp(100, 70))
        else
            btn:setPosition(ccp(310, 70))
        end
    end
end

-- eventBus;
function AlertLayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function AlertLayer:__enter()
    -- TODO: do enter things
end

-- render;
function AlertLayer:__render( ... )
    -- body
end

-- exit;
function AlertLayer:__exit()
    -- TODO: do exit things
end

return AlertLayer
