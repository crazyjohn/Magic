-- 全局模块管理器
-- @author crazyjohn;
-- @date: 2014-10-20

-- create logger
local logger = LoggerFactory:getLogger("ModuleManager")
local ModuleManager = class("ModuleManager")
-- 所有已经注册的模块
local modules = {}
local MODULE_PACKAGE = "client.module."

function ModuleManager:ctor( ... )
	self:__initModules()
end

-- 初始化模块;
function ModuleManager:__initModules()
	-- body
	-- 登录模块
	self:registModule("LoginModule")
	-- 创建角色模块
	self:registModule("CreateRoleModule")
	-- 游戏世界模块
	self:registModule("GameWorldModule")
end

-- 进入指定的模块;
-- @param moduleName 模块名称;
-- @param params 进入时传递的参数;
function ModuleManager:enterModule(moduleName, params)
	-- body
	local currentModule = ModuleManager:findModuleByName(moduleName)
	if currentModule == nil then
		-- 提示没有注册此模块
		logger:error("Not registed this module: %s", moduleName)
		return
	end
	currentModule:onEnter(moduleName, params)
end

-- 退出指定的模块;
-- @param moduleName 模块名称;
-- @param params 退出时传入的参数;
function ModuleManager:exitModule(moduleName, params)
	local currentModule = ModuleManager:findModuleByName(moduleName)
	if currentModule == nil then
		-- 提示没有注册此模块
		logger:error("Not registed this module: %s", moduleName)
		return
	end
	currentModule:onExit(moduleName, params)
end

-- 注册模块
-- @param moduleName; 模块名称;
function ModuleManager:registModule(moduleName)
	local module = requireAndNew(MODULE_PACKAGE .. moduleName)
	if module == nil then
		logger:error("Can not find this module class: %s", moduleName)
		return
	end
	modules[module:getModuleName()] = module
end

-- 查找指定的模块;
-- @param moduleName 模块名称;
function ModuleManager:findModuleByName(moduleName)
	return modules[moduleName]
end

return ModuleManager