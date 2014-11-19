-- 创建角色模块;
-- @author crazyjohn
-- @date 2014-11-14 22:15:25
--

-- create logger;
local logger = LoggerFactory:getLogger("CreateRoleModule")
-- create class;
local CreateRoleModule = class("CreateRoleModule")

-- global enter function;
function CreateRoleModule_enter(params)
    globalEnterModule("CreateRoleModule", params)
end

-- global exit function;
function CreateRoleModule_exit(params)
    globalExitModule("CreateRoleModule", params)
end

-- enter callback;
function CreateRoleModule:onEnter(params)
    -- TODO:  do enter things
    logger:debug("Enterd module: %s", self:getModuleName())
    self.__view = requireNewLayer("CreateRoleLayer")
	addViewToModuleLayer(self.__view)
end

-- exit callback;
function CreateRoleModule:onExit(params)
    -- TODO:  do exit things
    logger:debug("Exitd module: %s", self:getModuleName())
    if self.__view 	~= nil then
		removeViewFromModuleLayer(self.__view)
		self.__view = nil
	end
end

-- get module name;
-- @return the name of the module;
function CreateRoleModule:getModuleName()
    return "CreateRoleModule"
end

return CreateRoleModule
