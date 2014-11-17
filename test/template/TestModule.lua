-- TestModule
-- @author crazyjohn
-- @date 2014-11-06 14:33:41
--

-- create logger;
local logger = LoggerFactory:getLogger("TestModule")
-- create class;
local TestModule = class("TestModule")

-- global enter function;
function TestModule_enter(params)
    globalEnterModule("TestModule", params)
end

-- global exit function;
function TestModule_exit(params)
    globalExitModule("TestModule", params)
end

-- enter callback;
function TestModule:onEnter(params)
    -- TODO:  do enter things
    logger:debug("Enterd module: %s", self:getModuleName())
end

-- exit callback;
function TestModule:onExit(params)
    -- TODO:  do exit things
    logger:debug("Exitd module: %s", self:getModuleName())
end

-- get module name;
-- @return the name of the module;
function TestModule:getModuleName()
    return "TestModule"
end

return TestModule
