-- 游戏数据管理器;
-- @author crazyjohn
-- @date 2014-11-14 22:35:24
--

-- create logger
local logger = LoggerFactory:getLogger("DataManager")
-- create class
local DataManager = class("DataManager")

-- ctor
function DataManager:ctor()
    self.__dataModules = {}
    self:__initModuleDatas()
end

-- init datas
function DataManager:__initModuleDatas()
	-- body
	-- 创建角色数据
	self:registerModuleData("CreateRoleData")
end

-- 注册模块数据;
function DataManager:registerModuleData(dataModuleName)
	-- body
	local dataModule = requireNewModuleData(dataModuleName)
	if dataModule == nil then
		logger:error("Can not find this data class: %s", dataModuleName)
		return
	end
	self.__dataModules[dataModuleName] = dataModule
end

-- 根据数据模块名称获取数据;
function DataManager:getModuleDataByName(dataModuleName)
	return self.__dataModules[dataModuleName]
end

return DataManager
