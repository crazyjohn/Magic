-- 登录模块;
-- @author crazyjohn;
-- @date: 2014-10-20

-- 日志
local logger = LoggerFactory:getLogger("LoginModule")
local LoginModule = class("LoginModule")

function LoginModule_enter(params)
	globalEnterModule("LoginModule", params)
end

function LoginModule_exit(params)
	globalExitModule("LoginModule", params)
end

function LoginModule:onEnter(params)
	-- body
	logger:debug("Enter module: " .. self:getModuleName())
	self.__view = requireNewLayer("LoginLayer")
	addViewToModuleLayer(self.__view)
end

function LoginModule:onExit(params)
	logger:debug("Exitd module: %s", self:getModuleName())
	if self.__view 	~= nil then
		removeViewFromModuleLayer(self.__view)
		self.__view = nil
	end
end

function LoginModule:getModuleName()
	return "LoginModule"
end

return LoginModule