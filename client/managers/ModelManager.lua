-- 游戏业务模型管理器;
-- @author crazyjohn
-- @date 2014-11-14 22:35:24
--

-- create logger
local logger = LoggerFactory:getLogger("ModelManager")
-- create class
local ModelManager = class("ModelManager")

-- ctor
function ModelManager:ctor()
    self.__dataModules = {}
    self:__initModels()
end

-- init datas
function ModelManager:__initModels()
	-- body
	-- 创建角色模型对象
	self:registerModel("CreateRoleModel")
end

-- 注册模块数据;
function ModelManager:registerModel(modelName)
	-- body
	local dataModule = requireNewModel(modelName)
	if dataModule == nil then
		logger:error("Can not find this data class: %s", modelName)
		return
	end
	self.__dataModules[modelName] = dataModule
end

-- 根据模型名称获取模型;
function ModelManager:getModelByName(modelName)
	return self.__dataModules[modelName]
end

return ModelManager
