-- TestLayer
-- @author crazyjohn
-- @date 2014-11-06 19:38:55
--

-- create logger;
local logger = LoggerFactory:getLogger("TestLayer")
-- create class;
local TestLayer = class("TestLayer", function()
    -- TODO: parse ui file
    --local self = loadUI("TestLayer.json")
    local self = Layout:create()
    local t = tolua.getpeer(self)
    if not t then
        t= {}
        tolua.setpeer(self, t)
    end
    setmetatable(t, TestLayer)
    return self
end)

-- ctor;
function TestLayer:ctor( ... )
    -- 1. declareVar
    self:__onDeclareVars(...)
    -- 2. registEvents
    self:registerScriptHandler(handler(self, self.__eventBus))
    -- 3. init
    self:__onInit(...)
end

-- eventBus;
function TestLayer:__eventBus(event)
    if event == "enter" then
        self:__enter()
    elseif event == "exit" then
        self:__exit()
    end
end

-- enter;
function TestLayer:__enter()
    -- TODO: do enter things
end

-- exit;
function TestLayer:__exit()
    -- TODO: do exit things
end

-- declare the field you want to use;
function TestLayer:__onDeclareVars( ... )
    -- TODO: do declare things
    -- eg: self.__account = tolua.cast(UIHelper:seekWidgetByName(self, "account"), "TextField")
   
end

-- init;
function TestLayer:__onInit( ... )
    -- TODO: do init things
end

return TestLayer
