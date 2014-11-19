-- 创建角色视图;
-- @author crazyjohn
-- @date 2014-11-14 22:15:12
--

-- create logger;
local logger = LoggerFactory:getLogger("CreateRoleLayer")
-- create class;
local CreateRoleLayer = class("CreateRoleLayer", function()
    local self = loadUI("CreateRoleUI.json")
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, CreateRoleLayer)
    return self
end)

-- ctor;
function CreateRoleLayer:ctor( ... )
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- eventBus;
function CreateRoleLayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function CreateRoleLayer:__enter()
    -- TODO: do enter things
    self:__addIndex()
end

-- exit;
function CreateRoleLayer:__exit()
    -- TODO: do exit things
    EventBus:removeEventListenersByHost(self)
end

-- declare the field you want to use;
function CreateRoleLayer:__onDeclareVars( ... )
    -- TODO: do declare things
    self.__rightBtn = tolua.cast(UIHelper:seekWidgetByName(self, "rightBtn"), "Button")
    self.__leftBtn = tolua.cast(UIHelper:seekWidgetByName(self, "leftBtn"), "Button")
    self.__headImg1 = tolua.cast(UIHelper:seekWidgetByName(self, "headImg1"), "ImageView")
    self.__headImg2 = tolua.cast(UIHelper:seekWidgetByName(self, "headImg2"), "ImageView")
    self.__headImg3 = tolua.cast(UIHelper:seekWidgetByName(self, "headImg4"), "ImageView")
    self.__occupationName = tolua.cast(UIHelper:seekWidgetByName(self, "occupationLbl"), "Label")
    self.__descLbl = tolua.cast(UIHelper:seekWidgetByName(self, "descLbl"), "Label")
    self.__nameBtn = tolua.cast(UIHelper:seekWidgetByName(self, "nameBtn"), "Button")
    self.__nameTF = tolua.cast(UIHelper:seekWidgetByName(self, "nameTF"), "TextField")
    self.__createBtn = tolua.cast(UIHelper:seekWidgetByName(self, "enterBtn"), "Button")
end

local MAX_INDEX = 3
local MIN_INDEX = 1
local INIT_INDEX = 0
-- 信息表
-- 头像
local headImgTable
-- 职业名字
local occupationNameTable
-- init;
function CreateRoleLayer:__onInit( ... )
    -- TODO: do init things
    self.__currentIndex = INIT_INDEX
    self.__rightBtn:addTouchEventListener(function(touch, event)
        if event == TOUCH_EVENT_ENDED then
            self:__addIndex()
        end
    end)

    self.__leftBtn:addTouchEventListener(function(touch, event)
        if event == TOUCH_EVENT_ENDED then
            self:__reduceIndex()
        end
    end)
    -- 命名按钮
    self.__nameBtn:addTouchEventListener(function(touch, event)
        if event == TOUCH_EVENT_ENDED then
            CGPlayerMessage:CG_AUTO_NAME(DataManager:getModuleDataByName("CreateRoleData"):getCurrentOccupation())
        end
    end)
    -- 创建角色按钮
    self.__createBtn:addTouchEventListener(function(touch, event)
        -- TODO: crazyjohn 创建角色前的必要判断
        --device.showAlert("警告", "角色名不能为空!")
        CGPlayerMessage:CG_CREATE_CHAR(self.__nameTF:getStringValue(), DataManager:getModuleDataByName("CreateRoleData"):getCurrentOccupation())
    end)
    -- 命名事件
    EventBus:addEventListener(EventType.GC_AUTO_NAME, handler(self, self.__updateRoleName), self)
    -- 角色列表事件
    EventBus:addEventListener(EventType.GC_CHAR_LIST, handler(self, self.__onCharList), self)
    -- heaEventBus:addEventListener(EventType.GC_AUTO_NAME, handler(self, self.__updateRoleName), self)dTable
    headImgTable = {self.__headImg1, self.__headImg2, self.__headImg3}
    -- name
    occupationNameTable = {"战士", "刺客", "法师"}

end

-- 更新角色名;
function CreateRoleLayer:__updateRoleName(event)
        self.__nameTF:setText(event.data.roleName)
end

function CreateRoleLayer:__onCharList(event)
    globalExitModule("CreateRoleModule")
end

-- render;
function CreateRoleLayer:__render( ... )
    -- body
    -- headImg
    for i,v in ipairs(headImgTable) do
        if i == self.__currentIndex then
            v:setVisible(true)
        else
            v:setVisible(false)
        end
    end
    -- name
    self.__occupationName:setText(occupationNameTable[self.__currentIndex])
    -- 描述
    self.__descLbl:setText(DataManager:getModuleDataByName("CreateRoleData"):getDescByIndex(self.__currentIndex))
end

function CreateRoleLayer:__addIndex()
    -- body
    self.__currentIndex = self.__currentIndex + 1
    if self.__currentIndex > MAX_INDEX then
        self.__currentIndex = MIN_INDEX
    end
    self:__render()
end

function CreateRoleLayer:__reduceIndex()
    -- body
    self.__currentIndex = self.__currentIndex - 1
    if self.__currentIndex < MIN_INDEX then
        self.__currentIndex = MAX_INDEX
    end
    self:__render()
end

return CreateRoleLayer
