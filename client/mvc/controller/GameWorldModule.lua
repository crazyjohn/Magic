-- 游戏世界模块;
-- @author crazyjohn
-- @date 2014-11-06 22:26:18
--

-- create logger;
local logger = LoggerFactory:getLogger("GameWorldModule")
-- create class;
local GameWorldModule = class("GameWorldModule")

-- global enter function;
function GameWorldModule_enter(params)
    globalEnterModule("GameWorldModule", params)
end

-- global exit function;
function GameWorldModule_exit(params)
    globalExitModule("GameWorldModule", params)
end

-- enter callback;
function GameWorldModule:onEnter(params)
    -- TODO:  do enter things
    logger:debug("Enterd module: %s", self:getModuleName())
    self.__view = requireNewLayer("GameWorldSceneLayer")
	addViewToModuleLayer(self.__view)
end

-- exit callback;
function GameWorldModule:onExit(params)
    -- TODO:  do exit things
    logger:debug("Exitd module: %s", self:getModuleName())
    if self.__view 	~= nil then
		removeViewFromModuleLayer(self.__view)
		self.__view = nil
	end
end

-- get module name;
-- @return the name of the module;
function GameWorldModule:getModuleName()
    return "GameWorldModule"
end

return GameWorldModule
